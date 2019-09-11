import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:githao/utils/util.dart';
import 'package:githao/widgets/load_more_data_footer.dart';
import 'package:githao/widgets/loading_state.dart';

abstract class BaseGridWidget extends StatefulWidget {
  final perPageRows = 30;
  final int crossAxisCount;
  final double childAspectRatio;
  BaseGridWidget({
    this.crossAxisCount = 2,
    this.childAspectRatio = 1,
    Key key,
  }) : assert(crossAxisCount != null && crossAxisCount > 0),
       assert(childAspectRatio != null && childAspectRatio > 0),
       super(key: key);

  @protected
  BaseGridWidgetState createState();
}

abstract class BaseGridWidgetState<T extends BaseGridWidget, K> extends State<T> {
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final List<K> _userEntities = [];
  int _page = 1;
  StateFlag _loadingState = StateFlag.idle;
  bool _lastActionIsReload = true;
  bool _expectHasMoreData = true;

  AppBar buildAppBar();

  Future<List<K>> getUsers(final int expectationPage);

  Widget buildItem(K k, int index);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => refreshIndicatorKey.currentState.show());
  }
  Future<void> _loadData({bool isReload = true}) async {
    if(_loadingState == StateFlag.loading) return Future;
    if(mounted) {
      setState(() {
        _lastActionIsReload = isReload;
        _loadingState = StateFlag.loading;
      });
    }

    int expectationPage;
    if (isReload) {
      expectationPage = 1;
    } else {
      expectationPage = _page + 1;
    }
    Future<List<K>> future = getUsers(expectationPage);
    return future.then<void>((list) {
      if(isReload) {
        _userEntities.clear();
        _page = 1;
      }
      if(list.isNotEmpty) {
        this._userEntities.addAll(list);
        if (!isReload) {
          ++_page;
        }
      }
      //判断是否可能还有更多数据
      this._expectHasMoreData = list.length >= widget.perPageRows;
      if(_userEntities.isEmpty) {
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
        _userEntities.clear();
      }
      if(mounted) {setState(() {});}
      Util.showToast(e is DioError ? e.message : e.toString());
    }).whenComplete(() {
      return;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        child: Stack(
          children: <Widget>[
            RefreshIndicator(
              key: refreshIndicatorKey,
              onRefresh: _loadData,
              color: Theme.of(context).primaryColor,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.crossAxisCount,
                      childAspectRatio: widget.childAspectRatio,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        if(index + 1 == _userEntities.length) {
                          if(_expectHasMoreData && _loadingState == StateFlag.complete) {
                            Future.delayed(const Duration(milliseconds: 100)).then((_){
                              _loadData(isReload: false);
                            });
                          }
                        }
                        return buildItem(_userEntities[index], index);
                      },
                      childCount: _userEntities.length,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Offstage(
                      offstage: _userEntities.length < widget.perPageRows,
                      child: Center(
                        child: LoadMoreDataFooter(_expectHasMoreData, flag: _loadingState, onRetry: () {
                          _loadData(isReload: false);
                        },),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            LoadingState(_lastActionIsReload ? _loadingState : StateFlag.idle,
              onRetry: (){
                refreshIndicatorKey.currentState.show();
              },
            ),
          ],
        ),
      ),
    );
  }
}