import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/issue_entity.dart';
import 'package:githao/pages/profile.dart';
import 'package:githao/provide/user_provide.dart';
import 'package:githao/routes/profile_page_args.dart';
import 'package:githao/utils/util.dart';
import 'package:githao/widgets/load_more_data_footer.dart';
import 'package:githao/widgets/loading_state.dart';
import 'package:githao/widgets/my_visibility.dart';
import 'package:provide/provide.dart';

class IssuesPage extends StatefulWidget {
  static const ROUTE_NAME = '/issues';
  final perPageRows = 30;

  @override
  _IssuesPageState createState() => _IssuesPageState();
}

class _IssuesPageState extends State<IssuesPage> {
  final List<IssueEntity> _results = [];
  bool _lastActionIsReload = true;
  int _page = 1;
  StateFlag _loadingState = StateFlag.idle;
  bool _expectHasMoreData = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(mounted) {
        _refreshIndicatorKey.currentState.show();
      }
    });
  }

  Future<void> _loadData({bool isReload = true}) async {
    if(_loadingState == StateFlag.loading) return null;
    _lastActionIsReload = isReload;
    _loadingState = StateFlag.loading;
    int expectationPage;
    if (isReload) {
      expectationPage = 1;
    } else {
      expectationPage = _page + 1;
    }

    return ApiService.searchIssues(login: Provide.value<UserProvide>(context).user.login, state: 'open', page: expectationPage).then((list){
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.issues),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: _loadData,
                child: MyVisibility(
                  flag: this._lastActionIsReload && (this._loadingState == StateFlag.empty || this._loadingState == StateFlag.error) ? MyVisibilityFlag.invisible : MyVisibilityFlag.visible,
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
            ),
            LoadingState(_lastActionIsReload ? _loadingState : StateFlag.idle,
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