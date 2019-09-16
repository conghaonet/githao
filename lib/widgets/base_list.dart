import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:githao/utils/util.dart';
import 'package:githao/widgets/load_more_data_footer.dart';

import 'loading_state.dart';

abstract class BaseListWidget extends StatefulWidget {
  final perPageRows = 30;
  BaseListWidget({Key key}): super(key: key);
  @protected
  BaseListWidgetState createState();

}

abstract class BaseListWidgetState<T extends BaseListWidget, K> extends State<T> {
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final List<K> _datum = [];
  int _page = 1;
  StateFlag _loadingState = StateFlag.idle;
  bool _lastActionIsReload = true;
  bool _expectHasMoreData = true;

  Future<List<K>> getDatum(final int expectationPage);

  Widget buildItem(K k, int index);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(mounted) {
        refreshIndicatorKey.currentState.show();
      }
    });
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
    Future<List<K>> future = getDatum(expectationPage);
    return future.then<void>((list) {
      if(isReload) {
        _datum.clear();
        _page = 1;
      }
      if(list.isNotEmpty) {
        this._datum.addAll(list);
        if (!isReload) {
          ++_page;
        }
      }
      //判断是否可能还有更多数据
      this._expectHasMoreData = list.length >= widget.perPageRows;
      if(_datum.isEmpty) {
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
        _datum.clear();
      }
      if(mounted) {setState(() {});}
      Util.showToast(e is DioError ? e.message : e.toString());
    }).whenComplete(() {
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: _loadData,
            color: Theme.of(context).primaryColor,
            child: ListView.builder(
              itemCount: _datum.length >= widget.perPageRows ? _datum.length+1 : _datum.length,
              itemBuilder: (context, index) {
                if(index < _datum.length) {
                  return buildItem(_datum[index], index);
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
          LoadingState(_lastActionIsReload ? _loadingState : StateFlag.idle,
            onRetry: (){
              refreshIndicatorKey.currentState.show();
            },
          ),
        ],
      ),
    );
  }
}