// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_push_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventPushPayload _$EventPushPayloadFromJson(Map<String, dynamic> json) {
  return EventPushPayload(
    pushId: json['push_id'] as int,
    size: json['size'] as int,
    distinctSize: json['distinct_size'] as int,
    ref: json['ref'] as String,
    head: json['head'] as String,
    before: json['before'] as String,
    commits: (json['commits'] as List)
        ?.map((e) => e == null
            ? null
            : EventPushPayloadCommit.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$EventPushPayloadToJson(EventPushPayload instance) =>
    <String, dynamic>{
      'push_id': instance.pushId,
      'size': instance.size,
      'distinct_size': instance.distinctSize,
      'ref': instance.ref,
      'head': instance.head,
      'before': instance.before,
      'commits': instance.commits,
    };

EventPushPayloadCommit _$EventPushPayloadCommitFromJson(
    Map<String, dynamic> json) {
  return EventPushPayloadCommit(
    sha: json['sha'] as String,
    message: json['message'] as String,
    distinct: json['distinct'] as bool,
    url: json['url'] as String,
    author: json['author'] == null
        ? null
        : EventPushPayloadAuthor.fromJson(
            json['author'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EventPushPayloadCommitToJson(
        EventPushPayloadCommit instance) =>
    <String, dynamic>{
      'sha': instance.sha,
      'message': instance.message,
      'distinct': instance.distinct,
      'url': instance.url,
      'author': instance.author,
    };

EventPushPayloadAuthor _$EventPushPayloadAuthorFromJson(
    Map<String, dynamic> json) {
  return EventPushPayloadAuthor(
    email: json['email'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$EventPushPayloadAuthorToJson(
        EventPushPayloadAuthor instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
    };
