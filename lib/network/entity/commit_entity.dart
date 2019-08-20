import 'package:githao/network/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'commit_entity.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class CommitEntity {
  String url;
  String sha;
  @JsonKey(name: 'node_id')
  String nodeId;
  @JsonKey(name: 'html_url')
  String htmlUrl;
  @JsonKey(name: 'comments_url')
  String commentsUrl;
  CommitCommit commit;
  UserEntity author;
  UserEntity committer;
  List<CommitParent> parents;

  CommitEntity({this.url, this.sha, this.nodeId, this.htmlUrl, this.commentsUrl, this.commit, this.author, this.committer, this.parents});

  factory CommitEntity.fromJson(Map<String, dynamic> json) => _$CommitEntityFromJson(json);
  Map<String, dynamic> toJson() => _$CommitEntityToJson(this);

  @override
  String toString() {
    return '{url: $url, sha: $sha, nodeId: $nodeId, htmlUrl: $htmlUrl, commentsUrl: $commentsUrl, commit: $commit, author: $author, committer: $committer, parents: $parents}';
  }

}

@JsonSerializable()
class CommitParent {
  String url;
  String sha;

  CommitParent({this.url, this.sha});

  factory CommitParent.fromJson(Map<String, dynamic> json) => _$CommitParentFromJson(json);
  Map<String, dynamic> toJson() => _$CommitParentToJson(this);

  @override
  String toString() {
    return '{url: $url, sha: $sha}';
  }

}

@JsonSerializable()
class CommitCommit {
  String url;
  String message;
  @JsonKey(name: 'comment_count')
  int commentCount;
  CommitCommitAuthor author;
  CommitCommitAuthor committer;
  CommitParent tree;
  CommitCommitVerification verification;

  CommitCommit({this.url, this.message, this.commentCount, this.author, this.committer, this.tree, this.verification});

  factory CommitCommit.fromJson(Map<String, dynamic> json) => _$CommitCommitFromJson(json);
  Map<String, dynamic> toJson() => _$CommitCommitToJson(this);

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
