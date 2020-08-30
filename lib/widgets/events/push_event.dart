import 'package:flutter/material.dart';
import 'package:githao/network/entity/event_entity.dart';
import 'package:githao/network/entity/event_push_payload.dart';
import 'package:githao/widgets/events/event_common_avatar.dart';
class PushEventItem extends StatelessWidget {
  final EventEntity entity;
  final int index;
  PushEventItem(this.entity, this.index, {Key key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    if(entity.type != EventTypes.pushEvent) return Text('Not ${EventTypes.pushEvent} !');
    EventPushPayload payload = EventPushPayload.fromJson(entity.payload);
    List<Widget> commits = [];
    int maxLine = 4;
    for(int i=0; i<payload.commits.length && i<maxLine; i++) {
      RichText richText;
      if(i < (maxLine - 1)) {
        richText = RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: '',
            style: TextStyle(color: Colors.black54, fontSize: 16),
            children: <TextSpan>[
              TextSpan(
                  text: '${payload.commits[i].sha.substring(0, 7)}  ',
                  style: TextStyle(color: Theme.of(context).primaryColor)
              ),
              TextSpan(
                text: payload.commits[i].message
              ),
            ],
          ),
        );
      } else if(i == (maxLine -1)) {
        richText = RichText(text: TextSpan(
          text: '...',
          style: TextStyle(color: Colors.black54, fontSize: 16),
        ));
      }
      commits.add(richText);
    }
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            EventCommonAvatar(entity, index),
            SizedBox(height: 4),
            Row(
              children: <Widget>[
                Expanded(
                  child: RichText(text: TextSpan(
                      text: '',
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                      children: <TextSpan>[
                        TextSpan(
                          text: EventTypes.pushEvent.replaceAll('Event', ''),
                          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                        ),
                        TextSpan(
                          text: ' to ${payload.ref.replaceAll('refs/heads/', '')} at ',
                        ),
                        TextSpan(
                          text: entity.repo.name,
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ]
                  ),),
                ),
              ],
            ),
            SizedBox(height: 4),
          ]..addAll(commits),
        ),
      ),
    );
  }
}