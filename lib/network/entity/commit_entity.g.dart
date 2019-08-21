// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commit_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommitEntity _$CommitEntityFromJson(Map<String, dynamic> json) {
  return CommitEntity(
    url: json['url'] as String,
    sha: json['sha'] as String,
    nodeId: json['node_id'] as String,
    htmlUrl: json['html_url'] as String,
    commentsUrl: json['comments_url'] as String,
    commit: json['commit'] == null
        ? null
        : CommitCommitEntity.fromJson(json['commit'] as Map<String, dynamic>),
    author: json['author'] == null
        ? null
        : UserEntity.fromJson(json['author'] as Map<String, dynamic>),
    committer: json['committer'] == null
        ? null
        : UserEntity.fromJson(json['committer'] as Map<String, dynamic>),
    parents: (json['parents'] as List)
        ?.map((e) => e == null
            ? null
            : CommitParentEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CommitEntityToJson(CommitEntity instance) =>
    <String, dynamic>{
      'url': instance.url,
      'sha': instance.sha,
      'node_id': instance.nodeId,
      'html_url': instance.htmlUrl,
      'comments_url': instance.commentsUrl,
      'commit': instance.commit,
      'author': instance.author,
      'committer': instance.committer,
      'parents': instance.parents,
    };
