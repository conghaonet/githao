import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/event_entity.dart';
import 'package:githao/network/entity/event_push_payload.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/pages/profile.dart';
import 'package:githao/routes/profile_page_args.dart';
import 'package:githao/utils/util.dart';

import 'load_more_data_footer.dart';
import 'loading_state.dart';
import 'my_visibility.dart';

class EventList extends StatefulWidget {
  final perPageRows = 30;
  final bool needLoadMore;
  final String login;

  EventList({Key key, this.login, this.needLoadMore=true,}): super(key: key);
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
    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
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

    return ApiService.getEvents(widget.login, page: expectationPage).then((list){
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
                    if(_results[index].type == EventTypes.pushEvent) {
                      return _getPushItem(_results[index], index);
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("index = $index"),
                          Text("type = ${_results[index].type}"),
                          Text("type = ${_results[index].repo.name}"),
                        ],
                      );
                    }
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

  Widget _getPushItem(EventEntity entity, int index) {
    if(entity.type != EventTypes.pushEvent) return Text('Not ${EventTypes.pushEvent} !');
    String heroTag = 'events_${entity.actor.login}$index';
    UserEntity _userEntity = UserEntity(login: entity.actor.login, avatarUrl: entity.actor.avatarUrl);
    EventPushPayload payload = EventPushPayload.fromJson(entity.payload);

    List<Widget> commits = [];
    int maxLine = 4;
    for(int i=0; i<payload.commits.length && i<maxLine; i++) {
      RichText richText;
      if(i < (maxLine - 1)) {
        richText = RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: '',
            style: TextStyle(color: Colors.black54, fontSize: 16),
            children: <TextSpan>[
              TextSpan(
                  text: '${payload.commits[i].sha.substring(0, 7)}  ',
                  style: TextStyle(color: Theme.of(context).primaryColor)
              ),
              TextSpan(
                text: payload.commits[i].message,
              ),
            ],
          ),
        );
      } else if(i == (maxLine -1)) {
        richText = RichText(text: TextSpan(
          text: '...',
          style: TextStyle(color: Colors.black54, fontSize: 16),
        ));
      }
      commits.add(richText);
    }

    return Card(
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
                        userEntity: _userEntity,
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
                    backgroundImage: CachedNetworkImageProvider(entity.actor.avatarUrl),
                  ),
                ),
              ),
              SizedBox(width: 8,),
              Text(entity.actor.login),
              Spacer(),
              Text(Util.getFriendlyDateTime(entity.createdAt)),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RichText(text: TextSpan(
                  text: '',
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                  children: <TextSpan>[
                    TextSpan(
                      text: EventTypes.pushEvent.replaceAll('Event', ''),
                      style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                    ),
                    TextSpan(
                      text: ' to ${payload.ref.replaceAll('refs/heads/', '')} at ',
                    ),
                    TextSpan(
                        text: entity.repo.name,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ]
                ),),
              ),
            ],
          ),
        ]..addAll(commits),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}