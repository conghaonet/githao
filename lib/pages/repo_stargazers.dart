import 'package:flutter/material.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/widgets/base_users.dart';
import 'package:githao/generated/i18n.dart';

class RepoStargazersPage extends BaseUsersWidget {
  static const ROUTE_NAME = "/repo_stargazers";
  final String repoName;
  RepoStargazersPage(this.repoName, {Key key}): super(key: key);

  @override
  _RepoStargazersPageState createState() => _RepoStargazersPageState();
}

class _RepoStargazersPageState extends BaseUsersWidgetState<RepoStargazersPage> {

  @override
  AppBar buildAppBar() {
    return AppBar(
      titleSpacing: 0,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            S.current.stargazers,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            widget.repoName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  @override
  Future<List<UserEntity>> getUsers(int expectationPage) {
    return ApiService.getRepoStargazers(widget.repoName, page: expectationPage);
  }
}