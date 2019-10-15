import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/issue_entity.dart';
import 'package:githao/pages/profile_page.dart';
import 'package:githao/provide/user_provide.dart';
import 'package:githao/routes/profile_page_args.dart';
import 'package:githao/utils/util.dart';
import 'package:githao/widgets/load_more_data_footer.dart';
import 'package:githao/widgets/loading_state.dart';
import 'package:provide/provide.dart';

class IssuesPage extends StatefulWidget {
  static const ROUTE_NAME = '/issues';
  final perPageRows = 30;
  final String repoName;

  IssuesPage({this.repoName, Key key}): super(key: key);

  @override
  _IssuesPageState createState() => _IssuesPageState();
}

class _IssuesPageState extends State<IssuesPage> {
  static const _stack_index_data = 0;
  static const _stack_index_empty = 1;
  static const _stack_index_error = 2;
  bool _showFilter = false;
  int _indexFilterState = 1;
  int _indexFilterSort = 0;
  List<String> _filterStates;
  static final _filterSorts = [{'sort': 'updated', 'order': 'desc'}, {'sort': 'updated', 'order': 'asc'}
                                , {'sort': 'created', 'order': 'desc'}, {'sort': 'created', 'order': 'asc'}];

  final List<IssueEntity> _results = [];
  bool _lastActionIsReload = true;
  int _page = 1;
  StateFlag _loadingState = StateFlag.idle;
  bool _expectHasMoreData = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _filterStates = widget.repoName == null ? ['+state:open+state:closed', '+state:open','+state:closed'] : ['all', 'open', 'closed'];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(mounted) {
        _refreshIndicatorKey.currentState.show();
      }
    });
  }

  Future<void> _loadData({bool isReload = true}) async {
    if(_loadingState == StateFlag.loading) return null;
    setState(() {
      _lastActionIsReload = isReload;
      _loadingState = StateFlag.loading;
    });
    int expectationPage;
    if (isReload) {
      expectationPage = 1;
    } else {
      expectationPage = _page + 1;
    }
    Future apiFuture;
    if(widget.repoName == null) {
      apiFuture = ApiService.searchIssues(
          login: Provide.value<UserProvide>(context).user.login,
          state: _filterStates[_indexFilterState],
          sort: _filterSorts[_indexFilterSort]['sort'],
          order: _filterSorts[_indexFilterSort]['order'],
          page: expectationPage);
    } else {
      apiFuture = ApiService.getRepoIssues(
          repoName: widget.repoName,
          state: _filterStates[_indexFilterState],
          sort: _filterSorts[_indexFilterSort]['sort'],
          order: _filterSorts[_indexFilterSort]['order'],
          page: expectationPage);
    }
    return apiFuture.then((list){
      if(isReload) {
        _results.clear();
        _page = 1;
      }
      if(list.isNotEmpty) {
        this._results.addAll(list);
        if (!isReload) {
          ++_page;
        }
      }
      //判断是否还有更多数据
      this._expectHasMoreData = list.length >= widget.perPageRows;
      if(isReload && list.isEmpty) {
        this._loadingState = StateFlag.empty;
      } else {
        this._loadingState = StateFlag.complete;
      }
      if(mounted) {setState(() {});}
      return;
    }).catchError((e) {
      this._loadingState = StateFlag.error;
      if(isReload) {
        _page = 1;
        _results.clear();
      }
      if(mounted) {setState(() {});}
      Util.showToast(e is DioError ? e.message : e.toString());
      return;
    });
  }
  int getStackIndex() {
    if(_loadingState == StateFlag.error && _lastActionIsReload) {
      return _stack_index_error;
    } else if(_loadingState == StateFlag.empty) {
      return _stack_index_empty;
    } else {
      return _stack_index_data;
    }
  }

  void filterCallback(String group, int index) {
    setState(() {
      _showFilter = false;
    });
    if(group.isNotEmpty) {
      if(group == IssuesFilterWidget.GROUP_STATE) {
        _indexFilterState = index;
      } else if(group == IssuesFilterWidget.GROUP_SORT) {
        _indexFilterSort = index;
      }
      _refreshIndicatorKey.currentState.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.issues),
      ),
      body: Container(
        child: IndexedStack(
          index: getStackIndex(),
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  child: RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: _loadData,
                    child: ListView.builder(
                      itemCount: _results.length >= widget.perPageRows ? _results.length+1 : _results.length,
                      itemBuilder: (context, index) {
                        if(index < _results.length) {
                          return getItem(_results[index], index);
                        } else {
                          if(_expectHasMoreData && _loadingState == StateFlag.complete) {
                            Future.delayed(const Duration(milliseconds: 100)).then((_){
                              _loadData(isReload: false);
                            });
                          }
                          return LoadMoreDataFooter(_expectHasMoreData, flag: _loadingState, onRetry: () {
                            _loadData(isReload: false);
                          },);
                        }
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 16,
                  child: FloatingActionButton(
                    backgroundColor:  _loadingState == StateFlag.loading ? Colors.grey : Theme.of(context).primaryColor,
                    child: Icon(Icons.sort),
                    onPressed: _loadingState == StateFlag.loading ? null : () {
                      setState(() {
                        _showFilter = true;
                      });
                    },
                  ),
                ),
                Offstage(
                  offstage: !_showFilter,
                  child: IssuesFilterWidget(filterCallback, this._indexFilterState, this._indexFilterSort),
                ),
              ],
            ),
            LoadingState(StateFlag.empty,
              onRetry: (){
                _refreshIndicatorKey.currentState.show();
              },
            ),
            LoadingState(StateFlag.error,
              onRetry: (){
                _refreshIndicatorKey.currentState.show();
              },
            ),
          ],
        ),
      ),
    );
  }
  Widget getItem(IssueEntity entity, int index) {
    String heroTag = '${entity.noteId}_${entity.id}';
    return InkWell(
      onTap: () {
        //TODO: goto IssueDetailPage
      },
      child: Card(
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context, ProfilePage.ROUTE_NAME,
                        arguments: ProfilePageArgs(
                            userEntity: entity.user,
                            heroTag: heroTag
                        ),
                      );
                    },
                    child: Hero(
                      //默认情况下，当在 iOS 上按后退按钮时，hero 动画会有效果，但它们在手势滑动时并没有。
                      //要解决此问题，只需在两个 Hero 组件上将 transitionOnUserGestures 设置为 true 即可
                      transitionOnUserGestures: true,
                      tag: heroTag,
                      child: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(entity.user.avatarUrl),
                        backgroundColor: Colors.black12,
                      ),
                    ),
                  ),
                  SizedBox(width: 8,),
                  Text(entity.user.login,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  Spacer(),
                  Text(Util.getFriendlyDateTime(entity.updatedAt), style: TextStyle(color: Colors.black54),),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(entity.title, maxLines: 2, overflow: TextOverflow.ellipsis,),
              ),
              Row(
                children: <Widget>[
                  Text('${entity.repositoryUrl.split('/repos/')[1]} #${entity.number}',
                    style: TextStyle(color: Colors.black54),),
                  Spacer(),
                  Icon(Icons.comment, color: Colors.black54,),
                  SizedBox(width: 4.0,),
                  Text('${entity.comments}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IssuesFilterWidget extends StatefulWidget {
  static const GROUP_STATE = "state";
  static const GROUP_SORT = "sort";
  final Function(String ,int) callback;
  final int defaultStateIndex;
  final int defaultSortIndex;
  IssuesFilterWidget(this.callback, this.defaultStateIndex, this.defaultSortIndex, {Key key}): super(key: key);

  @override
  _IssuesFilterWidgetState createState() => _IssuesFilterWidgetState();
}

class _IssuesFilterWidgetState extends State<IssuesFilterWidget> {
  int _indexFilterState;
  int _indexFilterSort;
  @override
  void initState() {
    super.initState();
    _indexFilterState = widget.defaultStateIndex;
    _indexFilterSort = widget.defaultSortIndex;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.callback("", -1);
      },
      child: Container(
        color: Colors.black45,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: <Widget>[
            Spacer(),
            Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16, 0, 8),
                      child: Text(
                        S.current.state,
                        style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.w700),),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Row(
                      children: <Widget>[
                        buildStateItem(S.current.all, 0),
                        buildStateItem(S.current.open, 1),
                        buildStateItem(S.current.closed, 2),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16, 0, 8),
                      child: Text(
                        S.current.sort,
                        style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.w700),),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Row(
                      children: <Widget>[
                        buildSortItem(S.current.updated, Icons.trending_down, 0),
                        buildSortItem(S.current.updated, Icons.trending_up, 1),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 16, 16, 32),
                    child: Row(
                      children: <Widget>[
                        buildSortItem(S.current.created, Icons.trending_down, 2),
                        buildSortItem(S.current.created, Icons.trending_up, 3),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget buildStateItem(String text, int index) {
    return Expanded(
      child: InkWell(
        onTap: () {
          this._indexFilterState = index;
          widget.callback(IssuesFilterWidget.GROUP_STATE, index);
        },
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: _indexFilterState == index ? Theme.of(context).primaryColorDark : Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(text,
              style: TextStyle(fontSize:18, color: _indexFilterState == index ? Colors.white : Colors.black45),
            ),
          ),
        ),
      ),
    );
  }
  Widget buildSortItem(String text, IconData iconData, int index) {
    return Expanded(
      child: InkWell(
        onTap: () {
          this._indexFilterSort = index;
          widget.callback(IssuesFilterWidget.GROUP_SORT, index);
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: _indexFilterSort == index ? Theme.of(context).primaryColorDark : Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(text,
                  style: TextStyle(fontSize:18, color: _indexFilterSort == index ? Colors.white : Colors.black45),
                ),
                Icon(iconData, color: _indexFilterSort == index ? Colors.white : Colors.black45,),
              ],
            ),
          ),
        ),
      ),
    );
  }

}