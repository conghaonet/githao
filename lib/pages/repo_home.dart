import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:githao/events/repo_home_event.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/resources/lang_colors.dart';
import 'package:githao/routes/webview_page_args.dart';
import 'package:githao/utils/util.dart';
import 'package:githao/widgets/commits.dart';
import 'package:githao/widgets/events/events.dart';
import 'package:githao/widgets/file_explorer.dart';
import 'package:githao/widgets/loading_state.dart';
import 'package:githao/widgets/repo_info_count_data.dart';
import 'package:githao/events/app_event_bus.dart';
import 'web_view_page.dart';

class RepoHomePage extends StatefulWidget {
  static const ROUTE_NAME = '/repo';
  final String repoFullName;
  RepoHomePage(this.repoFullName, {Key key}): super(key: key);

  @override
  _RepoHomePageState createState() => _RepoHomePageState();
}

class _RepoHomePageState extends State<RepoHomePage> with TickerProviderStateMixin {
  TabController _tabController;
  int _tabIndex;
  RepoEntity _repoEntity;
  StateFlag _loadingState = StateFlag.idle;

  List<String> _getTabTitles() {
    return <String>[S.current.infoUppercase, S.current.filesUppercase, S.current.commitsUppercase, S.current.activityUppercase,];
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _getTabTitles().length, vsync: this);
    _tabController.addListener(() {
      //tabBar和tabBody公用一个controller，避免重复发广播，这里判断下。
      if(_tabIndex != _tabController.index) {
        _tabIndex = _tabController.index;
        eventBus.fire(RepoHomeTabChangedEvent(_tabIndex));
      }
    });
    _loadData();
  }

  Future<void> _loadData() async {
    if(_loadingState == StateFlag.loading) return Future;
    if(mounted) {
      setState(() {
        _loadingState = StateFlag.loading;
      });
    }
    return ApiService.getRepo(widget.repoFullName).then((entity) {
      _repoEntity = entity;
      if(mounted) {
        setState(() {
          _loadingState = StateFlag.complete;
        });
      }
    }).catchError((e) {
      this._loadingState = StateFlag.error;
      if(mounted) {setState(() {});}
      Util.showToast(e is DioError ? e.message : e.toString());
    }).whenComplete(() {
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxScrolled) => [
              SliverAppBar(
                title: Text(widget.repoFullName.split('/')[1],),
                floating: true, //是否随着滑动隐藏标题，为true时，当有下滑手势的时候就会显示SliverAppBar
                snap:true,   //与floating结合使用
                pinned: false, //为true时，SliverAppBar折叠后不消失
              ),
              SliverPersistentHeader(
                pinned: false,
                delegate: _SliverAppBarDelegate( this._loadingState,
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
            body: Stack(
              children: <Widget>[
                Offstage(
                  offstage: this._loadingState != StateFlag.complete,
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      _repoEntity != null ? RepoInfo(_repoEntity) : Container(),
                      _repoEntity != null ? FileExplorer(_repoEntity) : Container(),
                      _repoEntity != null ? CommitList(_repoEntity) : Container(),
                      _repoEntity != null ? EventList(
                        login: _repoEntity.owner.login,
                        repoName: _repoEntity.name,
                      ) : Container(),
                    ],
                  ),
                ),
                Offstage(
                  offstage: this._loadingState != StateFlag.loading,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                LoadingState(_loadingState,
                  onRetry: (){
                    _loadData();
                  },
                ),
              ],
            ),
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

class RepoInfo extends StatefulWidget {
  final RepoEntity repo;
  RepoInfo(this.repo, {Key key}): super(key: key);

  @override
  _RepoInfoState createState() => _RepoInfoState();
}

class _RepoInfoState extends State<RepoInfo> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${widget.repo.fullName}',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),
                    ),
                    SizedBox(height: 8,),
                    Row(
                      children: <Widget>[
                        Icon(Icons.account_circle, color: Theme.of(context).primaryColorDark,),
                        SizedBox(width: 8,),
                        Expanded(
                          child: Text('${widget.repo.owner.login}${widget.repo.owner.isUser ? '' : '(${S.current.orgUppercase})'}',
                            style: TextStyle(fontSize: 22, color: Theme.of(context).primaryColorDark),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8,),
                    RepoInfoCountData(widget.repo),
                    Offstage(
                      offstage: widget.repo.language == null,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: <Widget>[
                            Text('${widget.repo.language}', style: TextStyle(fontSize: 16),),
                            SizedBox(width: 4,),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: langColors.getColor('${widget.repo.language}'),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8,),
                    Text('${S.current.createdAt(Util.getFriendlyDateTime(widget.repo.createdAt))}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8,),
                    Text('${S.current.pushedAt(Util.getFriendlyDateTime(widget.repo.pushedAt))}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Offstage(
                      offstage: widget.repo.license == null,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          '${S.current.license}: ${widget.repo.license?.name}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 8,),
                    FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        Navigator.pushNamed(context, WebViewPage.ROUTE_NAME,
                            arguments: WebViewPageArgs(url: 'https://github.com/${widget.repo.fullName}/blob/${widget.repo.defaultBranch}/README.md'),
                        );
                      },
                      child: Text('README',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 22,
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.solid,
                          decorationThickness: 1.5,
                        ),
                      ),
                    ),
                    Offstage(
                      offstage: widget.repo.description==null || widget.repo.description.isEmpty,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text('${widget.repo.description}',),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 定义tab栏高度
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Container _tabBar;
  final int tabIndex;
  final StateFlag _loadingState;
  _SliverAppBarDelegate(this._loadingState, this._tabBar, {this.tabIndex});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(child: _tabBar,);
  }
  @override
  double get maxExtent => _loadingState == StateFlag.complete ? 48 : 0;
  @override
  double get minExtent => _loadingState == StateFlag.complete ? 48 : 0;
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}