import 'package:flutter/material.dart';
import 'package:githao/network/entity/user_entity.dart';

class ProfilePage extends StatefulWidget {
  static const ROUTE_NAME = '/profile';
  final String login;
  ProfilePage(this.login, {Key key}): super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  bool isAuthenticatedUser;
  //要达到缓存目的，必须实现AutomaticKeepAliveClientMixin的wantKeepAlive为true。
  // 不会被销毁,占内存中
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    super.build(context); //混入AutomaticKeepAliveClientMixin后，必须添加
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [
            SliverAppBar(
//            title: Text(widget.login),
//            centerTitle: true,
              primary: true,
              floating: true, //是否随着滑动隐藏标题，为true时，当有下滑手势的时候就会显示SliverAppBar
              snap:false,   //与floating结合使用
              pinned: false, //为true时，SliverAppBar折叠后不消失
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(widget.login),
                centerTitle: true,
                collapseMode: CollapseMode.parallax, // 背景折叠动画
                background: Image.asset('images/banner1.jpg',
                  fit: BoxFit.cover,
                  color: Theme.of(context).primaryColor.withOpacity(0.9),
                  colorBlendMode: BlendMode.modulate,
                ),
              ),
/*
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(icon: Icon(Icons.cake), text: '左侧'),
                  Tab(icon: Icon(Icons.timer), text: '中间'),
                  Tab(icon: Icon(Icons.description), text: '右侧'),
                ],
                controller: _tabController,
              ),
*/
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                TabBar(
                  labelColor: Colors.red,
                  unselectedLabelColor: Colors.grey,
                  controller: _tabController,
                  tabs: [
                    Tab(child: Text('child 左侧'),),
                    Tab(child: Text('child 中间'),),
                    Tab(child: Text('child 右侧'),),
                  ],
                ),
              ),
            ),
          ],
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Container(
                child: Center(child: Text('tab1'),),
              ),
              Container(
                child: Center(child: Text('tab1'),),
              ),
              Container(
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
              ),
            ],
          ),
        ),
      ),
    );
  }


  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  _SliverAppBarDelegate(this._tabBar);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

}