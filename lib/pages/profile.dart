import 'package:flutter/material.dart';
import 'package:githao/network/entity/user_entity.dart';

class ProfilePage extends StatefulWidget {
  static const ROUTE_NAME = '/profile';
  final String login;
  ProfilePage(this.login, {Key key}): super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxScrolled) => [
          SliverAppBar(
//            title: Text(widget.login),
//            centerTitle: true,
            floating: true, //是否随着滑动隐藏标题，为true时，当有下滑手势的时候就会显示SliverAppBar
            snap:true,   //与floating结合使用
            pinned: true, //为true时，SliverAppBar折叠后不消失
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.login),
              centerTitle: true,
              collapseMode: CollapseMode.parallax, // 背景折叠动画
              background: Image.asset(
                'images/banner1.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
        body: RefreshIndicator(
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
      ),
    );
  }
}