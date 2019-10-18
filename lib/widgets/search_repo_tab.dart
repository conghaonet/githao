import 'package:flutter/material.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/resources/search_repos_filter_parameters.dart';
import 'package:githao/widgets/base_list.dart';
import 'package:githao/widgets/repo_item.dart';
import 'package:githao/widgets/search_repos_filter.dart';

class SearchRepoTab extends StatefulWidget {
  final String query;
  SearchRepoTab(this.query, {Key key}): super(key: key);

  @override
  _SearchRepoTabState createState() => _SearchRepoTabState();
}

class _SearchRepoTabState extends State<SearchRepoTab> {
  int _sortIndex = 0;

  void onClickFilterCallback(int index) {
    if(_sortIndex != index) {
      setState(() {
        _sortIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _RepoList(this.widget.query, _sortIndex, key: Key('repo_${this.widget.query}_$_sortIndex'),),
        Positioned(
          bottom: 12,
          right: 16,
          child: FloatingActionButton(
            heroTag: 'search_repo_tab_fab',
            child: Icon(Icons.sort),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return AnimatedPadding(
                    padding: MediaQuery.of(context).viewInsets,  //边距（必要）
                    duration: const Duration(milliseconds: 100), //时常 （必要）
                    child: SearchReposFilter(
                      this._sortIndex,
                      onClickFilterCallback,
                    ),
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
  final String query;
  final int sortIndex;
  _RepoList(this.query, this.sortIndex, {Key key}): super(wantKeepAlive: true, key: key);
  @override
  _RepoListState createState() => _RepoListState();
}

class _RepoListState extends BaseListWidgetState<_RepoList, RepoEntity> {
  @override
  Widget buildItem(RepoEntity entity, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4,),
      child: RepoItem(entity, tag: 'search_repo_tab_list',),
    );
  }

  @override
  Future<List<RepoEntity>> getDatum(int expectationPage) {
    String _sort = SearchReposFilterParameters.filterSortValueMap[this.widget.sortIndex][SearchReposFilterParameters.PARAMETER_NAME_SORT];
    String _direction = SearchReposFilterParameters.filterSortValueMap[this.widget.sortIndex][SearchReposFilterParameters.PARAMETER_NAME_DIRECTION];
    return ApiService.searchRepos(keyword: widget.query, sort: _sort, order: _direction, page: expectationPage);
  }

}
