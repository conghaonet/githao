// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepoContentEntity _$RepoContentEntityFromJson(Map<String, dynamic> json) {
  return RepoContentEntity(
    json['type'] as String,
    json['encoding'] as String,
    json['size'] as int,
    json['name'] as String,
    json['path'] as String,
    json['content'] as String,
    json['sha'] as String,
    json['url'] as String,
    json['git_url'] as String,
    json['html_url'] as String,
    json['download_url'] as String,
    json['_links'] == null
        ? null
        : RepoContentLinks.fromJson(json['_links'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RepoContentEntityToJson(RepoContentEntity instance) =>
    <String, dynamic>{
      'type': instance.type,
      'encoding': instance.encoding,
      'size': instance.size,
      'name': instance.name,
      'path': instance.path,
      'content': instance.content,
      'sha': instance.sha,
      'url': instance.url,
      'git_url': instance.gitUrl,
      'html_url': instance.htmlUrl,
      'download_url': instance.downloadUrl,
      '_links': instance.links,
    };

RepoContentLinks _$RepoContentLinksFromJson(Map<String, dynamic> json) {
  return RepoContentLinks(
    json['git'] as String,
    json['self'] as String,
    json['html'] as String,
  );
}

Map<String, dynamic> _$RepoContentLinksToJson(RepoContentLinks instance) =>
    <String, dynamic>{
      'git': instance.git,
      'self': instance.self,
      'html': instance.html,
    };
