import 'package:flutter/material.dart';
import 'package:githao/biz/user_biz.dart';

import 'package:githao/generated/i18n.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/provide/user_provide.dart';
import 'package:githao/utils/util.dart';
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
      drawer: _homeDrawer(),
      body: CustomScrollView(
        //cacheExtent: 30, //窗口在可见区域之前和之后有一个区域，用于缓存用户滚动时即将可见的项目。
        slivers: <Widget>[
          SliverAppBar(
//              title: Text(S.of(context).myRepos),
            expandedHeight: 240, // 展开的高度
            titleSpacing: NavigationToolbar.kMiddleSpacing,
//              primary: true,  //是否预留高度
            snap:false,   //与floating结合使用
            floating: false,//是否随着滑动隐藏标题，为true时，当有下滑手势的时候就会显示SliverAppBar
            pinned: true,//为true时，SliverAppBar折叠后不消失
            //性设置 SliverAppBar 的背景
            flexibleSpace: FlexibleSpaceBar(
              title: Text(S.of(context).myRepos),
              centerTitle: true,
              collapseMode: CollapseMode.parallax, // 背景折叠动画
              background: Image.asset(
                'images/banner1.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: Text('list item $index'),
              );
            },
            ),
          ),
        ],
      ),
    );
  }

  Widget _homeDrawer() {
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

  static Widget _drawerHeader() {
    return Provide<UserProvide>(
      builder: (context, child, userProvide) {
        return UserAccountsDrawerHeader(
          accountName: Text('${userProvide.user.login}'),
          accountEmail: Text('${userProvide.user.email}'),
          currentAccountPicture:  CircleAvatar(
            backgroundImage: NetworkImage(userProvide.user.avatarUrl),
          ),
          otherAccountsPictures: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh, color: Colors.white,),
              onPressed: () async {
                UserEntity userEntity = await UserBiz.getUser(forceRefresh: true);
                if(userEntity != null) {
                  Provide.value<UserProvide>(context).updateUser(userEntity);
                } else {
                  Util.showToast(S.of(context).refreshFailedCheckNetwork);
                }
              },
            ),
          ],
        );
      },
    );
  }
}