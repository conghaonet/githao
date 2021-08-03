import 'package:githao_v2/generated/json/base/json_convert_content.dart';
import 'package:githao_v2/generated/json/base/json_field.dart';

class GithubApiEntity with JsonConvert<GithubApiEntity> {
	@JSONField(name: "current_user_url")
	late String currentUserUrl;
	@JSONField(name: "current_user_authorizations_html_url")
	late String currentUserAuthorizationsHtmlUrl;
	@JSONField(name: "authorizations_url")
	late String authorizationsUrl;
	@JSONField(name: "code_search_url")
	late String codeSearchUrl;
	@JSONField(name: "commit_search_url")
	late String commitSearchUrl;
	@JSONField(name: "emails_url")
	late String emailsUrl;
	@JSONField(name: "emojis_url")
	late String emojisUrl;
	@JSONField(name: "events_url")
	late String eventsUrl;
	@JSONField(name: "feeds_url")
	late String feedsUrl;
	@JSONField(name: "followers_url")
	late String followersUrl;
	@JSONField(name: "following_url")
	late String followingUrl;
	@JSONField(name: "gists_url")
	late String gistsUrl;
	@JSONField(name: "hub_url")
	late String hubUrl;
	@JSONField(name: "issue_search_url")
	late String issueSearchUrl;
	@JSONField(name: "issues_url")
	late String issuesUrl;
	@JSONField(name: "keys_url")
	late String keysUrl;
	@JSONField(name: "label_search_url")
	late String labelSearchUrl;
	@JSONField(name: "notifications_url")
	late String notificationsUrl;
	@JSONField(name: "organization_url")
	late String organizationUrl;
	@JSONField(name: "organization_repositories_url")
	late String organizationRepositoriesUrl;
	@JSONField(name: "organization_teams_url")
	late String organizationTeamsUrl;
	@JSONField(name: "public_gists_url")
	late String publicGistsUrl;
	@JSONField(name: "rate_limit_url")
	late String rateLimitUrl;
	@JSONField(name: "repository_url")
	late String repositoryUrl;
	@JSONField(name: "repository_search_url")
	late String repositorySearchUrl;
	@JSONField(name: "current_user_repositories_url")
	late String currentUserRepositoriesUrl;
	@JSONField(name: "starred_url")
	late String starredUrl;
	@JSONField(name: "starred_gists_url")
	late String starredGistsUrl;
	@JSONField(name: "user_url")
	late String userUrl;
	@JSONField(name: "user_organizations_url")
	late String userOrganizationsUrl;
	@JSONField(name: "user_repositories_url")
	late String userRepositoriesUrl;
	@JSONField(name: "user_search_url")
	late String userSearchUrl;
}
