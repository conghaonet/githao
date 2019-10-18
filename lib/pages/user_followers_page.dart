import 'package:flutter/material.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/widgets/base_grid.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/widgets/user_item.dart';

class UserFollowersPage extends StatelessWidget {
  static const ROUTE_NAME = "/user_followers";
  final String heroTag = DateTime.now().millisecondsSinceEpoch.toString();
  final String login;
  UserFollowersPage(this.login, {Key key}): super(key: key);

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
              S.current.followers,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              this.login,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
      body: _FollowersGrid(this.login, tag: heroTag,),
    );
  }
}

class _FollowersGrid extends BaseGridWidget {
  final String tag;
  final String login;
  _FollowersGrid(this.login, {this.tag, Key key}): super(crossAxisCount: 2, key: key);

  @override
  _FollowersGridState createState() => _FollowersGridState();
}

class _FollowersGridState extends BaseGridWidgetState<_FollowersGrid, UserEntity> {

  @override
  Future<List<UserEntity>> getDatum(int expectationPage) {
    return ApiService.getUserFollowers(widget.login, page: expectationPage);
  }

  @override
  Widget buildItem(UserEntity entity, int index) {
    return UserItem(entity, tag: 'user_followers_${widget.tag ?? ''}',);
  }
}