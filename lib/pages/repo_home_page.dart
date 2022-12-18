import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:githao/events/repo_home_event.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/resources/app_const.dart';
import 'package:githao/resources/lang_colors.dart';
import 'package:githao/routes/webview_page_args.dart';
import 'package:githao/utils/util.dart';
import 'package:githao/widgets/commits.dart';
import 'package:githao/widgets/events/events.dart';
import 'package:githao/widgets/file_explorer.dart';
import 'package:githao/widgets/loading_state.dart';
import 'package:githao/widgets/repo_info_count_data.dart';
import 'package:githao/events/app_event_bus.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'web_view_page.dart';

class RepoHomePage extends StatefulWidget {
  static const ROUTE_NAME = '/repo_home';
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
  bool _isStarred;
  bool _isWatched;

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

    ApiService.getStarredRepo(widget.repoFullName).then((isStarred) {
      setState(() {
        _isStarred = isStarred;
      });
    });
    ApiService.getSubscriptionsRepo(widget.repoFullName).then((isWatched) {
      setState(() {
        _isWatched = isWatched;
      });
    });

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

  void _onClickStar(bool isStar) {
    ApiService.startOrUnstarRepo(widget.repoFullName, isStar);
  }
  void _onClickWatch(bool isWatched) {
    ApiService.subscriptionsOrUnsubscriptionsRepo(widget.repoFullName, isWatched).then((result){
      if(result) {
        if(isWatched) {
          Util.showToast(S.current.watched);
        } else {
          Util.showToast(S.current.unwatched);
        }
      }
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
                title: Text(widget.repoFullName.split('/')[1], style: TextStyle(fontSize: 18),),
                titleSpacing: 0,
                floating: true, //是否随着滑动隐藏标题，为true时，当有下滑手势的时候就会显示SliverAppBar
                snap:true,   //与floating结合使用
                pinned: false, //为true时，SliverAppBar折叠后不消失
                actions: _buildActions(),
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

  List<Widget> _buildActions() {
    return _repoEntity == null ? null : <Widget>[
      if(_isStarred != null)
        IconButton(
          icon: Icon(_isStarred ? Icons.star : Icons.star_border, color: Colors.white,),
          onPressed: (){
            setState(() {
              _isStarred = !_isStarred;
            });
            _onClickStar(_isStarred);
          },
        ),
      PopupMenuButton(
        itemBuilder: (BuildContext context) {
          return <PopupMenuItem<String>>[
            if(_isWatched != null)
              PopupMenuItem<String>(child: Text(_isWatched ? S.current.unwatch : S.current.watch), value: "watch",),
            PopupMenuItem<String>(child: Text(S.current.share), value: "share",),
            PopupMenuItem<String>(child: Text(S.current.openInBrowser), value: "browser",),
            PopupMenuItem<String>(child: Text(S.current.copyRepoUrl), value: "copy",),
          ];
        },
        onSelected: (String action) async {
          switch (action) {
            case "share":
              Share.share(_repoEntity.htmlUrl);
              break;
            case "browser":
              if(await canLaunch(_repoEntity.htmlUrl)) {
                await launch(_repoEntity.htmlUrl);
              }
              break;
            case "copy":
              ClipboardData data = new ClipboardData(text: _repoEntity.htmlUrl);
              Clipboard.setData(data);
              Util.showToast(_repoEntity.htmlUrl);
              break;
            case "watch":
              setState(() {
                _isWatched = !_isWatched;
              });
              _onClickWatch(_isWatched);
              break;
          }
        },
        onCanceled: () {
          print("onCanceled");
        },
      ),
    ];
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
                    SelectableText('${widget.repo.fullName}',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),
                    ),
                    if(widget.repo.fork)
                      Container(
                        padding: EdgeInsets.only(top: 12),
                        child: InkWell(
                          child: Text(
                            S.current.forkedToViewTheParentRepository,
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, RepoHomePage.ROUTE_NAME, arguments: widget.repo.parent.fullName);
                          },
                        ),
                      ),
                    SizedBox(height: 12,),
                    Row(
                      children: <Widget>[
                        Icon(widget.repo.owner.isUser ? Icons.account_circle : Icons.group,),
                        SizedBox(width: 8,),
                        Expanded(
                          child: SelectableText('${widget.repo.owner.login}${widget.repo.owner.isUser ? '' : '(${S.current.orgUppercase})'}',
                            style: TextStyle(fontSize: 22,),
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
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: langColors.getColor('${widget.repo.language}'),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 4,),
                            Text('${widget.repo.language}', style: TextStyle(fontSize: 16),),
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
                    ElevatedButton(
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
                        child: SelectableText('${widget.repo.description}',),
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
  // final int tabIndex;
  final StateFlag _loadingState;
  _SliverAppBarDelegate(this._loadingState, this._tabBar);
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(child: _tabBar,);
  }
  @override
  double get maxExtent => _loadingState == StateFlag.complete ? AppConst.TAB_HEIGHT : 0;
  @override
  double get minExtent => _loadingState == StateFlag.complete ? AppConst.TAB_HEIGHT : 0;
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}