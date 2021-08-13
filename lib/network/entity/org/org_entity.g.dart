// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'org_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrgEntity _$OrgEntityFromJson(Map<String, dynamic> json) {
  return OrgEntity(
    json['login'] as String?,
    json['id'] as int?,
    json['node_id'] as String?,
    json['url'] as String?,
    json['repos_url'] as String?,
    json['events_url'] as String?,
    json['hooks_url'] as String?,
    json['issues_url'] as String?,
    json['members_url'] as String?,
    json['public_members_url'] as String?,
    json['avatar_url'] as String?,
    json['description'] as String?,
  );
}

Map<String, dynamic> _$OrgEntityToJson(OrgEntity instance) => <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'node_id': instance.nodeId,
      'url': instance.url,
      'repos_url': instance.reposUrl,
      'events_url': instance.eventsUrl,
      'hooks_url': instance.hooksUrl,
      'issues_url': instance.issuesUrl,
      'members_url': instance.membersUrl,
      'public_members_url': instance.publicMembersUrl,
      'avatar_url': instance.avatarUrl,
      'description': instance.description,
    };
