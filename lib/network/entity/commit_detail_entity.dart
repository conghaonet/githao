import 'package:githao/network/entity/commit_commit_entity.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'commit_parent_entity.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'commit_detail_entity.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class CommitDetailEntity {
  @JsonKey(name: 'comments_url')
  String commentsUrl;
  @JsonKey(name: 'node_id')
  String nodeId;
  @JsonKey(name: 'html_url')
  String htmlUrl;
  String sha;
  String url;
  UserEntity author;
  CommitCommitEntity commit;
  UserEntity committer;
  List<CommitDetailFile> files;
  List<CommitParentEntity> parents;
  CommitDetailStats stats;


  CommitDetailEntity({this.commentsUrl, this.nodeId, this.htmlUrl, this.sha, this.url, this.author, this.commit, this.committer, this.files,
    this.parents, this.stats});

  factory CommitDetailEntity.fromJson(Map<String, dynamic> json) => _$CommitDetailEntityFromJson(json);
  Map<String, dynamic> toJson() => _$CommitDetailEntityToJson(this);

  @override
  String toString() {
    return '{commentsUrl: $commentsUrl, nodeId: $nodeId, htmlUrl: $htmlUrl, sha: $sha, url: $url, author: $author, commit: $commit, committer: $committer, files: $files, parents: $parents, stats: $stats}';
  }


}

@JsonSerializable()
class CommitDetailFile{
  String filename;
  int additions;
  int deletions;
  int changes;
  String status;
  @JsonKey(name: 'raw_url')
  String rawUrl;
  @JsonKey(name: 'blob_url')
  String blobUrl;
  String patch;

  CommitDetailFile({this.filename, this.additions, this.deletions, this.changes, this.status, this.rawUrl, this.blobUrl, this.patch});

  factory CommitDetailFile.fromJson(Map<String, dynamic> json) => _$CommitDetailFileFromJson(json);
  Map<String, dynamic> toJson() => _$CommitDetailFileToJson(this);

  @override
  String toString() {
    return '{filename: $filename, additions: $additions, deletions: $deletions, changes: $changes, status: $status, rawUrl: $rawUrl, blobUrl: $blobUrl, patch: $patch}';
  }

}


@JsonSerializable()
class CommitDetailStats{
  int additions;
  int deletions;
  int total;

  CommitDetailStats({this.additions, this.deletions, this.total});

  factory CommitDetailStats.fromJson(Map<String, dynamic> json) => _$CommitDetailStatsFromJson(json);
  Map<String, dynamic> toJson() => _$CommitDetailStatsToJson(this);

  @override
  String toString() {
    return '{additions: $additions, deletions: $deletions, total: $total}';
  }

}




