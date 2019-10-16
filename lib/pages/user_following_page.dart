import 'package:flutter/material.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/widgets/base_grid.dart';
import 'package:githao/generated/i18n.dart';
import 'package:githao/widgets/user_item.dart';

class UserFollowingPage extends StatelessWidget {
  static const ROUTE_NAME = "/user_following";
  final String heroTag = DateTime.now().millisecondsSinceEpoch.toString();
  final String login;
  UserFollowingPage(this.login, {Key key}): super(key: key);

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
              S.current.following,
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
      body: _FollowingGrid(this.login, tag: heroTag,),
    );
  }

}

class _FollowingGrid extends BaseGridWidget {
  final String tag;
  final String login;
  _FollowingGrid(this.login, {this.tag, Key key}): super(crossAxisCount: 2, childAspectRatio: 2, key: key);

  @override
  _FollowingGridState createState() => _FollowingGridState();
}

class _FollowingGridState extends BaseGridWidgetState<_FollowingGrid, UserEntity> {

  @override
  Future<List<UserEntity>> getDatum(int expectationPage) {
    return ApiService.getUserFollowing(widget.login, page: expectationPage);
  }

  @override
  Widget buildItem(UserEntity entity, int index) {
    return UserItem(entity, tag: 'user_following_${widget.tag ?? ''}',);
  }
}