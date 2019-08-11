// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentEntity _$CommentEntityFromJson(Map<String, dynamic> json) {
  return CommentEntity(
    id: json['id'] as int,
    noteId: json['node_id'] as String,
    body: json['body'] as String,
    user: json['user'] == null
        ? null
        : UserEntity.fromJson(json['user'] as Map<String, dynamic>),
    authorAssociation: json['author_association'] as String,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
  );
}

Map<String, dynamic> _$CommentEntityToJson(CommentEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'node_id': instance.noteId,
      'body': instance.body,
      'user': instance.user,
      'author_association': instance.authorAssociation,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
