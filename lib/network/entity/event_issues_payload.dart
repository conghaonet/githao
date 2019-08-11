import 'package:json_annotation/json_annotation.dart';

import 'issue_entity.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'event_issues_payload.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class EventIssuesPayload {
  static final actionOpened = 'opened';
  static final actionEdited = 'edited';
  static final actionDeleted = 'deleted';
  static final actionTransferred = 'transferred';
  static final actionPinned = 'pinned';
  static final actionUnpinned = 'unpinned';
  static final actionClosed = 'closed';
  static final actionReopened = 'reopened';
  static final actionAssigned = 'assigned';
  static final actionUnassigned = 'unassigned';
  static final actionLabeled = 'labeled';
  static final actionUnlabeled = 'unlabeled';
  static final actionLocked = 'locked';
  static final actionUnlocked = 'unlocked';
  static final actionMilestoned = 'milestoned';
  static final actionDemilestoned = 'demilestoned';

  String action;
  IssueEntity issue;

  EventIssuesPayload({this.action, this.issue});

  factory EventIssuesPayload.fromJson(Map<String, dynamic> json) => _$EventIssuesPayloadFromJson(json);
  Map<String, dynamic> toJson() => _$EventIssuesPayloadToJson(this);

  @override
  String toString() {
    return '{action: $action, issue: $issue}';
  }


}
