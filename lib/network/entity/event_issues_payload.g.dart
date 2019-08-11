// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_issues_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventIssuesPayload _$EventIssuesPayloadFromJson(Map<String, dynamic> json) {
  return EventIssuesPayload(
    action: json['action'] as String,
    issue: json['issue'] == null
        ? null
        : IssueEntity.fromJson(json['issue'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EventIssuesPayloadToJson(EventIssuesPayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'issue': instance.issue,
    };
