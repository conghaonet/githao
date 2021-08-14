import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:githao/network/entity/org/org_entity.dart';

class OrgItemView extends StatelessWidget {
  final OrgEntity orgEntity;
  const OrgItemView(this.orgEntity, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(orgEntity.avatarUrl!),
        ),
        title: Row(
          children: [
            Flexible(
              child: Text(orgEntity.login!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
