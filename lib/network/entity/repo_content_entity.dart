import 'package:json_annotation/json_annotation.dart';

part 'repo_content_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class RepoContentEntity {
	String? type;
	String? encoding;
	int? size;
	String? name;
	String? path;
	String? content;
	String? sha;
	String? url;
	@JsonKey(name: "git_url")
	String? gitUrl;
	@JsonKey(name: "html_url")
	String? htmlUrl;
	@JsonKey(name: "download_url")
	String? downloadUrl;
	@JsonKey(name: "_links")
	RepoContentLinks? rLinks;

	RepoContentEntity(this.type, this.encoding, this.size, this.name, this.path, this.content, this.sha, this.url,
      this.gitUrl, this.htmlUrl, this.downloadUrl, this.rLinks);

  factory RepoContentEntity.fromJson(Map<String, dynamic> json) => _$RepoContentEntityFromJson(json);

	Map<String, dynamic> toJson() => _$RepoContentEntityToJson(this);

}

@JsonSerializable(explicitToJson: true)
class RepoContentLinks {
	String? git;
	String? self;
	String? html;

	RepoContentLinks(this.git, this.self, this.html);

  factory RepoContentLinks.fromJson(Map<String, dynamic> json) => _$RepoContentLinksFromJson(json);

	Map<String, dynamic> toJson() => _$RepoContentLinksToJson(this);

}
