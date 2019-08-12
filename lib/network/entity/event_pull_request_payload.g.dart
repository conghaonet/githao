// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_pull_request_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventPullRequestPayload _$EventPullRequestPayloadFromJson(
    Map<String, dynamic> json) {
  return EventPullRequestPayload(
    action: json['action'] as String,
    number: json['number'] as int,
    pullRequest: json['pull_request'] == null
        ? null
        : PullRequestEntity.fromJson(
            json['pull_request'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EventPullRequestPayloadToJson(
        EventPullRequestPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'number': instance.number,
      'pull_request': instance.pullRequest,
    };
