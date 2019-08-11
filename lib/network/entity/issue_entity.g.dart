// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueEntity _$IssueEntityFromJson(Map<String, dynamic> json) {
  return IssueEntity(
    id: json['id'] as int,
    number: json['number'] as int,
    comments: json['comments'] as int,
    locked: json['locked'] as bool,
    noteId: json['node_id'] as String,
    title: json['title'] as String,
    body: json['body'] as String,
    state: json['state'] as String,
    user: json['user'] == null
        ? null
        : UserEntity.fromJson(json['user'] as Map<String, dynamic>),
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
    closedAt: json['closed_at'] as String,
  );
}

Map<String, dynamic> _$IssueEntityToJson(IssueEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'comments': instance.comments,
      'locked': instance.locked,
      'node_id': instance.noteId,
      'title': instance.title,
      'body': instance.body,
      'state': instance.state,
      'user': instance.user,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'closed_at': instance.closedAt,
    };
