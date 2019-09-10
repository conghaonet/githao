import 'package:flutter/material.dart';
import 'package:githao/network/entity/user_entity.dart';

abstract class BaseUsersWidget extends StatefulWidget {
  final perPageRows = 30;
  BaseUsersWidget({Key key}): super(key: key);
  @protected
  BaseUsersWidgetState createState();
}

abstract class BaseUsersWidgetState<T extends BaseUsersWidget> extends State<T> {
  AppBar buildAppBar();
  Future<List<UserEntity>> getUsers(final int expectationPage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        child: Center(
          child: Text('Building...'),
        ),
      ),
    );
  }
}