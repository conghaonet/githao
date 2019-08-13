import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:githao/network/entity/event_entity.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:githao/pages/profile.dart';
import 'package:githao/routes/profile_page_args.dart';
import 'package:githao/utils/util.dart';
class EventCommonAvatar extends StatelessWidget {
  final EventEntity entity;
  final int index;
  EventCommonAvatar(this.entity, this.index, {Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    String heroTag = 'events_${entity.actor.login}$index';
    UserEntity _userEntity = UserEntity(login: entity.actor.login, avatarUrl: entity.actor.avatarUrl);
    return Row(
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context, ProfilePage.ROUTE_NAME,
              arguments: ProfilePageArgs(
                  userEntity: _userEntity,
                  heroTag: heroTag
              ),
            );
          },
          child: Hero(
            //默认情况下，当在 iOS 上按后退按钮时，hero 动画会有效果，但它们在手势滑动时并没有。
            //要解决此问题，只需在两个 Hero 组件上将 transitionOnUserGestures 设置为 true 即可
            transitionOnUserGestures: true,
            tag: heroTag,
            child: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(entity.actor.avatarUrl),
              backgroundColor: Colors.black12,
            ),
          ),
        ),
        SizedBox(width: 8,),
        Text(entity.actor.login),
        Spacer(),
        Text(Util.getFriendlyDateTime(entity.createdAt)),
      ],
    );
  }

}