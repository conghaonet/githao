import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/resources/lang_colors.dart';
import 'package:githao/utils/util.dart';
import 'package:githao/widgets/events/events.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RepoHomePage extends StatefulWidget {
  static const ROUTE_NAME = '/repo';
  final RepoEntity repo;
  RepoHomePage(this.repo, {Key key}): super(key: key);

  @override
  _RepoHomePageState createState() => _RepoHomePageState();
}

class _RepoHomePageState extends State<RepoHomePage> with TickerProviderStateMixin {
  final colors = <Color>[Colors.red, Colors.green, Colors.blue, Colors.pink, Colors.yellow, Colors.deepPurple];
  TabController _tabController;

  static List<String> _getTabTitles() {
    return <String>[S.current.infoUppercase, S.current.filesUppercase, S.current.commitsUppercase, S.current.activityUppercase,];
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _RepoHomePageState._getTabTitles().length, vsync: this);
    _tabController.addListener(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text('${widget.repo.name}', style: TextStyle(fontSize: 18),),
                titleSpacing: 0,
                centerTitle: false,
                floating: true, //是否随着滑动隐藏标题，为true时，当有下滑手势的时候就会显示SliverAppBar
                snap:true,   //与floating结合使用
                pinned: false, //为true时，SliverAppBar折叠后不消失
                forceElevated: innerBoxIsScrolled,
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
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
//              TabViewDemo(title: _getTabTitles()[2]),
              RepoInfo(widget.repo),
              EventList(
                key: PageStorageKey<String>(_getTabTitles()[1]), // like 'Tab 1'
                login: widget.repo.owner.login,),
              EventList(
                key: PageStorageKey<String>(_getTabTitles()[2]), // like 'Tab 1'
                login: widget.repo.owner.login,),
              EventList(
                key: PageStorageKey<String>(_getTabTitles()[3]), // like 'Tab 1'
                login: widget.repo.owner.login,),
            ]
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class TabViewDemo extends StatelessWidget {
  final colors = <Color>[Colors.red, Colors.green, Colors.blue, Colors.pink, Colors.yellow, Colors.deepPurple];
  final String title;
  TabViewDemo({this.title, Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // key 保证唯一性
      key: PageStorageKey<String>(title),
      slivers: <Widget>[
        // 将子部件同 `SliverAppBar` 重叠部分顶出来，否则会被遮挡
        SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
        SliverGrid(
            delegate: SliverChildBuilderDelegate((_, index) => Image.asset('images/banner2.jpg'),
                childCount: 8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, mainAxisSpacing: 10.0, crossAxisSpacing: 10.0)),
        SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
                    (_, index) => Container(
                    child: Text('$title - item${index + 1}',
                        style: TextStyle(fontSize: 20.0, color: colors[index % 6])),
                    alignment: Alignment.center),
                childCount: 15),
            itemExtent: 50.0)
      ],
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

class RepoInfo extends StatefulWidget {
  final RepoEntity repo;
  RepoInfo(this.repo, {Key key}): super(key: key);

  @override
  _RepoInfoState createState() => _RepoInfoState();
}

class _RepoInfoState extends State<RepoInfo> {
  String readme;
  @override
  void initState() {
    super.initState();
    ApiService.getRepoReadme(widget.repo.owner.login, widget.repo.name).then((result) {
      if(mounted) {
        setState(() {
          readme = result;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${widget.repo.fullName}'),
              Text('${widget.repo.description}', maxLines: 4, overflow: TextOverflow.ellipsis,),
              Text('${S.current.createdAt(Util.getFriendlyDateTime(widget.repo.createdAt))}'),
              Text('${S.current.pushedAt(Util.getFriendlyDateTime(widget.repo.pushedAt))}'),
              Text('${S.current.license}: ${widget.repo.license.name}'),
              Offstage(
                offstage: widget.repo.language == null,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Text('${widget.repo.language}'),
                    SizedBox(width: 4,),
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: langColors.getColor(widget.repo.language ?? 'C'),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
//        Html(data: readme ?? ''),
/*
        Card(
          child: Html(data: readme),
        ),
*/
      ],
    );
  }
}