import 'package:flutter/material.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/resources/repos_filter_parameters.dart';
import 'package:githao/utils/sp_util.dart';
import 'package:githao/widgets/base_list.dart';
import 'package:githao/widgets/my_repos_filter.dart';
import 'package:githao/widgets/repo_item.dart';

class UserReposWidget extends StatefulWidget {
  final String login;
  final String tag;

  UserReposWidget(this.login, {this.tag, Key key}) : super(key: key);

  @override
  _UserReposWidgetState createState() => _UserReposWidgetState();
}

class _UserReposWidgetState extends State<UserReposWidget> {
  int _groupTypeIndex = 0;
  int _groupSortIndex = 0;

  void onClickFilterCallback(String group, int index) {
    if (group == MyReposFilter.GROUP_TYPE && _groupTypeIndex != index) {
      setState(() {
        _groupTypeIndex = index;
      });
    } else if (group == MyReposFilter.GROUP_SORT && _groupSortIndex != index) {
      setState(() {
        _groupSortIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _RepoList(
          widget.login,
          _groupTypeIndex,
          _groupSortIndex,
          tag: widget.tag,
          wantKeepAlive: true,
          key: Key('user_repos_$_groupTypeIndex-$_groupSortIndex'),
        ),
        Positioned(
          bottom: 12,
          right: 16,
          child: FloatingActionButton(
            child: Icon(Icons.sort),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return AnimatedPadding(
                    padding: MediaQuery.of(context).viewInsets, //边距（必要）
                    duration: const Duration(milliseconds: 100), //时常 （必要）
                    child: getFilter(),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget getFilter() {
    return MyReposFilter(
      this._groupTypeIndex,
      widget.login == SpUtil.getUserName()
          ? ReposFilterParameters.getFilterTypeTextMap()
          : ReposFilterParameters.getUserFilterTypeTextMap(),
      this._groupSortIndex,
      ReposFilterParameters.getFilterSortTextMap(),
      onClickFilterCallback,
    );
  }
}

class _RepoList extends BaseListWidget {
  final String login;
  final int groupTypeIndex;
  final int groupSortIndex;
  final String tag;

  _RepoList(this.login, this.groupTypeIndex, this.groupSortIndex,
      {this.tag, bool wantKeepAlive = false, Key key})
      : super(wantKeepAlive: wantKeepAlive, key: key);

  @override
  _RepoListState createState() => _RepoListState();
}

class _RepoListState extends BaseListWidgetState<_RepoList, RepoEntity> {
  @override
  Widget buildItem(RepoEntity item, int index) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 4,
      ),
      child: RepoItem(
        item,
        tag: widget.tag,
      ),
    );
  }

  @override
  Future<List<RepoEntity>> getDatum(int expectationPage) {
    String _type =
        ReposFilterParameters.filterTypeValueMap[this.widget.groupTypeIndex];
    String _sort =
        ReposFilterParameters.filterSortValueMap[this.widget.groupSortIndex]
            [ReposFilterParameters.PARAMETER_NAME_SORT];
    String _direction =
        ReposFilterParameters.filterSortValueMap[this.widget.groupSortIndex]
            [ReposFilterParameters.PARAMETER_NAME_DIRECTION];
    String userName = SpUtil.getUserName();
    if (userName != null && userName == widget.login) {
      return ApiService.getMyRepos(
          page: expectationPage,
          type: _type,
          sort: _sort,
          direction: _direction);
    } else {
      return ApiService.getUserRepos(widget.login,
          page: expectationPage,
          type: _type,
          sort: _sort,
          direction: _direction);
    }
  }
}
