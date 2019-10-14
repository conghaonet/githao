import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:githao/biz/user_biz.dart';

import 'package:githao/generated/i18n.dart';
import 'package:githao/pages/issues.dart';
import 'package:githao/pages/profile.dart';
import 'package:githao/pages/common_search.dart';
import 'package:githao/pages/settings.dart';
import 'package:githao/provide/user_provide.dart';
import 'package:githao/routes/profile_page_args.dart';
import 'package:githao/utils/util.dart';
import 'package:githao/widgets/trending_repos.dart';
import 'package:githao/widgets/user_repos.dart';
import 'package:githao/widgets/starred_repos.dart';
import 'package:provide/provide.dart';

import 'login.dart';

class HomePage extends StatefulWidget {
  static const ROUTE_NAME = "/home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final _defaultMenu = HomeDrawer.MENU_MY_REPOS;
  String _clickedDrawerMenu = _defaultMenu;
  StreamController<String> _bodyController;

  @override
  void initState() {
    super.initState();
    _bodyController = StreamController<String>.broadcast();
  }

  void onClickDrawerMenu(String menuName) {
    setState(() {
      this._clickedDrawerMenu = menuName;
      _bodyController.add(this._clickedDrawerMenu);
/*
      if(_clickedDrawerMenu == HomeDrawer.MENU_MY_REPOS) {
        _bodyController.add(HomeDrawer.MENU_MY_REPOS);
      } else if(_clickedDrawerMenu == HomeDrawer.MENU_STARRED_REPOS) {
        _bodyController.add(HomeDrawer.MENU_STARRED_REPOS);
      } else if(_clickedDrawerMenu == HomeDrawer.MENU_TRENDING_UP) {
        _bodyController.add(HomeDrawer.MENU_TRENDING_UP);
      }
*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(onClickDrawerMenu, _clickedDrawerMenu ?? _defaultMenu),
      body: Container(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: StreamBuilder<String>(
                  stream: _bodyController.stream,
                  initialData: _defaultMenu,
                  builder: (context, snapshot) {
                    if(snapshot.data == HomeDrawer.MENU_STARRED_REPOS) {
                      return Text(S.current.starredRepos);
                    } else if(snapshot.data == HomeDrawer.MENU_TRENDING_UP) {
                      return Text(S.current.trending);
                    } else {
                      return Text(S.current.myRepos);
                    }
                  },
                ),
                titleSpacing: NavigationToolbar.kMiddleSpacing, //标题四周间距
                primary: true,  //是否预留高度
                snap:true,   //与floating结合使用
                floating: true,//是否随着滑动隐藏标题，为true时，当有下滑手势的时候就会显示SliverAppBar
                pinned: false,//为true时，SliverAppBar折叠后不消失
/*
                  expandedHeight: 0, // 展开的高度
                  //性设置 SliverAppBar 的背景
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(S.current.myRepos),
                    centerTitle: true,
                    collapseMode: CollapseMode.parallax, // 背景折叠动画
                    background: Image.asset(
                      'images/banner1.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
*/
              ),
            ];
          },
          body: StreamBuilder<String>(
            stream: _bodyController.stream,
            initialData: _defaultMenu,
            builder: (context, snapshot) {
              if(snapshot.data == HomeDrawer.MENU_STARRED_REPOS) {
                return StarredReposWidget(user: Provide.value<UserProvide>(context).user);
              } else if(snapshot.data == HomeDrawer.MENU_TRENDING_UP) {
                return TrendingReposWidget(user: Provide.value<UserProvide>(context).user);
              } else {
                return UserReposWidget(login: Provide.value<UserProvide>(context).user.login);
              }
            },
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _bodyController.close();
    super.dispose();
  }
}

class HomeDrawer extends StatefulWidget{
  static const MENU_MY_REPOS = "MY_REPOS";
  static const MENU_STARRED_REPOS = "STARRED_REPOS";
  static const MENU_TRENDING_UP = "TRENDING_UP";
  final Function(String) callback;
  final String lastClickedMenu;
  HomeDrawer(this.callback, this.lastClickedMenu, {Key key}): super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}
class _HomeDrawerState extends State<HomeDrawer> with SingleTickerProviderStateMixin {
  AnimationController _refreshController;
  String _clickedMenu;

  @override
  void initState() {
    super.initState();
    this._clickedMenu = widget.lastClickedMenu;
    _refreshController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this, //vsync 会防止屏幕外动画（动画的UI不在当前屏幕时）消耗不必要的资源
    );
  }

  /// 手动刷新用户数据
  void refreshUserData() {
    _refreshController.repeat();
    UserBiz.getUser(forceRefresh: true)
        .then((userEntity) {
          if(userEntity != null) {
            Provide.value<UserProvide>(context).updateUser(userEntity);
            Util.showToast(S.current.userDataHasBeanRefreshed);
          } else {
            Util.showToast(S.current.refreshFailedCheckNetwork);
          }
          _refreshController.stop(canceled: true);
        })
        .catchError((e) {
          Util.showToast((e as DioError).message);
          _refreshController.stop(canceled: true);
        }, test: (e) => e is DioError)
        .catchError((e) {
          Util.showToast(e.toString());
          _refreshController.stop(canceled: true);
        });
  }
  void onClickMenu(String menu) {
    if(menu != _clickedMenu) {
      _clickedMenu = menu;
      widget.callback(menu);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      color: Theme.of(context).primaryColor,
      child: Column(
        children: <Widget>[
          _drawerHeader(),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.info_outline,),
                    title: Text(S.current.issues,),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(IssuesPage.ROUTE_NAME);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.storage,),
                    title: Text(S.current.myRepos,),
                    onTap: () {
                      onClickMenu(HomeDrawer.MENU_MY_REPOS);
                    },
                    selected: _clickedMenu == null || _clickedMenu == HomeDrawer.MENU_MY_REPOS,
                  ),
                  ListTile(
                    leading: Icon(Icons.star,),
                    title: Text(S.current.starredRepos,),
                    onTap: () {
                      onClickMenu(HomeDrawer.MENU_STARRED_REPOS);
                    },
                    selected: _clickedMenu == HomeDrawer.MENU_STARRED_REPOS,
                  ),
                  ListTile(
                    leading: Icon(Icons.trending_up,),
                    title: Text(S.current.trending,),
                    onTap: () {
                      onClickMenu(HomeDrawer.MENU_TRENDING_UP);
                    },
                    selected: _clickedMenu == HomeDrawer.MENU_TRENDING_UP,
                  ),
                  ListTile(
                    leading: Icon(Icons.search,),
                    title: Text(S.current.search,),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(CommonSearchPage.ROUTE_NAME);
                    },
                  ),
                  Divider(height: 1, color: Theme.of(context).primaryColor,),
                  ListTile(
                    leading: Icon(Icons.settings,),
                    title: Text(S.current.settings,),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(SettingsPage.ROUTE_NAME);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app,),
                    title: Text(S.current.logout,),
                    onTap: () {
                      UserBiz.logout();
                      Navigator.of(context).pushReplacementNamed(LoginPage.ROUTE_NAME);
                    },
                  ),
/*
                  ListTile(
                    leading: Icon(Icons.info,),
                    title: Text(S.current.about,),
                    onTap: () {},
                  ),
*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _drawerHeader() {
    return Provide<UserProvide>(
      builder: (context, child, userProvide) {
        String heroTag = userProvide.user.login;
        return UserAccountsDrawerHeader(
          currentAccountPicture: InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context, ProfilePage.ROUTE_NAME,
                arguments: ProfilePageArgs(
                  userEntity: userProvide.user,
                  heroTag: heroTag,
                ),
              );
            },
            child: Hero(
              //默认情况下，当在 iOS 上按后退按钮时，hero 动画会有效果，但它们在手势滑动时并没有。
              //要解决此问题，只需在两个 Hero 组件上将 transitionOnUserGestures 设置为 true 即可
              transitionOnUserGestures: true,
              tag: heroTag,
              child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(userProvide.user.avatarUrl),
              ),
            ),
          ),
          accountName: Text('${userProvide.user.login}'),
          accountEmail: Text('${userProvide.user.email}'),
          otherAccountsPictures: <Widget>[
            RotationTransition(
              turns: _refreshController,
              child: IconButton(
                icon: Icon(Icons.refresh, color: Colors.white,),
                onPressed: () {
                  refreshUserData();
                },
              ),
            ),
          ],
        );
      },
    );
  }
  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
