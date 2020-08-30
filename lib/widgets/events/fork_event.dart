import 'package:flutter/material.dart';
import 'package:githao/network/entity/event_entity.dart';
import 'package:githao/network/entity/event_fork_payload.dart';

import 'event_common_avatar.dart';

class ForkEventItem extends StatelessWidget {
  final EventEntity entity;
  final int index;

  ForkEventItem(this.entity, this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (entity.type != EventTypes.forkEvent)
      return Text('Not ${EventTypes.forkEvent} !');
    EventForkPayload payload = EventForkPayload.fromJson(entity.payload);

    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            EventCommonAvatar(entity, index),
            SizedBox(height: 4),
            RichText(
              text: TextSpan(
                text: '',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Forked ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                  TextSpan(
                    text: entity.repo.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextSpan(text: ' to '),
                  TextSpan(
                    text: payload.forkee.fullName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
