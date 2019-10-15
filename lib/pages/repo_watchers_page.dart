import 'package:flutter/material.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/widgets/base_grid.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/widgets/user_item.dart';

class RepoWatchersPage extends StatelessWidget {
  static const ROUTE_NAME = "/repo_watchers";
  final String repoFullName;
  RepoWatchersPage(this.repoFullName, {Key key}): super(key: key);

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
              S.current.watchers,
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
      body: _WatchersGrid(this.repoFullName),
    );
  }
}

class _WatchersGrid extends BaseGridWidget {
  final String repoFullName;
  _WatchersGrid(this.repoFullName, {Key key}): super(crossAxisCount: 2, childAspectRatio: 2, key: key);

  @override
  _WatchersGridState createState() => _WatchersGridState();
}

class _WatchersGridState extends BaseGridWidgetState<_WatchersGrid, UserEntity> {

  @override
  Future<List<UserEntity>> getDatum(int expectationPage) {
    return ApiService.getRepoWatchers(widget.repoFullName, page: expectationPage);
  }

  @override
  Widget buildItem(UserEntity entity, int index) {
    return UserItem(entity, tag: 'repo_watchers',);
  }
}