import 'package:githao/network/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'asset_entity.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'release_entity.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class ReleaseEntity {
  int id;
  @JsonKey(name: 'node_id')
  String noteId;
  @JsonKey(name: 'tag_name')
  String tagName;
  String name;
  bool draft;
  bool prerelease;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'published_at')
  String publishedAt;
  String body;
  @JsonKey(name: 'html_url')
  String htmlUrl;
  UserEntity author;
  @JsonKey(name: 'tarball_url')
  String tarballUrl;
  @JsonKey(name: 'zipball_url')
  String zipballUrl;
  List<AssetEntity> assets;


  ReleaseEntity({this.id, this.noteId, this.tagName, this.name, this.draft, this.prerelease, this.createdAt, this.publishedAt, this.body, this.htmlUrl,
    this.author, this.tarballUrl, this.zipballUrl, this.assets});

  factory ReleaseEntity.fromJson(Map<String, dynamic> json) => _$ReleaseEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ReleaseEntityToJson(this);

  @override
  String toString() {
    return '{id: $id, noteId: $noteId, tagName: $tagName, name: $name, draft: $draft, prerelease: $prerelease, createdAt: $createdAt, publishedAt: $publishedAt, body: $body, htmlUrl: $htmlUrl, author: $author, tarballUrl: $tarballUrl, zipballUrl: $zipballUrl, assets: $assets}';
  }
}
