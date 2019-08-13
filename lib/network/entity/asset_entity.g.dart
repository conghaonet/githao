// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetEntity _$AssetEntityFromJson(Map<String, dynamic> json) {
  return AssetEntity(
    id: json['id'] as int,
    noteId: json['node_id'] as String,
    name: json['name'] as String,
    label: json['label'] as String,
    uploader: json['uploader'] == null
        ? null
        : UserEntity.fromJson(json['uploader'] as Map<String, dynamic>),
    contentType: json['content_type'] as String,
    state: json['state'] as String,
    size: json['size'] as int,
    downloadCount: json['download_count'] as int,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
    browserDownloadUrl: json['browser_download_url'] as String,
  );
}

Map<String, dynamic> _$AssetEntityToJson(AssetEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'node_id': instance.noteId,
      'name': instance.name,
      'label': instance.label,
      'uploader': instance.uploader,
      'content_type': instance.contentType,
      'state': instance.state,
      'size': instance.size,
      'download_count': instance.downloadCount,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'browser_download_url': instance.browserDownloadUrl,
    };
