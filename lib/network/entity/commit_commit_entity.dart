import 'package:githao/network/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'commit_parent_entity.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'commit_commit_entity.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class CommitCommitEntity {
  String url;
  String message;
  @JsonKey(name: 'comment_count')
  int commentCount;
  CommitCommitAuthor author;
  CommitCommitAuthor committer;
  CommitParentEntity tree;
  CommitCommitVerification verification;

  CommitCommitEntity({this.url, this.message, this.commentCount, this.author, this.committer, this.tree, this.verification});

  factory CommitCommitEntity.fromJson(Map<String, dynamic> json) => _$CommitCommitEntityFromJson(json);
  Map<String, dynamic> toJson() => _$CommitCommitEntityToJson(this);

  @override
  String toString() {
    return '{url: $url, message: $message, commentCount: $commentCount, author: $author, committer: $committer, tree: $tree, verification: $verification}';
  }

}

@JsonSerializable()
class CommitCommitAuthor {
  String name;
  String email;
  String date;

  CommitCommitAuthor({this.name, this.email, this.date});

  factory CommitCommitAuthor.fromJson(Map<String, dynamic> json) => _$CommitCommitAuthorFromJson(json);
  Map<String, dynamic> toJson() => _$CommitCommitAuthorToJson(this);

  @override
  String toString() {
    return '{name: $name, email: $email, date: $date}';
  }
}

@JsonSerializable()
class CommitCommitVerification {
  bool verified;
  String reason;
  dynamic signature;
  dynamic payload;

  CommitCommitVerification({this.verified, this.reason, this.signature, this.payload});

  factory CommitCommitVerification.fromJson(Map<String, dynamic> json) => _$CommitCommitVerificationFromJson(json);
  Map<String, dynamic> toJson() => _$CommitCommitVerificationToJson(this);

  @override
  String toString() {
    return '{verified: $verified, reason: $reason, signature: $signature, payload: $payload}';
  }


}
