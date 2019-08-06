import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/pages/home.dart';
import 'package:githao/widgets/loading_state.dart';
import 'package:githao/utils/util.dart';

import 'load_more_data_footer.dart';
import 'my_visibility.dart';

/// [perPageRows] 每次请求期望返回的数据量，GitHub默认每次返回30条数据；
/// [needLoadMore] 为true时，提供上拉加载更多特性；
class MyReposWidget extends StatefulWidget{
  final perPageRows = 30;
  final bool needLoadMore;
  final String homeDrawerMenu;
  MyReposWidget({Key key, this.homeDrawerMenu, this.needLoadMore=true,}): super(key: key);
  @override
  _MyReposWidgetState createState() => _MyReposWidgetState();
}

class _MyReposWidgetState extends State<MyReposWidget> {
  final List<RepoEntity> _repos = [];
  int _page = 1;
  StateFlag _loadingState = StateFlag.idle;
  bool _expectHasMoreData = true;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  Future<void> _loadData({bool isReload=true}) async {
    if(_loadingState == StateFlag.loading) return null;
    setState(() {
      _loadingState = StateFlag.loading;
    });
    int expectationPage;
    if (isReload) {
      expectationPage = 1;
    } else {
      expectationPage = _page + 1;
    }
    Future<List<RepoEntity>> future;
    if(widget.homeDrawerMenu == HomeDrawer.MENU_MY_REPOS) {
      future = ApiService.getRepos(page: expectationPage);
    } else if(widget.homeDrawerMenu == HomeDrawer.MENU_STARRED_REPOS) {
      future = ApiService.getStarredRepos(page: expectationPage);
    }
    return future.then<bool>((list) {
      setState(() {
        if (isReload) { //初始加载或下拉刷新数据
          this._repos
            ..clear()
            ..addAll(list);
          _page = 1;
        } else { //上拉加载更多数据
          if(list.isNotEmpty) {
            this._repos.addAll(list);
            ++_page;
          }
        }
        //判断是否还有更多数据
        this._expectHasMoreData = list.length >= widget.perPageRows;
        if(isReload && list.isEmpty) {
          this._loadingState = StateFlag.empty;
        } else {
          this._loadingState = StateFlag.complete;
        }
      });
      return;
    }).catchError((e) {
      if(isReload) {
        setState(() {
          _repos.clear();
          this._loadingState = StateFlag.error;
        });
      }
      Util.showToast(e is DioError ? e.message : e.toString());
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        MyVisibility(
          flag: this._loadingState != StateFlag.empty && this._loadingState != StateFlag.error ? MyVisibilityFlag.visible : MyVisibilityFlag.gone,
          child: Container(
            child: RefreshIndicator(
              key: _refreshIndicatorKey,
              color: Colors.blue,
              onRefresh: _loadData,
              child: NotificationListener(
                onNotification: (ScrollNotification notification) {
                  if(widget.needLoadMore && _expectHasMoreData) { //是否需要实现加载更多特性
                    if(0 == notification.metrics.extentAfter) { //到达底部
                      _loadData(isReload: false);
                    }
                  }
                  return false; //返回false，将事件传递给外层控件(RefreshIndicator)，否则外层RefreshIndicator无法监听到下拉手势
                },
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(height: 4, color: Theme.of(context).primaryColor,);
                  },
                  padding: EdgeInsets.all(0.0),
                  itemCount: (_repos.length >= widget.perPageRows && widget.needLoadMore) ? _repos.length+1 : _repos.length,
                  itemBuilder: (context, index) {
                    if(index < _repos.length) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('index：$index'),
                          Text('name: ${_repos[index].name}'),
                          Text('language: ${_repos[index].language}'),
                          Text('description: ${_repos[index].description}'),
                          Text('pushedAt: ${_repos[index].pushedAt}'),
                        ],
                      );
                    } else {
                      return LoadMoreDataFooter(_expectHasMoreData);
                    }
                  },
                ),
              ),
            ),
          ),
        ),
        LoadingState(_loadingState,
          onRetry: (){
            _refreshIndicatorKey.currentState.show();
          },
        ),
      ],
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}