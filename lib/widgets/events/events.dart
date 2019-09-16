import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/event_entity.dart';
import 'package:githao/utils/util.dart';
import 'package:githao/widgets/events/issue_comment_event.dart';
import 'package:githao/widgets/events/issues_event.dart';
import 'package:githao/widgets/events/pull_request_event.dart';
import 'package:githao/widgets/events/pull_request_review_comment_event.dart';
import 'package:githao/widgets/events/push_event.dart';
import 'package:githao/widgets/events/release_event.dart';

import '../load_more_data_footer.dart';
import '../loading_state.dart';
import '../my_visibility.dart';
import 'create_event.dart';
import 'event_common_avatar.dart';
import 'fork_event.dart';
import 'only_action_event.dart';

class EventList extends StatefulWidget {
  final perPageRows = 30;
  final bool needLoadMore;
  final String login;
  final String repoName;

  EventList({Key key, this.login, this.repoName, this.needLoadMore=true,}): super(key: key);
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> with AutomaticKeepAliveClientMixin {
  final List<EventEntity> _results = [];
  bool _lastActionIsReload = true;
  int _page = 1;
  StateFlag _loadingState = StateFlag.idle;
  bool _expectHasMoreData = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  //要达到缓存目的，必须实现AutomaticKeepAliveClientMixin的wantKeepAlive为true。
  // 不会被销毁,占内存中
  @override
  bool get wantKeepAlive => true;

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

    return ApiService.getEvents(widget.login, repoName: widget.repoName, page: expectationPage).then((list){
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
    super.build(context); //混入AutomaticKeepAliveClientMixin后，必须添加
    return Stack(
      children: <Widget>[
        Container(
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _loadData,
            child: MyVisibility(
              flag: this._lastActionIsReload && (this._loadingState == StateFlag.empty || this._loadingState == StateFlag.error) ? MyVisibilityFlag.invisible : MyVisibilityFlag.visible,
              child: ListView.builder(
                itemCount: (_results.length >= widget.perPageRows && widget.needLoadMore) ? _results.length+1 : _results.length,
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
    );
  }
  
  Widget getItem(EventEntity entity, int index) {
    switch(entity.type) {
      case EventTypes.pushEvent:
        return PushEventItem(entity, index);
      case EventTypes.issuesEvent:
        return IssuesEventItem(entity, index);
      case EventTypes.issueCommentEvent:
        return IssueCommentEventItem(entity, index);
      case EventTypes.createEvent:
      case EventTypes.deleteEvent:
        return CreateEventItem(entity, index);
      case EventTypes.forkEvent:
        return ForkEventItem(entity, index);
      case EventTypes.pullRequestEvent:
        return PullRequestEventItem(entity, index);
      case EventTypes.pullRequestReviewCommentEvent:
        return PullRequestReviewCommentEventItem(entity, index);
      case EventTypes.watchEvent:
        return OnlyActionEventItem(entity, index);
      case EventTypes.releaseEvent:
        return ReleaseEventItem(entity, index);
      default:
        return Card(
          margin: EdgeInsets.all(8),
          color: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                EventCommonAvatar(entity, index),
                Text("index = $index"),
                Text("Event: ${entity.type}"),
                Text("Repository: ${entity.repo.name}"),
                Text("Unimplemented this event"),
              ],
            ),
          ),
        );
    }
  }
  @override
  void dispose() {
    super.dispose();
  }
}