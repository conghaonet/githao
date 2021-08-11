// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repos_queries_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReposQueriesEntity _$ReposQueriesEntityFromJson(Map<String, dynamic> json) {
  return ReposQueriesEntity(
    sort: json['sort'] as String,
    type: json['type'] as String?,
    visibility: json['visibility'] as String?,
    affiliation: json['affiliation'] as String?,
    page: json['page'] as int,
  );
}

Map<String, dynamic> _$ReposQueriesEntityToJson(ReposQueriesEntity instance) =>
    <String, dynamic>{
      'sort': instance.sort,
      'page': instance.page,
      'type': instance.type,
      'visibility': instance.visibility,
      'affiliation': instance.affiliation,
    };
