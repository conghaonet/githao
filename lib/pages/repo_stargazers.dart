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
      title: Text(S.current.stargazers),
    );
  }

  @override
  Future<List<UserEntity>> getUsers(int expectationPage) {
    return ApiService.getRepoStargazers(widget.repoName, page: expectationPage);
  }
}