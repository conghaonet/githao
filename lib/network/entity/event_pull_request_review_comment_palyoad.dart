import 'package:githao/network/entity/pull_request_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'comment_entity.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'event_pull_request_review_comment_palyoad.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class EventPullRequestReviewCommentPayload {
  String action;
  CommentEntity comment;
  @JsonKey(name: 'pull_request')
  PullRequestEntity pullRequest;

  EventPullRequestReviewCommentPayload({this.action, this.comment, this.pullRequest});

  factory EventPullRequestReviewCommentPayload.fromJson(Map<String, dynamic> json) => _$EventPullRequestReviewCommentPayloadFromJson(json);
  Map<String, dynamic> toJson() => _$EventPullRequestReviewCommentPayloadToJson(this);

  @override
  String toString() {
    return '{action: $action, comment: $comment, pullRequest: $pullRequest}';
  }


}