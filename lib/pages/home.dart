import 'package:flutter/material.dart';

import 'package:githao/generated/i18n.dart';
class HomePage extends StatefulWidget {
  static const ROUTE_NAME = "/home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: homeDrawer(),
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

  static Widget homeDrawer() {
    return Container(
      width: 300,
      color: Colors.white,
      child: ListView(children: <Widget>[
        _drawerHeader(),
        new ClipRect(
          child: new ListTile(
            leading: new CircleAvatar(child: new Text("A")),
            title: new Text('Drawer item A'),
            onTap: () => {},
          ),
        ),
        new ListTile(
          leading: new CircleAvatar(child: new Text("B")),
          title: new Text('Drawer item B'),
          subtitle: new Text("Drawer item B subtitle"),
          onTap: () => {},
        ),
        new AboutListTile(
          icon: new CircleAvatar(child: new Text("Ab")),
          child: new Text("About"),
          applicationName: "Test",
          applicationVersion: "1.0",
          applicationIcon: new Image.asset(
            "images/ymj_jiayou.gif",
            width: 64.0,
            height: 64.0,
          ),
          applicationLegalese: "applicationLegalese",
          aboutBoxChildren: <Widget>[
            new Text("BoxChildren"),
            new Text("box child 2")
          ],
        ),
      ]),
    );
  }

  static Widget _drawerHeader() {
    return new UserAccountsDrawerHeader(
//      margin: EdgeInsets.zero,
      accountName: new Text(
        "SuperLuo",
      ),
      accountEmail: new Text(
        "super_luo@163.com",
      ),
      currentAccountPicture: new CircleAvatar(
        backgroundImage: new AssetImage("images/camera.png"),
      ),
      onDetailsPressed: () {},
      otherAccountsPictures: <Widget>[
        new CircleAvatar(
          backgroundImage: new AssetImage("images/camera2.png"),
        ),
      ],
    );
  }
}