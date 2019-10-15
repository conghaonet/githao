import 'package:flutter/material.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/widgets/user_repos.dart';

class UserReposPage extends StatefulWidget {
  static const String ROUTE_NAME = '/user_repos';
  final String login;
  UserReposPage(this.login, {Key key}): super(key: key);
  @override
  _UserReposPageState createState() => _UserReposPageState();
}

class _UserReposPageState extends State<UserReposPage> {
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
              S.current.repositories,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              widget.login,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
      body: UserReposWidget(widget.login, tag: 'user_repos',),
    );
  }
}