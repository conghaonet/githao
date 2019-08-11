// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_issue_comment_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventIssueCommentPayload _$EventIssueCommentPayloadFromJson(
    Map<String, dynamic> json) {
  return EventIssueCommentPayload(
    action: json['action'] as String,
    issue: json['issue'] == null
        ? null
        : IssueEntity.fromJson(json['issue'] as Map<String, dynamic>),
    comment: json['comment'] == null
        ? null
        : CommentEntity.fromJson(json['comment'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EventIssueCommentPayloadToJson(
        EventIssueCommentPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'issue': instance.issue,
      'comment': instance.comment,
    };
