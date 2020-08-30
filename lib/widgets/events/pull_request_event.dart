import 'package:flutter/material.dart';
import 'package:githao/network/entity/event_entity.dart';
import 'package:githao/network/entity/event_pull_request_payload.dart';

import 'event_common_avatar.dart';

class PullRequestEventItem extends StatelessWidget {
  final EventEntity entity;
  final int index;
  PullRequestEventItem(this.entity, this.index, {Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    if(entity.type != EventTypes.pullRequestEvent) return Text('Not ${EventTypes.pullRequestEvent} !');
    EventPullRequestPayload payload = EventPullRequestPayload.fromJson(entity.payload);

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
                    text: '${payload.action.substring(0, 1).toUpperCase()}${payload.action.substring(1, payload.action.length)}',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                  ),
                  TextSpan(
                    text: ' pull request #${payload.number} in ',
                  ),
                  TextSpan(
                    text: entity.repo.name,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4),
            RichText(
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: payload.pullRequest.title,
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}