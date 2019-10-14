import 'package:flutter/material.dart';
import 'package:githao/events/app_event_bus.dart';
import 'package:githao/events/search_event.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/widgets/base_list.dart';

class SearchRepoTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _RepoList();
  }
}

class _RepoList extends BaseListWidget {
  _RepoList({Key key}): super(wantKeepAlive: true, key: key);
  @override
  _RepoListState createState() => _RepoListState();
}

class _RepoListState extends BaseListWidgetState<_RepoList, RepoEntity> {
  String _query;

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
    if(this._query != null && this._query.trim().isNotEmpty) {
      return ApiService.searchRepos(keyword: _query, page: expectationPage);
    } else {
      return null;
    }
  }

  @override
  void afterInitState() {
    eventBus.on<SearchEvent>().listen((event) {
      this._query = event.query;
      if(this._query != null && this._query.trim().isNotEmpty) {
        super.refreshIndicatorKey?.currentState?.show();
      }
    });
  }

}