import 'package:flutter/material.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/resources/starred_filter_parameters.dart';
import 'package:githao/widgets/base_list.dart';
import 'package:githao/widgets/repo_item.dart';
import 'package:githao/widgets/starred_repos_filter.dart';

class StarredReposWidget extends StatefulWidget{
  final UserEntity user;
  final String tag;
  final bool wantKeepAlive;
  StarredReposWidget(this.user, {this.tag, this.wantKeepAlive = false, Key key}): super(key: key);
  @override
  _StarredReposWidgetState createState() => _StarredReposWidgetState();
}

class _StarredReposWidgetState extends State<StarredReposWidget> {
  int _groupSortIndex = 0;

  void onClickFilterCallback(String group, int index) {
      if(group == StarredReposFilter.GROUP_SORT && _groupSortIndex != index) {
        setState(() {
          _groupSortIndex = index;
        });
      }
  }

  Widget getFilter() {
    return StarredReposFilter(
      this._groupSortIndex,
      StarredFilterParameters.getFilterSortTextMap(context),
      onClickFilterCallback,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _RepoList(
          widget.user,
          _groupSortIndex,
          tag: widget.tag,
          wantKeepAlive: widget.wantKeepAlive,
          key: ObjectKey(_groupSortIndex),
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
                    padding: MediaQuery.of(context).viewInsets,  //边距（必要）
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
}



class _RepoList extends BaseListWidget {
  final UserEntity user;
  final int groupSortIndex;
  final String tag;
  _RepoList(
      this.user,
      this.groupSortIndex,
      {this.tag, bool wantKeepAlive = false, Key key}): super(wantKeepAlive: wantKeepAlive, key: key);
  @override
  _RepoListState createState() => _RepoListState();

}

class _RepoListState extends BaseListWidgetState<_RepoList, RepoEntity> {
  @override
  Widget buildItem(RepoEntity item, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4,),
      child: RepoItem(item, tag: widget.tag,),
    );
  }

  @override
  Future<List<RepoEntity>> getDatum(int expectationPage) {
    String _sort = StarredFilterParameters.filterSortValueMap[this.widget.groupSortIndex][StarredFilterParameters.PARAMETER_NAME_SORT];
    String _direction = StarredFilterParameters.filterSortValueMap[this.widget.groupSortIndex][StarredFilterParameters.PARAMETER_NAME_DIRECTION];
    return ApiService.getUserStarredRepos(widget.user.login, page: expectationPage, sort: _sort, direction: _direction);
  }

}