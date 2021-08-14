import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:githao/generated/l10n.dart';
import 'package:githao/network/entity/repo/repos_queries_entity.dart';
import 'package:githao/network/github_service.dart';
import 'package:githao/network/entity/repo/repo_entity.dart';
import 'package:githao/util/const.dart';
import 'package:githao/widget/error_view.dart';
import 'package:githao/widget/load_more_footer.dart';
import 'package:githao/widget/repo_item_view.dart';

class HomeRepos extends StatefulWidget {
  const HomeRepos({Key? key}) : super(key: key);

  @override
  _HomeReposState createState() => _HomeReposState();
}

class _HomeReposState extends State<HomeRepos> {
  final List<RepoEntity> _repos = [];
  int _pageNo = 1;
  int _stackIndex = 0;
  ReposQueriesEntity _queries = ReposQueriesEntity();
  bool _cacheEnable = true;
  final ScrollController _scrollController = ScrollController();
  LoadState _loadState = LoadState.idle;
  late final StreamController<LoadState> _streamController;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<LoadState>();
    _scrollController.addListener(() {
      if(_loadState == LoadState.error && _scrollController.offset == _scrollController.position.maxScrollExtent) {
        setState(() {
          _loadState = LoadState.finished;
        });
      }
    });
    _loadData();
  }

  Future<void> _loadData({bool isLoadMore = false}) async {
    if (_loadState == LoadState.loading) return;
    _loadState = LoadState.loading;
    int tempPageNo = _pageNo;
    if (isLoadMore) ++tempPageNo;

    try {
      final result = await githubService.getMyRepos(
        queries: _queries,
        page: tempPageNo,
        cacheable: _cacheEnable,
      );
      if (tempPageNo == 1) {
        _repos.clear();
      } else if (tempPageNo > 1 && result.isEmpty) {
        --tempPageNo;
      }
      _pageNo = tempPageNo;
      _repos.addAll(result);
      _loadState = LoadState.finished;
      _stackIndex = 2;
    } catch (e) {
      _loadState = LoadState.error;
      if(isLoadMore) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent - 60,
          duration: Duration(milliseconds: 300),
          curve: Curves.decelerate,
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(S.of(context).something_went_wrong),
          duration: const Duration(seconds: 2),
        ));
      } else {
        _stackIndex = 1;
      }
    } finally {
      _cacheEnable = false;
      if(mounted) {
        setState(() {
        });
      }
    }
    return Future.value();
  }

  void tryAgain() {
    setState(() {
      _stackIndex = 0;
      _loadData();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IndexedStack(
        index: _stackIndex,
        children: [
          Center(child: CupertinoActivityIndicator(radius: 16,),),
          Center(child: ErrorView(callback: tryAgain,)),
          RefreshIndicator(
            onRefresh: _loadData,
            child: ListView.separated(
              controller: _scrollController,
              itemCount: (_repos.isNotEmpty && (_repos.length % _queries.perPage) == 0) ? _repos.length + 1 : _repos.length,
              itemBuilder: (context, index) {
                if (index < _repos.length) {
                  return RepoItemView(_repos[index]);
                } else {
                  if(_loadState == LoadState.finished) {
                    Future.delayed(const Duration(milliseconds: 100), () {
                      _loadData(isLoadMore: true);
                    });
                  }
                  return LoadMoreFooter();
                }
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 0.5,
                  thickness: 0.5,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _streamController.close();
    super.dispose();
  }
}
