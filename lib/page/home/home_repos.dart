import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:githao/network/entity/repos/repos_queries_entity.dart';
import 'package:githao/network/github_service.dart';
import 'package:githao/util/prefs_manager.dart';
import 'package:githao/util/string_extension.dart';
import 'package:githao/network/entity/repos/repo_entity.dart';

class HomeRepos extends StatefulWidget {
  const HomeRepos({Key? key}) : super(key: key);

  @override
  _HomeReposState createState() => _HomeReposState();
}

class _HomeReposState extends State<HomeRepos> {
  final List<RepoEntity> _repos = [];
  int _stackIndex = 0;
  ReposQueriesEntity _queries = ReposQueriesEntity.authedUser();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData({bool isLoadMore = false}) async {
    if(_isLoading) return;
    _isLoading = true;
    if(isLoadMore) {
      _queries.page += 1;
    } else {
      _queries.page = 1;
    }
    try {
      final result = await githubService.getMyRepos(
          queries: _queries,
          cacheable: _stackIndex == 0
      );
      if(_queries.page == 1) {
        _repos.clear();
      } else if(_queries.page > 1 && result.isEmpty) {
        _queries.page -= 1;
      }
      _repos.addAll(result);
      if (mounted) {
        setState(() {
          _isLoading = false;
          _stackIndex = 1;
        });
      }
    } catch(e) {

    } finally {
      _isLoading = false;
    }
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IndexedStack(
        index: _stackIndex,
        children: [
          Center(child: CupertinoActivityIndicator(
            radius: 20,
          )),
          RefreshIndicator(
            onRefresh: _loadData,
            child: ListView.separated(
              itemCount: (_repos.length % _queries.perPage) == 0 ? _repos.length + 1: _repos.length,
              itemBuilder: (context, index) {
                if(index < _repos.length) {
                  return _buildItem(_repos[index]);
                } else {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    _loadData(isLoadMore: true);
                  });
                  return Center(child: CupertinoActivityIndicator(),);
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

  Widget _buildItem(RepoEntity repoEntity) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24.0,
              backgroundImage: CachedNetworkImageProvider(repoEntity.owner!.avatarUrl!),
            ),
            SizedBox(
              width: 8,
            ),
            Text(repoEntity.private.toString()),
            Text('/' + repoEntity.name!),
            Expanded(child: Text('/' + repoEntity.owner!.login.nullSafety)),
          ],
        ),
      ],
    );
  }
}
