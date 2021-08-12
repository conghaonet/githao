// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repos_queries_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReposQueriesEntity _$ReposQueriesEntityFromJson(Map<String, dynamic> json) {
  return ReposQueriesEntity(
    sort: json['sort'] as String,
    page: json['page'] as int,
    perPage: json['per_page'] as int,
    type: json['type'] as String?,
    visibility: json['visibility'] as String?,
    affiliation: json['affiliation'] as String?,
  );
}

Map<String, dynamic> _$ReposQueriesEntityToJson(ReposQueriesEntity instance) =>
    <String, dynamic>{
      'sort': instance.sort,
      'page': instance.page,
      'per_page': instance.perPage,
      'type': instance.type,
      'visibility': instance.visibility,
      'affiliation': instance.affiliation,
    };
