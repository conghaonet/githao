import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/pages/profile_page.dart';
import 'package:githao/routes/profile_page_args.dart';

class UserItem extends StatelessWidget {
  final UserEntity user;
  final String tag;
  UserItem(this.user, {this.tag, Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    String _heroTag = 'useritem_${this.tag ?? ''}_${this.user.login}';
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, ProfilePage.ROUTE_NAME, arguments: ProfilePageArgs(
            userEntity: this.user,
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
                        backgroundImage: CachedNetworkImageProvider(this.user.avatarUrl),
                        backgroundColor: Colors.black12,
                      ),
                    ),
                    Text(
                      this.user.login,
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