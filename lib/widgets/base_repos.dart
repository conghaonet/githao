import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/widgets/loading_state.dart';
import 'package:githao/utils/util.dart';
import 'package:githao/widgets/repo_item.dart';

import 'load_more_data_footer.dart';
import 'my_visibility.dart';

abstract class BaseReposWidget extends StatefulWidget {
  final perPageRows = 30;
  final bool needLoadMore;
  BaseReposWidget({Key key, this.needLoadMore=true,}): super(key: key);

  @protected
  BaseReposWidgetState createState();
}

abstract class BaseReposWidgetState<T extends BaseReposWidget> extends State<T> with AutomaticKeepAliveClientMixin {
  final List<RepoEntity> _repos = [];
  bool _lastActionIsReload = true;
  int _page = 1;
  StateFlag _loadingState = StateFlag.idle;
  bool _expectHasMoreData = true;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  Future<List<RepoEntity>> getRepos(final int expectationPage);
  Widget getFilter();

  //要达到缓存目的，必须实现AutomaticKeepAliveClientMixin的wantKeepAlive为true。
  // 不会被销毁,占内存中
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(mounted) {
        refreshIndicatorKey.currentState.show();
      }
    });
  }

  Future<void> _loadData({bool isReload = true}) async {
    if(_loadingState == StateFlag.loading) return Future;
    _lastActionIsReload = isReload;
    if(mounted) {
      setState(() {
        _loadingState = StateFlag.loading;
        if(isReload) {
          _expectHasMoreData = false;
        }
      });
    }

    int expectationPage;
    if (isReload) {
      expectationPage = 1;
    } else {
      expectationPage = _page + 1;
    }
    Future<List<RepoEntity>> future = getRepos(expectationPage);
    return future.then<void>((list) {
      if(isReload) {
        _repos.clear();
        _page = 1;
        if(mounted) {setState(() {});}
      }
      return Future.delayed(const Duration(milliseconds: 100)).then((_) {
        if(list.isNotEmpty) {
          this._repos.addAll(list);
          if (!isReload) {
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
        if(mounted) {setState(() {});}
        return;
      });
    }).catchError((e) {
      this._loadingState = StateFlag.error;
      if(isReload) {
        _page = 1;
        _repos.clear();
      }
      if(mounted) {setState(() {});}
      Util.showToast(e is DioError ? e.message : e.toString());
    }).whenComplete(() {
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: <Widget>[
        Container(
          color: this._loadingState == StateFlag.complete ? Theme.of(context).primaryColorLight : Colors.white,
          child: RefreshIndicator(
            key: refreshIndicatorKey,
            color: Theme.of(context).primaryColor,
            onRefresh: _loadData,
            child: MyVisibility(
              flag: this._lastActionIsReload && (this._loadingState == StateFlag.empty || this._loadingState == StateFlag.error) ? MyVisibilityFlag.invisible : MyVisibilityFlag.visible,
              child: NotificationListener<ScrollEndNotification>(
                onNotification: (notification) {
                  if (notification.depth != 0) return false;
                  if (notification.metrics.axisDirection != AxisDirection.down) return false;
                  if(0 == notification.metrics.extentAfter) { //到达底部
                    if(widget.needLoadMore && _expectHasMoreData) { //是否需要实现加载更多特性
                      _loadData(isReload: false);
                      return true;
                    }
                  }
                  return false; //返回false，将事件传递给外层控件(RefreshIndicator)，否则外层RefreshIndicator无法监听到下拉手势
                },
                child: ListView.builder(
                  padding: EdgeInsets.all(0.0),
                  itemCount: (_repos.length >= widget.perPageRows && widget.needLoadMore) ? _repos.length+1 : _repos.length,
                  itemBuilder: (context, index) {
                    if(index < _repos.length) {
                      return _getRepoItem(index);
                    } else {
                      return LoadMoreDataFooter(_expectHasMoreData, flag: _loadingState, onRetry: (){
                        _loadData(isReload: false);
                      },);
                    }
                  },
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 12,
          right: 16,
          child: FloatingActionButton(
            backgroundColor:  _loadingState == StateFlag.loading ? Colors.grey : Theme.of(context).primaryColor,
            child: Icon(Icons.sort),
            onPressed: _loadingState == StateFlag.loading ? null : () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return AnimatedPadding(
                    padding: MediaQuery.of(context).viewInsets,  //边距（必要）
                    duration: const Duration(milliseconds: 100), //时常 （必要）
                    child: getFilter(),
                  );
                },
              );
            },
          ),
        ),
        LoadingState(_lastActionIsReload ? _loadingState : StateFlag.idle,
          onRetry: (){
            refreshIndicatorKey.currentState.show();
          },
        ),
      ],
    );
  }

  Widget _getRepoItem(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4,),
      child: RepoItem(_repos[index], tag: 'base_repo_$index',),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }

}