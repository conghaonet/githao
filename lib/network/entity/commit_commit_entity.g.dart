// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commit_commit_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommitCommitEntity _$CommitCommitEntityFromJson(Map<String, dynamic> json) {
  return CommitCommitEntity(
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
        : CommitParentEntity.fromJson(json['tree'] as Map<String, dynamic>),
    verification: json['verification'] == null
        ? null
        : CommitCommitVerification.fromJson(
            json['verification'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommitCommitEntityToJson(CommitCommitEntity instance) =>
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
