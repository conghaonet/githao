import 'package:flutter/material.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/widgets/base_list.dart';
import 'package:githao/widgets/repo_item.dart';

class SearchRepoTab extends StatelessWidget {
  final String query;
  SearchRepoTab(this.query, {Key key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return _RepoList(this.query);
  }
}

class _RepoList extends BaseListWidget {
  final String query;
  _RepoList(this.query, {Key key}): super(wantKeepAlive: true, key: key);
  @override
  _RepoListState createState() => _RepoListState();
}

class _RepoListState extends BaseListWidgetState<_RepoList, RepoEntity> {
  @override
  Widget buildItem(RepoEntity entity, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4,),
      child: RepoItem(entity, tag: 'search_repo',),
    );
  }

  @override
  Future<List<RepoEntity>> getDatum(int expectationPage) {
    return ApiService.searchRepos(keyword: widget.query, page: expectationPage);
  }

}