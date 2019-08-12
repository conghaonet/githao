import 'package:json_annotation/json_annotation.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'event_push_payload.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class EventPushPayload {
  @JsonKey(name: 'push_id')
  int pushId;
  int size;
  @JsonKey(name: 'distinct_size')
  int distinctSize;
  String ref;
  String head;
  String before;
  List<EventPushPayloadCommit> commits;

  EventPushPayload({this.pushId, this.size, this.distinctSize, this.ref, this.head, this.before, this.commits});

  factory EventPushPayload.fromJson(Map<String, dynamic> json) => _$EventPushPayloadFromJson(json);
  Map<String, dynamic> toJson() => _$EventPushPayloadToJson(this);

  @override
  String toString() {
    return '{pushId: $pushId, size: $size, distinctSize: $distinctSize, ref: $ref, head: $head, before: $before, commits: $commits}';
  }
}

@JsonSerializable()
class EventPushPayloadCommit {
  String sha;
  String message;
  bool distinct;
  String url;
  EventPushPayloadAuthor author;

  EventPushPayloadCommit({this.sha, this.message, this.distinct, this.url, this.author});
  factory EventPushPayloadCommit.fromJson(Map<String, dynamic> json) => _$EventPushPayloadCommitFromJson(json);
  Map<String, dynamic> toJson() => _$EventPushPayloadCommitToJson(this);

  @override
  String toString() {
    return '{sha: $sha, message: $message, distinct: $distinct, url: $url, author: $author}';
  }
}

@JsonSerializable()
class EventPushPayloadAuthor {
  String email;
  String name;

  EventPushPayloadAuthor({this.email, this.name});
  factory EventPushPayloadAuthor.fromJson(Map<String, dynamic> json) => _$EventPushPayloadAuthorFromJson(json);
  Map<String, dynamic> toJson() => _$EventPushPayloadAuthorToJson(this);

  @override
  String toString() {
    return '{email: $email, name: $name}';
  }
}
