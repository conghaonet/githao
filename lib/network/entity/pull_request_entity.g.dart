// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pull_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PullRequestEntity _$PullRequestEntityFromJson(Map<String, dynamic> json) {
  return PullRequestEntity(
    id: json['id'] as int,
    number: json['number'] as int,
    state: json['state'] as String,
    locked: json['locked'] as bool,
    title: json['title'] as String,
    body: json['body'] as String,
    user: json['user'] == null
        ? null
        : UserEntity.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PullRequestEntityToJson(PullRequestEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'state': instance.state,
      'locked': instance.locked,
      'title': instance.title,
      'body': instance.body,
      'user': instance.user,
    };
