import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/pages/home.dart';
import 'package:githao/resources/repos_filter_parameters.dart';
import 'package:githao/widgets/loading_state.dart';
import 'package:githao/utils/util.dart';

import 'load_more_data_footer.dart';
import 'my_visibility.dart';

/// [perPageRows] 每次请求期望返回的数据量，GitHub默认每次返回30条数据；
/// [needLoadMore] 为true时，提供上拉加载更多特性；
class MyReposWidget extends StatefulWidget{
  final perPageRows = 30;
  final bool needLoadMore;
  final String homeDrawerMenu;
  MyReposWidget({Key key, this.homeDrawerMenu, this.needLoadMore=true,}): super(key: key);
  @override
  _MyReposWidgetState createState() => _MyReposWidgetState();
}

class _MyReposWidgetState extends State<MyReposWidget> {
  final List<RepoEntity> _repos = [];
  int _page = 1;
  StateFlag _loadingState = StateFlag.idle;
  bool _expectHasMoreData = true;
  int _groupTypeIndex = 0;
  int _groupSortIndex = 0;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  void onClickFilterCallback(String category, int index, bool isSelected) {
    if(category == 'type') {
      setState(() {
        _groupTypeIndex = index;
      });
    } else if(category == 'sort') {
      setState(() {
        _groupSortIndex = index;
      });
    }
  }
  Future<void> _loadData({bool isReload=true}) async {
    if(_loadingState == StateFlag.loading) return null;
    setState(() {
      _loadingState = StateFlag.loading;
    });
    int expectationPage;
    if (isReload) {
      expectationPage = 1;
    } else {
      expectationPage = _page + 1;
    }
    Future<List<RepoEntity>> future;
    if(widget.homeDrawerMenu == HomeDrawer.MENU_MY_REPOS) {
      future = ApiService.getRepos(page: expectationPage);
    } else if(widget.homeDrawerMenu == HomeDrawer.MENU_STARRED_REPOS) {
      future = ApiService.getStarredRepos(page: expectationPage);
    }
    return future.then<bool>((list) {
      if(mounted) {
        setState(() {
          if (isReload) { //初始加载或下拉刷新数据
            this._repos
              ..clear()
              ..addAll(list);
            _page = 1;
          } else { //上拉加载更多数据
            if(list.isNotEmpty) {
              this._repos.addAll(list);
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
        });
      }
      return;
    }).catchError((e) {
      if(mounted) {
        if(isReload) {
          setState(() {
            _repos.clear();
            this._loadingState = StateFlag.error;
          });
        }
        Util.showToast(e is DioError ? e.message : e.toString());
      }
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        MyVisibility(
          flag: this._loadingState != StateFlag.empty && this._loadingState != StateFlag.error ? MyVisibilityFlag.visible : MyVisibilityFlag.gone,
          child: Container(
            child: RefreshIndicator(
              key: _refreshIndicatorKey,
              color: Colors.blue,
              onRefresh: _loadData,
              child: NotificationListener(
                onNotification: (ScrollNotification notification) {
                  if(widget.needLoadMore && _expectHasMoreData) { //是否需要实现加载更多特性
                    if(0 == notification.metrics.extentAfter) { //到达底部
                      _loadData(isReload: false);
                    }
                  }
                  return false; //返回false，将事件传递给外层控件(RefreshIndicator)，否则外层RefreshIndicator无法监听到下拉手势
                },
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(height: 4, color: Theme.of(context).primaryColor,);
                  },
                  padding: EdgeInsets.all(0.0),
                  itemCount: (_repos.length >= widget.perPageRows && widget.needLoadMore) ? _repos.length+1 : _repos.length,
                  itemBuilder: (context, index) {
                    if(index < _repos.length) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('index：$index'),
                          Text('name: ${_repos[index].name}'),
                          Text('language: ${_repos[index].language}'),
                          Text('description: ${_repos[index].description}'),
                          Text('pushedAt: ${_repos[index].pushedAt}'),
                        ],
                      );
                    } else {
                      return LoadMoreDataFooter(_expectHasMoreData);
                    }
                  },
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 12,
          right: 16,
          child: FloatingActionButton(
            child: Icon(Icons.sort),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return BottomFilter(
                      this._groupTypeIndex,
                      ReposFilterParameters.getFilterTypeTextMap(context),
                      this._groupSortIndex,
                      ReposFilterParameters.getFilterSortTextMap(context),
                      onClickFilterCallback);
                },
              );
            },
          ),
        ),
        LoadingState(_loadingState,
          onRetry: (){
            _refreshIndicatorKey.currentState.show();
          },
        ),
      ],
    );
  }

/*
  Widget getBottomContent() {
    List<String> typeTexts = ReposFilterParameters.getFilterTypeTextMap(context);
    List<String> sortTexts = ReposFilterParameters.getFilterSortTextMap(context);
    String _groupValueFilterSort = ReposFilterParameters.filterSortValueMap[0][ReposFilterParameters.PARAMETER_NAME_SORT];
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(S.of(context).reposFilterType),
        Wrap(
          children: List<Widget>.generate(typeTexts.length, (int index) {
            return ChoiceChip(
              //未选定的时候背景
              backgroundColor:Colors.red,
              //被禁用得时候背景
              disabledColor: Colors.blue,

              label: Text(typeTexts[index]),
              selected: _groupTypeIndex == index,
              onSelected: (bool selected) {
                setState(() {
                  if(selected)
//                  _groupTypeIndex = selected ? index : null;
                    _groupTypeIndex = index;
                });
              },
            );
          }).toList(growable: false),
        ),
      ],
    );
  }
*/
  Widget getSortTitle(String title, bool isAsc) {
    return Wrap(
      children: <Widget>[
        Text(title),
        Icon(isAsc ? Icons.trending_up : Icons.trending_down),
      ],
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}

class BottomFilter extends StatefulWidget {
  final List<String> typeTexts;
  final List<String> sortTexts;
  final int selectedTypeIndex;
  final int selectedSortIndex;
  final Function(String, int, bool) callback;
  BottomFilter(this.selectedTypeIndex ,this.typeTexts, this.selectedSortIndex, this.sortTexts, this.callback);
  @override
  _BottomFilterState createState() => _BottomFilterState();
}

class _BottomFilterState extends State<BottomFilter> {
  int _selectedTypeIndex;
  int _selectedSortIndex;
  @override
  void initState() {
    _selectedTypeIndex = widget.selectedTypeIndex;
    _selectedSortIndex = widget.selectedSortIndex;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 0),
            child: Text(
              S.of(context).reposFilterType,
              style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.w700),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: List<Widget>.generate(widget.typeTexts.length, (int index) {
                return Padding(
                  padding: EdgeInsets.only(right: 8, left: 8),
                  child: ChoiceChip(
                    label: Padding(
                      padding: widget.typeTexts[index].length < 5 ? EdgeInsets.only(left: 12, right: 12,) : EdgeInsets.only(left: 4, right: 4,),
                      child: Text(widget.typeTexts[index],
                        style: TextStyle(color: _selectedTypeIndex == index ? Colors.white : Colors.black45),
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColorLight,
                    selectedColor: Theme.of(context).primaryColorDark,
                    selected: _selectedTypeIndex == index,
                    onSelected: (bool isSelected) {
                      _selectedTypeIndex = isSelected ? index : -1;
                      widget.callback('type', index, isSelected);
                      Navigator.pop(context);
                    },
                  ),
                );
              }).toList(growable: false),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 0),
            child: Text(
              S.of(context).reposFilterSort,
              style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.w700),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: List<Widget>.generate(widget.sortTexts.length, (int index) {
                return Padding(
                  padding: EdgeInsets.only(right: 8, left: 8),
                  child: ChoiceChip(
                    label: Padding(
                      padding: EdgeInsets.only(left: 4, right: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(widget.sortTexts[index],
                            style: TextStyle(color: _selectedSortIndex == index ? Colors.white : Colors.black45),
                          ),
                          Icon(
                              ReposFilterParameters.filterSortValueMap[index][ReposFilterParameters.PARAMETER_NAME_DIRECTION] == ReposFilterParameters.DIRECTION_ASC
                                  ? Icons.trending_up
                                  : Icons.trending_down,
                            color: _selectedSortIndex == index ? Colors.white : Colors.black45,),
                        ],
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColorLight,
                    selectedColor: Theme.of(context).primaryColorDark,
                    selected: _selectedSortIndex == index,
                    onSelected: (bool isSelected) {
                      _selectedSortIndex = isSelected ? index : -1;
                      widget.callback('sort', index, isSelected);
                      Navigator.pop(context);
                    },
                  ),
                );
              }).toList(growable: false),
            ),
          ),
        ],
      ),
    );
  }
}