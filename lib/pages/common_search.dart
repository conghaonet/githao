import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/utils/util.dart';
import 'package:githao/widgets/common_search_delegate.dart';

class CommonSearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/common_search';
  @override
  _CommonSearchPageState createState() => _CommonSearchPageState();
}

class _CommonSearchPageState extends State<CommonSearchPage> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _getTabTitles().length, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(mounted) {
        Future.delayed(const Duration(milliseconds: 100)).then((_) {
          if(mounted) {
            showSearch<String>(context: context, delegate: CommonSearchDelegate());
          }
        });
      }
    });
  }

  List<String> _getTabTitles() {
    return <String>[S.current.repositories, S.current.users];
  }

  @override
  Widget build(BuildContext context) {
/*
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.search),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.search), onPressed: () async {
            String query = await showSearch<String>(context: context, delegate: CommonSearchDelegate());
            Util.showToast(query ?? 'query is null');
          }),
        ],
      ),
      body: Container(
        color: Colors.red,
      ),
    );
*/
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [
            SliverAppBar(
              title: Text(S.current.search,),
              actions: <Widget>[
                IconButton(icon: const Icon(Icons.search), onPressed: () async {
                  String query = await showSearch<String>(context: context, delegate: CommonSearchDelegate());
                  Util.showToast(query ?? 'query is null');
                }),
              ],
              floating: true, //是否随着滑动隐藏标题，为true时，当有下滑手势的时候就会显示SliverAppBar
              snap:true,   //与floating结合使用
              pinned: true, //为true时，SliverAppBar折叠后不消失
            ),
            SliverPersistentHeader(
              pinned: false,
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
            children: <Widget>[
              Text(S.current.repositories),
              Text(S.current.users),
            ],
          ),
        ),
      ),
    );
  }
}

/// 定义tab栏高度
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Container _tabBar;
  _SliverAppBarDelegate(this._tabBar);
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(child: _tabBar,);
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