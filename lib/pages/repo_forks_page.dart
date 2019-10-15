import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/widgets/base_list.dart';
import 'package:githao/widgets/repo_item.dart';

class RepoForksPage extends StatelessWidget {
  static const ROUTE_NAME = "/repo_forks";
  final String repoFullName;
  RepoForksPage(this.repoFullName, {Key key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              S.current.forks,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              this.repoFullName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
      body: _RepoForksList(this.repoFullName),
    );
  }
}

class _RepoForksList extends BaseListWidget {
  final String repoFullName;
  _RepoForksList(this.repoFullName, {Key key}): super(key: key);
  @override
  _RepoForksListState createState() => _RepoForksListState();
}

class _RepoForksListState extends BaseListWidgetState<_RepoForksList, RepoEntity> {
  @override
  Future<List<RepoEntity>> getDatum(int expectationPage) {
    return ApiService.getRepoForks(widget.repoFullName, page: expectationPage);
  }

  @override
  Widget buildItem(RepoEntity entity, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4,),
      child: RepoItem(entity, tag: 'repo_forks',),
    );
  }
}