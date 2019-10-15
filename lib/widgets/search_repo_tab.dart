import 'package:flutter/material.dart';
import 'package:githao/events/app_event_bus.dart';
import 'package:githao/events/search_event.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/utils/string_util.dart';
import 'package:githao/widgets/base_list.dart';
import 'package:githao/widgets/repo_item.dart';

class SearchRepoTab extends StatelessWidget {
  final String category;
  SearchRepoTab(this.category, {Key key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return _RepoList(this.category);
  }
}

class _RepoList extends BaseListWidget {
  final String category;
  _RepoList(this.category, {Key key}): super(key: key);
  @override
  _RepoListState createState() => _RepoListState();
}

class _RepoListState extends BaseListWidgetState<_RepoList, RepoEntity> {
  String _query;

  @override
  Widget buildItem(RepoEntity entity, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4,),
      child: RepoItem(entity, tag: 'search_repo',),
    );
  }

  @override
  Future<List<RepoEntity>> getDatum(int expectationPage) {
    if(StringUtil.isNotBlank(this._query)) {
      return ApiService.searchRepos(keyword: _query, page: expectationPage);
    } else {
      return null;
    }
  }

  @override
  void afterInitState() {
    eventBus.on<SearchEvent>().listen((event) {
      if(StringUtil.isNullOrBlank(event.category) || event.category == widget.category) {
        this._query = event.query;
        if(StringUtil.isNotBlank(this._query)) {
          super.refreshIndicatorKey?.currentState?.show();
        }
      }
    });
  }

}