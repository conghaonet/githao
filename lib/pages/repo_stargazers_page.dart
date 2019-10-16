import 'package:flutter/material.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/widgets/base_grid.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/widgets/user_item.dart';

class RepoStargazersPage extends StatelessWidget {
  static const ROUTE_NAME = "/repo_stargazers";
  final String heroTag = DateTime.now().millisecondsSinceEpoch.toString();
  final String repoFullName;
  RepoStargazersPage(this.repoFullName, {Key key}): super(key: key);

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
              S.current.stargazers,
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
      body: _StargazersGrid(this.repoFullName, tag: heroTag,),
    );
  }
}

class _StargazersGrid extends BaseGridWidget {
  final String tag;
  final String repoFullName;
  _StargazersGrid(this.repoFullName, {this.tag, Key key}): super(crossAxisCount: 2, childAspectRatio: 2, key: key);

  @override
  _StargazersGridState createState() => _StargazersGridState();
}

class _StargazersGridState extends BaseGridWidgetState<_StargazersGrid, UserEntity> {

  @override
  Future<List<UserEntity>> getDatum(int expectationPage) {
    return ApiService.getRepoStargazers(widget.repoFullName, page: expectationPage);
  }

  @override
  Widget buildItem(UserEntity entity, int index) {
    return UserItem(entity, tag: 'repo_stargazers_${widget.tag ?? ''}',);
  }
}