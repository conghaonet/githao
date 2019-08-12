import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/event_entity.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/provide/user_provide.dart';
import 'package:githao/routes/profile_page_args.dart';
import 'package:githao/widgets/load_more_data_footer.dart';
import 'package:githao/widgets/loading_state.dart';
import 'package:intl/intl.dart';
import 'package:provide/provide.dart';

class ProfilePage extends StatefulWidget {
  static const ROUTE_NAME = '/profile';
  final ProfilePageArgs args;
  ProfilePage(this.args, {Key key}): super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  bool _isAuthenticatedUser = false;
  UserEntity _userEntity;

  //要达到缓存目的，必须实现AutomaticKeepAliveClientMixin的wantKeepAlive为true。
  // 不会被销毁,占内存中
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.args.userEntity.isUser ? 3 : 2, vsync: this);
    _tabController.addListener(() {
    });
    ApiService.getUser(widget.args.userEntity.login).then((user){
      if(mounted) {
        setState(() {
          this._userEntity = user;
          if(Provide.value<UserProvide>(context).user.login == _userEntity.login) {
            _isAuthenticatedUser = true;
          }
        });
      }
    });
  }

  List<String> _getTabTitles() {
    List<String> titles = [S.current.infoUppercase, S.current.activityUppercase,];
    if(widget.args.userEntity.isUser) {
      titles.add(S.current.starredUppercase);
    }
    return titles;
  }

  List<Widget> _getTabViews() {
    List<Widget> widgets = [_getInfoTabBarView(), EventList(login: widget.args.userEntity.login)];
    if(widget.args.userEntity.isUser) {
      widgets.add(_getStarredTabView());
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); //混入AutomaticKeepAliveClientMixin后，必须添加
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [
            SliverAppBar(
              primary: true,
              floating: true, //是否随着滑动隐藏标题，为true时，当有下滑手势的时候就会显示SliverAppBar
              snap:false,   //与floating结合使用
              pinned: false, //为true时，SliverAppBar折叠后不消失
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(widget.args.userEntity.login),
                centerTitle: true,
                collapseMode: CollapseMode.parallax, // 背景折叠动画
                background: _appBarBackground(),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                Container(
                  color: Theme.of(context).primaryColor,
                  child: TabBar(
                    indicatorColor: Theme.of(context).primaryColorLight,
                    controller: _tabController,
                    tabs: _getTabTitles().map((title) => Tab(child: Text(title),)).toList(growable: false),
                  ),
                ),
              ),
            ),
          ],
          body: TabBarView(
            controller: _tabController,
            children: _getTabViews(),
          ),
        ),
      ),
    );
  }

  Widget _appBarBackground() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl: widget.args.userEntity.avatarUrl,
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.7),
            colorBlendMode: BlendMode.srcOver,),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: widget.args.heroTag,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: CachedNetworkImageProvider(widget.args.userEntity.avatarUrl)),
                  ),
                ),
              ),
              SizedBox(width: 16,),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Offstage(
                      offstage: this._userEntity?.name == null,
                      child: Text(this._userEntity?.name ?? '',
                        style: TextStyle(color: Colors.white, fontSize: 18,),
                      ),
                    ),
                    Offstage(
                      offstage: this._userEntity?.location == null,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.location_on, color: Colors.white, size: 16,),
                          Expanded(
                            child: Text(this._userEntity?.location ?? '',
                              softWrap: true,
                              maxLines: 3,
                              style: TextStyle(color: Colors.white, fontSize: 16,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getInfoTabBarView() {
    if(_userEntity == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      DateTime createdAt = DateTime.parse(_userEntity.createdAt).toLocal();
      DateTime updatedAt = DateTime.parse(_userEntity.updatedAt).toLocal();
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      return Container(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Offstage(
                offstage: this._userEntity.login == null,
                child: Wrap(
                  children: <Widget>[
                    Icon(this._userEntity.isUser ? Icons.account_circle : Icons.group),
                    SizedBox(width: 4,),
                    Text(this._userEntity.login ?? '',
                      style: TextStyle(fontSize: 18,),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Text(S.current.createdAt(dateFormat.format(createdAt)),
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              SizedBox(height: 8,),
              Text(S.current.updatedAt(dateFormat.format(updatedAt)),
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              Offstage(
                offstage: this._userEntity.email == null,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.email, color: Theme.of(context).primaryColorDark),
                      SizedBox(width: 8,),
                      Expanded(
                        child: Text(this._userEntity.email ?? '',
                          style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Offstage(
                offstage: this._userEntity.blog == null || this._userEntity.blog.isEmpty,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.link, color: Theme.of(context).primaryColorDark),
                      SizedBox(width: 8,),
                      Expanded(
                        child: Text(this._userEntity.blog ?? '',
                          style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16,),
              Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Column(
                          children: <Widget>[
                            Text('${_userEntity.followers}', style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,),),
                            Text(S.current.followers, style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Column(
                          children: <Widget>[
                            Text('${_userEntity.following}', style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,),),
                            Text(S.current.following, style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Column(
                          children: <Widget>[
                            Text('${_userEntity.publicRepos}', style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColorDark,fontWeight: FontWeight.bold,),),
                            Text(S.current.repositories, style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Column(
                          children: <Widget>[
                            Text('${_userEntity.publicGists ?? 0}', style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold,),),
                            Text(S.current.gists, style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Text(_userEntity.bio == null ? '' : '${_userEntity.bio}', maxLines: 5, style: TextStyle(fontSize: 16),),
            ],
          )
        ),
      );
    }
  }

  Widget _getStarredTabView() {
    return Container(
      child: RefreshIndicator(
        onRefresh: () {
          return;
        },
        child: ListView.builder(
          itemCount: 99,
          itemBuilder: (context, index) {
            return Container(
              width: double.infinity,
              height: 50,
              child: Text("index $index"),
            );
          },
        ),
      ),
    );
  }
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

/// 定义tab栏高度
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Container _tabBar;
  _SliverAppBarDelegate(this._tabBar);
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }
  @override
  double get maxExtent => 48;
  @override
  double get minExtent => 48;
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class EventList extends StatefulWidget {
  final perPageRows = 30;
  final bool needLoadMore;
  final String login;

  EventList({Key key, this.login, this.needLoadMore=true,}): super(key: key);
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> with AutomaticKeepAliveClientMixin {
  final List<EventEntity> _results = [];
  int _page = 1;
  StateFlag _loadingState = StateFlag.idle;
  bool _expectHasMoreData = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  //要达到缓存目的，必须实现AutomaticKeepAliveClientMixin的wantKeepAlive为true。
  // 不会被销毁,占内存中
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  Future<void> _loadData({bool isReload=true}) async {
    if(_loadingState == StateFlag.loading) return null;
    _loadingState = StateFlag.loading;
    int expectationPage;
    if (isReload) {
      expectationPage = 1;
    } else {
      expectationPage = _page + 1;
    }

    return ApiService.getEvents(widget.login, page: expectationPage).then((list){
      if(isReload) {
        _results.clear();
        _page = 1;
      }
      if(list.isNotEmpty) {
        this._results.addAll(list);
        if (!isReload) {
          ++_page;
        }
      }
      //判断是否还有更多数据
      this._expectHasMoreData = list.length >= widget.perPageRows;
      if(mounted) {
        setState(() {
          if(isReload && list.isEmpty) {
            this._loadingState = StateFlag.empty;
          } else {
            this._loadingState = StateFlag.complete;
          }
        });
      }
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); //混入AutomaticKeepAliveClientMixin后，必须添加
    return Container(
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _loadData,
        child: ListView.builder(
          itemCount: _expectHasMoreData ? _results.length+1 : _results.length,
          itemBuilder: (context, index) {
            if(index < _results.length) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("index = $index"),
                  Text("type = ${_results[index].type}"),
                  Text("type = ${_results[index].repo.name}"),
                ],
              );
            } else {
              Future.delayed(const Duration(milliseconds: 100)).then((_){
                _loadData(isReload: false);
              });
              return LoadMoreDataFooter(_expectHasMoreData);
            }
          },
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}