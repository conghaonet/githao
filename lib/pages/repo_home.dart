import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/widgets/events/events.dart';

class RepoHomePage extends StatefulWidget {
  static const ROUTE_NAME = '/repo';
  final RepoEntity repo;
  RepoHomePage(this.repo, {Key key}): super(key: key);

  @override
  _RepoHomePageState createState() => _RepoHomePageState();
}

class _RepoHomePageState extends State<RepoHomePage> {
  final colors = <Color>[Colors.red, Colors.green, Colors.blue, Colors.pink, Colors.yellow, Colors.deepPurple];

  List<String> _getTabTitles() {
    return <String>[S.current.infoUppercase, S.current.filesUppercase, S.current.commitsUppercase, S.current.activityUppercase,];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: _getTabTitles().length,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                // 传入 handle 值，直接通过 `sliverOverlapAbsorberHandleFor` 获取即可
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverAppBar(
                  pinned: true,
//                  title: Text(widget.repo.name),
                  expandedHeight: 150.0,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(tabs: _getTabTitles().map((title) => Text(title, style: TextStyle(fontSize: 15.0))).toList()),
                  flexibleSpace: FlexibleSpaceBar(background: Image.asset('images/banner1.jpg', fit: BoxFit.cover)),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: _getTabTitles()
            // 这边需要通过 Builder 来创建 TabBarView 的内容，否则会报错
            // NestedScrollView.sliverOverlapAbsorberHandleFor must be called with a context that contains a NestedScrollView.
                .map((tab) => Builder(
              builder: (context) => CustomScrollView(
                // key 保证唯一性
                key: PageStorageKey<String>(tab),
                slivers: <Widget>[
                  // 将子部件同 `SliverAppBar` 重叠部分顶出来，否则会被遮挡
                  SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
                  SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                              (_, index) => Image.asset('images/banner2.jpg'),
                          childCount: 8),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, mainAxisSpacing: 10.0, crossAxisSpacing: 10.0)),
                  SliverFixedExtentList(
                      delegate: SliverChildBuilderDelegate(
                              (_, index) => Container(
                              child: Text('$tab - item${index + 1}',
                                  style: TextStyle(fontSize: 20.0, color: colors[index % 6])),
                              alignment: Alignment.center),
                          childCount: 15),
                      itemExtent: 50.0)
                ],
              ),
            )).toList(),
          ),
        ),
      ),
    );
  }
}