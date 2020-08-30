import 'package:flutter/material.dart';
import 'package:githao/network/entity/event_entity.dart';
import 'package:githao/network/entity/event_release_payload.dart';

import 'event_common_avatar.dart';

class ReleaseEventItem extends StatelessWidget {
  final EventEntity entity;
  final int index;
  ReleaseEventItem(this.entity, this.index, {Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    if(entity.type != EventTypes.releaseEvent) return Text('Not ${EventTypes.releaseEvent} !');
    EventReleasePayload payload = EventReleasePayload.fromJson(entity.payload);

    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            EventCommonAvatar(entity, index),
            SizedBox(height: 4,),
            RichText(
              text: TextSpan(
                text: '',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
                children: <TextSpan>[
                  TextSpan(
                    text: '${payload.action.substring(0, 1).toUpperCase()}${payload.action.substring(1, payload.action.length)}',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                  ),
                  TextSpan(
                    text: ' ${payload.release.name} at '
                  ),
                  TextSpan(
                    text: entity.repo.name,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: payload.release.body != null ? 4 : 0,),
            Offstage(
              offstage: payload.release.body == null,
              child: RichText(
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: payload.release.body ?? '',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}