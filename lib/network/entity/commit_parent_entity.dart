import 'package:githao/network/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'commit_parent_entity.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)

@JsonSerializable()
class CommitParentEntity {
  @JsonKey(name: 'html_url')
  String htmlUrl;
  String url;
  String sha;


  CommitParentEntity({this.htmlUrl, this.url, this.sha});

  factory CommitParentEntity.fromJson(Map<String, dynamic> json) => _$CommitParentEntityFromJson(json);
  Map<String, dynamic> toJson() => _$CommitParentEntityToJson(this);

  @override
  String toString() {
    return '{htmlUrl: $htmlUrl, url: $url, sha: $sha}';
  }


}
