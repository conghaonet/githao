import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:githao/biz/user_biz.dart';

import 'package:githao/generated/i18n.dart';
import 'package:githao/provide/user_provide.dart';
import 'package:githao/utils/util.dart';
import 'package:githao/widgets/my_repos_widget.dart';
import 'package:provide/provide.dart';

import 'login.dart';
class HomePage extends StatefulWidget {
  static const ROUTE_NAME = "/home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text(S.of(context).myRepos),
//            expandedHeight: 240, // 展开的高度
              titleSpacing: NavigationToolbar.kMiddleSpacing, //标题四周间距
//              primary: true,  //是否预留高度
              snap:false,   //与floating结合使用
              floating: true,//是否随着滑动隐藏标题，为true时，当有下滑手势的时候就会显示SliverAppBar
              pinned: false,//为true时，SliverAppBar折叠后不消失
              //性设置 SliverAppBar 的背景
/*
              flexibleSpace: FlexibleSpaceBar(
                title: Text(S.of(context).myRepos),
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
        body: MyReposWidget(),
      ),
    );
  }
}

class HomeDrawer extends StatefulWidget{
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> with SingleTickerProviderStateMixin {
  AnimationController _refreshController;
  @override
  void initState() {
    super.initState();
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
            Util.showToast(S.of(context).userDataHasBeanRefreshed);
          } else {
            Util.showToast(S.of(context).refreshFailedCheckNetwork);
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
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      color: Colors.white,
      child: ListView(children: <Widget>[
        _drawerHeader(),
        Material(
          color: Colors.white,
          child: ListTile(
            leading: Icon(Icons.storage,),
            title: Text(S.of(context).myRepos,),
            onTap: () {},
            selected: true,
          ),
        ),
        Material(
          color: Colors.white,
          child: ListTile(
            leading: Icon(Icons.star,),
            title: Text(S.of(context).starredRepos,),
            onTap: () {},
          ),
        ),
        Material(
          color: Colors.white,
          child: ListTile(
            leading: Icon(Icons.trending_up,),
            title: Text(S.of(context).trending,),
            onTap: () {},
          ),
        ),
        Divider(height: 1, color: Theme.of(context).primaryColor,),
        Material(
          color: Colors.white,
          child: ListTile(
            leading: Icon(Icons.settings,),
            title: Text(S.of(context).settings,),
            onTap: () {},
          ),
        ),
        Material(
          color: Colors.white,
          child: ListTile(
            leading: Icon(Icons.exit_to_app,),
            title: Text(S.of(context).logout,),
            onTap: () {
              UserBiz.logout();
              Navigator.of(context).pushReplacementNamed(LoginPage.ROUTE_NAME);
            },
          ),
        ),
        Material(
          color: Colors.white,
          child: ListTile(
            leading: Icon(Icons.info,),
            title: Text(S.of(context).about,),
            onTap: () {},
          ),
        ),
      ]),
    );
  }
  Widget _drawerHeader() {
    return Provide<UserProvide>(
      builder: (context, child, userProvide) {
        return UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(userProvide.user.avatarUrl),
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
