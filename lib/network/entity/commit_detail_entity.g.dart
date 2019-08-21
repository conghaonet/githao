// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commit_detail_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommitDetailEntity _$CommitDetailEntityFromJson(Map<String, dynamic> json) {
  return CommitDetailEntity(
    commentsUrl: json['comments_url'] as String,
    nodeId: json['node_id'] as String,
    htmlUrl: json['html_url'] as String,
    sha: json['sha'] as String,
    url: json['url'] as String,
    author: json['author'] == null
        ? null
        : UserEntity.fromJson(json['author'] as Map<String, dynamic>),
    commit: json['commit'] == null
        ? null
        : CommitCommitEntity.fromJson(json['commit'] as Map<String, dynamic>),
    committer: json['committer'] == null
        ? null
        : UserEntity.fromJson(json['committer'] as Map<String, dynamic>),
    files: (json['files'] as List)
        ?.map((e) => e == null
            ? null
            : CommitDetailFile.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    parents: (json['parents'] as List)
        ?.map((e) => e == null
            ? null
            : CommitParentEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    stats: json['stats'] == null
        ? null
        : CommitDetailStats.fromJson(json['stats'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommitDetailEntityToJson(CommitDetailEntity instance) =>
    <String, dynamic>{
      'comments_url': instance.commentsUrl,
      'node_id': instance.nodeId,
      'html_url': instance.htmlUrl,
      'sha': instance.sha,
      'url': instance.url,
      'author': instance.author,
      'commit': instance.commit,
      'committer': instance.committer,
      'files': instance.files,
      'parents': instance.parents,
      'stats': instance.stats,
    };

CommitDetailFile _$CommitDetailFileFromJson(Map<String, dynamic> json) {
  return CommitDetailFile(
    filename: json['filename'] as String,
    additions: json['additions'] as int,
    deletions: json['deletions'] as int,
    changes: json['changes'] as int,
    status: json['status'] as String,
    rawUrl: json['raw_url'] as String,
    blobUrl: json['blob_url'] as String,
    patch: json['patch'] as String,
  );
}

Map<String, dynamic> _$CommitDetailFileToJson(CommitDetailFile instance) =>
    <String, dynamic>{
      'filename': instance.filename,
      'additions': instance.additions,
      'deletions': instance.deletions,
      'changes': instance.changes,
      'status': instance.status,
      'raw_url': instance.rawUrl,
      'blob_url': instance.blobUrl,
      'patch': instance.patch,
    };

CommitDetailStats _$CommitDetailStatsFromJson(Map<String, dynamic> json) {
  return CommitDetailStats(
    additions: json['additions'] as int,
    deletions: json['deletions'] as int,
    total: json['total'] as int,
  );
}

Map<String, dynamic> _$CommitDetailStatsToJson(CommitDetailStats instance) =>
    <String, dynamic>{
      'additions': instance.additions,
      'deletions': instance.deletions,
      'total': instance.total,
    };
