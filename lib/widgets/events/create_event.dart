import 'package:flutter/material.dart';
import 'package:githao/network/entity/event_create_payload.dart';
import 'package:githao/network/entity/event_entity.dart';
import 'package:githao/network/entity/event_fork_payload.dart';

import 'event_common_avatar.dart';

class CreateEventItem extends StatelessWidget {
  final EventEntity entity;
  final int index;
  CreateEventItem(this.entity, this.index, {Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    if(entity.type != EventTypes.createEvent) return Text('Not ${EventTypes.createEvent} !');
    EventCreatePayload payload = EventCreatePayload.fromJson(entity.payload);

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
                    text: 'Created ',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                  ),
                  TextSpan(
                    text: ' ${payload.refType} ${payload.ref} at ',
                  ),
                  TextSpan(
                    text: entity.repo.name,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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