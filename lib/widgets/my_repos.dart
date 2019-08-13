
import 'package:flutter/material.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/resources/repos_filter_parameters.dart';

import 'base_repos.dart';
import 'my_repos_filter.dart';

/// [perPageRows] 每次请求期望返回的数据量，GitHub默认每次返回30条数据；
/// [needLoadMore] 为true时，提供上拉加载更多特性；
class MyReposWidget extends BaseReposWidget{
  final UserEntity user;
  MyReposWidget({Key key, this.user, needLoadMore=true,}): super(key: key, needLoadMore: needLoadMore);
  @override
  _MyReposWidgetState createState() => _MyReposWidgetState();
}

class _MyReposWidgetState extends BaseReposWidgetState<MyReposWidget> {
  int _groupTypeIndex = 0;
  int _groupSortIndex = 0;

  void onClickFilterCallback(String group, int index) {
      if(group == MyReposFilter.GROUP_TYPE && _groupTypeIndex != index) {
        setState(() {
          _groupTypeIndex = index;
        });
        refreshIndicatorKey.currentState.show();
      } else if(group == MyReposFilter.GROUP_SORT && _groupSortIndex != index) {
        setState(() {
          _groupSortIndex = index;
        });
        refreshIndicatorKey.currentState.show();
      }
  }
  @override
  Future<List<RepoEntity>> getRepos(final int expectationPage){
    String _type = ReposFilterParameters.filterTypeValueMap[_groupTypeIndex];
    String _sort = ReposFilterParameters.filterSortValueMap[_groupSortIndex][ReposFilterParameters.PARAMETER_NAME_SORT];
    String _direction = ReposFilterParameters.filterSortValueMap[_groupSortIndex][ReposFilterParameters.PARAMETER_NAME_DIRECTION];
    return ApiService.getUserRepos(widget.user.login, page: expectationPage, type: _type, sort: _sort, direction: _direction);
  }

  @override
  Widget getFilter() {
    return MyReposFilter(
        this._groupTypeIndex,
        ReposFilterParameters.getFilterTypeTextMap(context),
        this._groupSortIndex,
        ReposFilterParameters.getFilterSortTextMap(context),
        onClickFilterCallback);
  }
}