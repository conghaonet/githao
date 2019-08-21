// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commit_parent_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommitParentEntity _$CommitParentEntityFromJson(Map<String, dynamic> json) {
  return CommitParentEntity(
    htmlUrl: json['html_url'] as String,
    url: json['url'] as String,
    sha: json['sha'] as String,
  );
}

Map<String, dynamic> _$CommitParentEntityToJson(CommitParentEntity instance) =>
    <String, dynamic>{
      'html_url': instance.htmlUrl,
      'url': instance.url,
      'sha': instance.sha,
    };
