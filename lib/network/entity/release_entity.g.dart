// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'release_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReleaseEntity _$ReleaseEntityFromJson(Map<String, dynamic> json) {
  return ReleaseEntity(
    id: json['id'] as int,
    noteId: json['node_id'] as String,
    tagName: json['tag_name'] as String,
    name: json['name'] as String,
    draft: json['draft'] as bool,
    prerelease: json['prerelease'] as bool,
    createdAt: json['created_at'] as String,
    publishedAt: json['published_at'] as String,
    body: json['body'] as String,
    htmlUrl: json['html_url'] as String,
    author: json['author'] == null
        ? null
        : UserEntity.fromJson(json['author'] as Map<String, dynamic>),
    tarballUrl: json['tarball_url'] as String,
    zipballUrl: json['zipball_url'] as String,
    assets: (json['assets'] as List)
        ?.map((e) =>
            e == null ? null : AssetEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ReleaseEntityToJson(ReleaseEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'node_id': instance.noteId,
      'tag_name': instance.tagName,
      'name': instance.name,
      'draft': instance.draft,
      'prerelease': instance.prerelease,
      'created_at': instance.createdAt,
      'published_at': instance.publishedAt,
      'body': instance.body,
      'html_url': instance.htmlUrl,
      'author': instance.author,
      'tarball_url': instance.tarballUrl,
      'zipball_url': instance.zipballUrl,
      'assets': instance.assets,
    };
