import 'package:githao/network/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'commit_commit_entity.dart';
import 'commit_parent_entity.dart';

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
  CommitCommitEntity commit;
  UserEntity author;
  UserEntity committer;
  List<CommitParentEntity> parents;

  CommitEntity({this.url, this.sha, this.nodeId, this.htmlUrl, this.commentsUrl, this.commit, this.author, this.committer, this.parents});

  factory CommitEntity.fromJson(Map<String, dynamic> json) => _$CommitEntityFromJson(json);
  Map<String, dynamic> toJson() => _$CommitEntityToJson(this);

  @override
  String toString() {
    return '{url: $url, sha: $sha, nodeId: $nodeId, htmlUrl: $htmlUrl, commentsUrl: $commentsUrl, commit: $commit, author: $author, committer: $committer, parents: $parents}';
  }

}

