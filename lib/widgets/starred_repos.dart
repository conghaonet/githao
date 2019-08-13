
import 'package:flutter/material.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/resources/starred_filter_parameters.dart';
import 'package:githao/widgets/starred_repos_filter.dart';

import 'base_repos.dart';

class StarredRepos extends BaseReposWidget{
  final UserEntity user;
  StarredRepos({Key key, this.user, needLoadMore=true,}): super(key: key, needLoadMore: needLoadMore);
  @override
  _StarredReposState createState() => _StarredReposState();
}

class _StarredReposState extends BaseReposWidgetState<StarredRepos> {
  int _groupSortIndex = 0;

  @override
  Future<List<RepoEntity>> getRepos(final int expectationPage){
    String _sort = StarredFilterParameters.filterSortValueMap[_groupSortIndex][StarredFilterParameters.PARAMETER_NAME_SORT];
    String _direction = StarredFilterParameters.filterSortValueMap[_groupSortIndex][StarredFilterParameters.PARAMETER_NAME_DIRECTION];
    return ApiService.getUserStarredRepos(widget.user.login, page: expectationPage, sort: _sort, direction: _direction);
  }

  void onClickFilterCallback(String group, int index) {
      if(group == StarredReposFilter.GROUP_SORT && _groupSortIndex != index) {
        setState(() {
          _groupSortIndex = index;
        });
        refreshIndicatorKey.currentState.show();
      }
  }

  @override
  Widget getFilter() {
    return StarredReposFilter(
        this._groupSortIndex,
        StarredFilterParameters.getFilterSortTextMap(context),
        onClickFilterCallback);
  }

}