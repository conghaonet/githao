import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/pages/profile.dart';
import 'package:githao/pages/repo_home.dart';
import 'package:githao/resources/custom_icons_icons.dart';
import 'package:githao/resources/lang_colors.dart';
import 'package:githao/routes/profile_page_args.dart';
import 'package:githao/widgets/loading_state.dart';
import 'package:githao/utils/util.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) => refreshIndicatorKey.currentState.show());
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
    String avatarHeroTag = '${_repos[index].owner.login}$index';
    return Card(
      margin: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: (index +1 == _repos.length) ? 8 : 0),
      child: FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: (){
          Navigator.pushNamed(context, RepoHomePage.ROUTE_NAME, arguments: this._repos[index].fullName);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context, ProfilePage.ROUTE_NAME,
                    arguments: ProfilePageArgs(
                        userEntity: _repos[index].owner,
                        heroTag: avatarHeroTag
                    ),
                  );
                },
                child: Hero(
                  //默认情况下，当在 iOS 上按后退按钮时，hero 动画会有效果，但它们在手势滑动时并没有。
                  //要解决此问题，只需在两个 Hero 组件上将 transitionOnUserGestures 设置为 true 即可
                  transitionOnUserGestures: true,
                  tag: avatarHeroTag,
                  child: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(_repos[index].owner.avatarUrl),
                    backgroundColor: Colors.black12,
                  ),
                ),
              ),
              SizedBox(width: 16,),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Offstage(
                          offstage: !_repos[index].fork,
                          child: Icon(CustomIcons.fork, color: Theme.of(context).primaryColor, size: 18,),
                        ),
                        Expanded(
                          child: Text(_repos[index].name,
                            maxLines: 2,
                            style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4,),
                    MyVisibility(
                      flag: _repos[index].description == null ? MyVisibilityFlag.gone : MyVisibilityFlag.visible,
                      child: Text(_repos[index].description ?? '',
                        maxLines: 4,
                        softWrap: true,
                        style: TextStyle(),
                      ),
                    ),
                    SizedBox(height: 8,),
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: <Widget>[
                        _getOwner(_repos[index].owner.login),
                        _getIssues(_repos[index].openIssues),
                        //抓包发现watchers和stargazersCount数值完全一样，应该是GitHub的bug
//                      _getWatchers(_repos[index].watchers),
                        _getStargazersCount(_repos[index].stargazersCount),
                        _getForks(_repos[index].forks),
                        _getLanguage(_repos[index].language),
                        _getPushedTime(_repos[index].pushedAt),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _getOwner(String owner) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.account_circle, color: Theme.of(context).primaryColor, size: 18,),
        SizedBox(width: 2,),
        Text(owner),
      ],
    );
  }
  Widget _getIssues(int issues) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.info, color: Theme.of(context).primaryColor, size: 18,),
        SizedBox(width: 2,),
        Text('$issues'),
      ],
    );
  }
  Widget _getStargazersCount(int count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.stars, color: Theme.of(context).primaryColor, size: 18,),
        SizedBox(width: 2,),
        Text('$count'),
      ],
    );
  }
  Widget _getForks(int forks) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(CustomIcons.fork, color: Theme.of(context).primaryColor, size: 18,),
        SizedBox(width: 2,),
        Text('$forks'),
      ],
    );
  }
  Widget _getLanguage(String language) {
    if(language != null && language.isNotEmpty) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: langColors.getColor(language),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 2,),
          Text(language),
        ],
      );
    } else {
      return Offstage(offstage: true,);
    }
  }
  Widget _getPushedTime(String time) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.access_time, color: Theme.of(context).primaryColor, size: 18,),
        SizedBox(width: 2,),
        Text('Pushed on ${Util.getFriendlyDateTime(time) ?? ''}'),
      ],
    );
  }
  @override
  void dispose() {
    super.dispose();
  }

}