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
        : CommitCommit.fromJson(json['commit'] as Map<String, dynamic>),
    author: json['author'] == null
        ? null
        : UserEntity.fromJson(json['author'] as Map<String, dynamic>),
    committer: json['committer'] == null
        ? null
        : UserEntity.fromJson(json['committer'] as Map<String, dynamic>),
    parents: (json['parents'] as List)
        ?.map((e) =>
            e == null ? null : CommitParent.fromJson(e as Map<String, dynamic>))
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

CommitParent _$CommitParentFromJson(Map<String, dynamic> json) {
  return CommitParent(
    url: json['url'] as String,
    sha: json['sha'] as String,
  );
}

Map<String, dynamic> _$CommitParentToJson(CommitParent instance) =>
    <String, dynamic>{
      'url': instance.url,
      'sha': instance.sha,
    };

CommitCommit _$CommitCommitFromJson(Map<String, dynamic> json) {
  return CommitCommit(
    url: json['url'] as String,
    message: json['message'] as String,
    commentCount: json['comment_count'] as int,
    author: json['author'] == null
        ? null
        : CommitCommitAuthor.fromJson(json['author'] as Map<String, dynamic>),
    committer: json['committer'] == null
        ? null
        : CommitCommitAuthor.fromJson(
            json['committer'] as Map<String, dynamic>),
    tree: json['tree'] == null
        ? null
        : CommitParent.fromJson(json['tree'] as Map<String, dynamic>),
    verification: json['verification'] == null
        ? null
        : CommitCommitVerification.fromJson(
            json['verification'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommitCommitToJson(CommitCommit instance) =>
    <String, dynamic>{
      'url': instance.url,
      'message': instance.message,
      'comment_count': instance.commentCount,
      'author': instance.author,
      'committer': instance.committer,
      'tree': instance.tree,
      'verification': instance.verification,
    };

CommitCommitAuthor _$CommitCommitAuthorFromJson(Map<String, dynamic> json) {
  return CommitCommitAuthor(
    name: json['name'] as String,
    email: json['email'] as String,
    date: json['date'] as String,
  );
}

Map<String, dynamic> _$CommitCommitAuthorToJson(CommitCommitAuthor instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'date': instance.date,
    };

CommitCommitVerification _$CommitCommitVerificationFromJson(
    Map<String, dynamic> json) {
  return CommitCommitVerification(
    verified: json['verified'] as bool,
    reason: json['reason'] as String,
    signature: json['signature'],
    payload: json['payload'],
  );
}

Map<String, dynamic> _$CommitCommitVerificationToJson(
        CommitCommitVerification instance) =>
    <String, dynamic>{
      'verified': instance.verified,
      'reason': instance.reason,
      'signature': instance.signature,
      'payload': instance.payload,
    };
