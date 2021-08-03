import 'package:json_annotation/json_annotation.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'git_hub_api_entity.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable(explicitToJson: true)
class GitHubApiEntity {
	@JsonKey(name: "current_user_url")
	final String currentUserUrl;
	@JsonKey(name: "current_user_authorizations_html_url")
	final String currentUserAuthorizationsHtmlUrl;
	@JsonKey(name: "authorizations_url")
	final String authorizationsUrl;
	@JsonKey(name: "code_search_url")
	final String codeSearchUrl;
	@JsonKey(name: "commit_search_url")
	final String commitSearchUrl;
	@JsonKey(name: "emails_url")
	final String emailsUrl;
	@JsonKey(name: "emojis_url")
	final String emojisUrl;
	@JsonKey(name: "events_url")
	final String eventsUrl;
	@JsonKey(name: "feeds_url")
	final String feedsUrl;
	@JsonKey(name: "followers_url")
	final String followersUrl;
	@JsonKey(name: "following_url")
	final String followingUrl;
	@JsonKey(name: "gists_url")
	final String gistsUrl;
	@JsonKey(name: "hub_url")
	final String hubUrl;
	@JsonKey(name: "issue_search_url")
	final String issueSearchUrl;
	@JsonKey(name: "issues_url")
	final String issuesUrl;
	@JsonKey(name: "keys_url")
	final String keysUrl;
	@JsonKey(name: "label_search_url")
	final String labelSearchUrl;
	@JsonKey(name: "notifications_url")
	final String notificationsUrl;
	@JsonKey(name: "organization_url")
	final String organizationUrl;
	@JsonKey(name: "organization_repositories_url")
	final String organizationRepositoriesUrl;
	@JsonKey(name: "organization_teams_url")
	final String organizationTeamsUrl;
	@JsonKey(name: "public_gists_url")
	final String publicGistsUrl;
	@JsonKey(name: "rate_limit_url")
	final String rateLimitUrl;
	@JsonKey(name: "repository_url")
	final String repositoryUrl;
	@JsonKey(name: "repository_search_url")
	final String repositorySearchUrl;
	@JsonKey(name: "current_user_repositories_url")
	final String currentUserRepositoriesUrl;
	@JsonKey(name: "starred_url")
	final String starredUrl;
	@JsonKey(name: "starred_gists_url")
	final String starredGistsUrl;
	@JsonKey(name: "user_url")
	final String userUrl;
	@JsonKey(name: "user_organizations_url")
	final String userOrganizationsUrl;
	@JsonKey(name: "user_repositories_url")
	final String userRepositoriesUrl;
	@JsonKey(name: "user_search_url")
	final String userSearchUrl;

	GitHubApiEntity(
      this.currentUserUrl,
      this.currentUserAuthorizationsHtmlUrl,
      this.authorizationsUrl,
      this.codeSearchUrl,
      this.commitSearchUrl,
      this.emailsUrl,
      this.emojisUrl,
      this.eventsUrl,
      this.feedsUrl,
      this.followersUrl,
      this.followingUrl,
      this.gistsUrl,
      this.hubUrl,
      this.issueSearchUrl,
      this.issuesUrl,
      this.keysUrl,
      this.labelSearchUrl,
      this.notificationsUrl,
      this.organizationUrl,
      this.organizationRepositoriesUrl,
      this.organizationTeamsUrl,
      this.publicGistsUrl,
      this.rateLimitUrl,
      this.repositoryUrl,
      this.repositorySearchUrl,
      this.currentUserRepositoriesUrl,
      this.starredUrl,
      this.starredGistsUrl,
      this.userUrl,
      this.userOrganizationsUrl,
      this.userRepositoriesUrl,
      this.userSearchUrl);

	factory GitHubApiEntity.fromJson(Map<String, dynamic> json) => _$GitHubApiEntityFromJson(json);
	Map<String, dynamic> toJson() => _$GitHubApiEntityToJson(this);

}
