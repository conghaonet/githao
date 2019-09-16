import 'package:flutter/material.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/widgets/base_list.dart';

class SearchRepoTab extends StatefulWidget {
  final String query;
  SearchRepoTab(this.query, {Key key}): super(key: key);
  @override
  _SearchRepoTabState createState() => _SearchRepoTabState();
}

class _SearchRepoTabState extends State<SearchRepoTab> {
  @override
  Widget build(BuildContext context) {
    return _RepoList(widget.query);
  }
}

class _RepoList extends BaseListWidget {
  final String query;
  _RepoList(this.query, {Key key}): super(key: key);
  @override
  _RepoListState createState() => _RepoListState();

}

class _RepoListState extends BaseListWidgetState<_RepoList, RepoEntity> {
  @override
  Widget buildItem(RepoEntity entity, int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(entity.fullName),
      ),
    );
  }

  @override
  Future<List<RepoEntity>> getDatum(int expectationPage) {
    return ApiService.searchRepos(keyword: widget.query, page: expectationPage);
  }

}