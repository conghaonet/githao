import 'package:json_annotation/json_annotation.dart';

import 'comment_entity.dart';
import 'issue_entity.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'event_issue_comment_payload.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class EventIssueCommentPayload {
  static final actionCreated= 'created';
  static final actionEdited = 'edited';
  static final actionDeleted = 'deleted';

  String action;
  IssueEntity issue;
  CommentEntity comment;

  EventIssueCommentPayload({this.action, this.issue, this.comment});

  factory EventIssueCommentPayload.fromJson(Map<String, dynamic> json) => _$EventIssueCommentPayloadFromJson(json);
  Map<String, dynamic> toJson() => _$EventIssueCommentPayloadToJson(this);

  @override
  String toString() {
    return '{action: $action, issue: $issue, comment: $comment}';
  }
}
