import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:githao/network/api_service.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/pages/profile.dart';
import 'package:githao/routes/profile_page_args.dart';
import 'package:githao/widgets/base_grid.dart';
import 'package:githao/generated/i18n.dart';

class UserFollowingPage extends StatelessWidget {
  static const ROUTE_NAME = "/user_following";
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
      body: _FollowingGrid(this.login),
    );
  }

}

class _FollowingGrid extends BaseGridWidget {
  final String login;
  _FollowingGrid(this.login, {Key key}): super(crossAxisCount: 2, childAspectRatio: 2, key: key);

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
    String _heroTag = entity.login;
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, ProfilePage.ROUTE_NAME, arguments: ProfilePageArgs(
            userEntity: entity,
            heroTag: _heroTag,
          ),);
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 80,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Hero(
                      //默认情况下，当在 iOS 上按后退按钮时，hero 动画会有效果，但它们在手势滑动时并没有。
                      //要解决此问题，只需在两个 Hero 组件上将 transitionOnUserGestures 设置为 true 即可
                      transitionOnUserGestures: true,
                      tag: _heroTag,
                      child: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(entity.avatarUrl),
                        backgroundColor: Colors.black12,
                      ),
                    ),
                    Text(
                      entity.login,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}