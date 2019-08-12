import 'package:json_annotation/json_annotation.dart';

import 'pull_request_entity.dart';


/// .g.dart 将在我们运行生成命令后自动生成
part 'event_pull_request_payload.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class EventPullRequestPayload {
  String action;
  int number;
  @JsonKey(name: 'pull_request')
  PullRequestEntity pullRequest;

  EventPullRequestPayload({this.action, this.number, this.pullRequest});

  factory EventPullRequestPayload.fromJson(Map<String, dynamic> json) => _$EventPullRequestPayloadFromJson(json);
  Map<String, dynamic> toJson() => _$EventPullRequestPayloadToJson(this);

  @override
  String toString() {
    return '{action: $action, number: $number, pullRequest: $pullRequest}';
  }
}

