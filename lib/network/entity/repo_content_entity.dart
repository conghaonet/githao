import 'package:json_annotation/json_annotation.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'repo_content_entity.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class RepoContentEntity {
  String type;
  String encoding;
  int size;
  String name;
  String path;
  String content;
  String sha;
  String url;
  @JsonKey(name: 'git_url')
  String gitUrl;
  @JsonKey(name: 'html_url')
  String htmlUrl;
  @JsonKey(name: 'download_url')
  String downloadUrl;
  @JsonKey(name: '_links')
  RepoContentLinks links;

  RepoContentEntity(this.type, this.encoding, this.size, this.name, this.path, this.content, this.sha, this.url, this.gitUrl, this.htmlUrl,
      this.downloadUrl, this.links);
  factory RepoContentEntity.fromJson(Map<String, dynamic> json) => _$RepoContentEntityFromJson(json);
  Map<String, dynamic> toJson() => _$RepoContentEntityToJson(this);

  bool get isFile => type == 'file';
  @override
  String toString() {
    return '{type: $type, encoding: $encoding, size: $size, name: $name, path: $path, content: $content, sha: $sha, url: $url, gitUrl: $gitUrl, htmlUrl: $htmlUrl, downloadUrl: $downloadUrl, links: $links}';
  }
}

@JsonSerializable()
class RepoContentLinks {
  String git;
  String self;
  String html;

  RepoContentLinks(this.git, this.self, this.html);
  factory RepoContentLinks.fromJson(Map<String, dynamic> json) => _$RepoContentLinksFromJson(json);
  Map<String, dynamic> toJson() => _$RepoContentLinksToJson(this);
  @override
  String toString() {
    return '{git: $git, self: $self, html: $html}';
  }


}