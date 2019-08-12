// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_pull_request_review_comment_palyoad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventPullRequestReviewCommentPayload
    _$EventPullRequestReviewCommentPayloadFromJson(Map<String, dynamic> json) {
  return EventPullRequestReviewCommentPayload(
    action: json['action'] as String,
    comment: json['comment'] == null
        ? null
        : CommentEntity.fromJson(json['comment'] as Map<String, dynamic>),
    pullRequest: json['pull_request'] == null
        ? null
        : PullRequestEntity.fromJson(
            json['pull_request'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EventPullRequestReviewCommentPayloadToJson(
        EventPullRequestReviewCommentPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'comment': instance.comment,
      'pull_request': instance.pullRequest,
    };
