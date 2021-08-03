import 'package:githao_v2/entities/github_api_entity.dart';

githubApiEntityFromJson(GithubApiEntity data, Map<String, dynamic> json) {
	if (json['current_user_url'] != null) {
		data.currentUserUrl = json['current_user_url'].toString();
	}
	if (json['current_user_authorizations_html_url'] != null) {
		data.currentUserAuthorizationsHtmlUrl = json['current_user_authorizations_html_url'].toString();
	}
	if (json['authorizations_url'] != null) {
		data.authorizationsUrl = json['authorizations_url'].toString();
	}
	if (json['code_search_url'] != null) {
		data.codeSearchUrl = json['code_search_url'].toString();
	}
	if (json['commit_search_url'] != null) {
		data.commitSearchUrl = json['commit_search_url'].toString();
	}
	if (json['emails_url'] != null) {
		data.emailsUrl = json['emails_url'].toString();
	}
	if (json['emojis_url'] != null) {
		data.emojisUrl = json['emojis_url'].toString();
	}
	if (json['events_url'] != null) {
		data.eventsUrl = json['events_url'].toString();
	}
	if (json['feeds_url'] != null) {
		data.feedsUrl = json['feeds_url'].toString();
	}
	if (json['followers_url'] != null) {
		data.followersUrl = json['followers_url'].toString();
	}
	if (json['following_url'] != null) {
		data.followingUrl = json['following_url'].toString();
	}
	if (json['gists_url'] != null) {
		data.gistsUrl = json['gists_url'].toString();
	}
	if (json['hub_url'] != null) {
		data.hubUrl = json['hub_url'].toString();
	}
	if (json['issue_search_url'] != null) {
		data.issueSearchUrl = json['issue_search_url'].toString();
	}
	if (json['issues_url'] != null) {
		data.issuesUrl = json['issues_url'].toString();
	}
	if (json['keys_url'] != null) {
		data.keysUrl = json['keys_url'].toString();
	}
	if (json['label_search_url'] != null) {
		data.labelSearchUrl = json['label_search_url'].toString();
	}
	if (json['notifications_url'] != null) {
		data.notificationsUrl = json['notifications_url'].toString();
	}
	if (json['organization_url'] != null) {
		data.organizationUrl = json['organization_url'].toString();
	}
	if (json['organization_repositories_url'] != null) {
		data.organizationRepositoriesUrl = json['organization_repositories_url'].toString();
	}
	if (json['organization_teams_url'] != null) {
		data.organizationTeamsUrl = json['organization_teams_url'].toString();
	}
	if (json['public_gists_url'] != null) {
		data.publicGistsUrl = json['public_gists_url'].toString();
	}
	if (json['rate_limit_url'] != null) {
		data.rateLimitUrl = json['rate_limit_url'].toString();
	}
	if (json['repository_url'] != null) {
		data.repositoryUrl = json['repository_url'].toString();
	}
	if (json['repository_search_url'] != null) {
		data.repositorySearchUrl = json['repository_search_url'].toString();
	}
	if (json['current_user_repositories_url'] != null) {
		data.currentUserRepositoriesUrl = json['current_user_repositories_url'].toString();
	}
	if (json['starred_url'] != null) {
		data.starredUrl = json['starred_url'].toString();
	}
	if (json['starred_gists_url'] != null) {
		data.starredGistsUrl = json['starred_gists_url'].toString();
	}
	if (json['user_url'] != null) {
		data.userUrl = json['user_url'].toString();
	}
	if (json['user_organizations_url'] != null) {
		data.userOrganizationsUrl = json['user_organizations_url'].toString();
	}
	if (json['user_repositories_url'] != null) {
		data.userRepositoriesUrl = json['user_repositories_url'].toString();
	}
	if (json['user_search_url'] != null) {
		data.userSearchUrl = json['user_search_url'].toString();
	}
	return data;
}

Map<String, dynamic> githubApiEntityToJson(GithubApiEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['current_user_url'] = entity.currentUserUrl;
	data['current_user_authorizations_html_url'] = entity.currentUserAuthorizationsHtmlUrl;
	data['authorizations_url'] = entity.authorizationsUrl;
	data['code_search_url'] = entity.codeSearchUrl;
	data['commit_search_url'] = entity.commitSearchUrl;
	data['emails_url'] = entity.emailsUrl;
	data['emojis_url'] = entity.emojisUrl;
	data['events_url'] = entity.eventsUrl;
	data['feeds_url'] = entity.feedsUrl;
	data['followers_url'] = entity.followersUrl;
	data['following_url'] = entity.followingUrl;
	data['gists_url'] = entity.gistsUrl;
	data['hub_url'] = entity.hubUrl;
	data['issue_search_url'] = entity.issueSearchUrl;
	data['issues_url'] = entity.issuesUrl;
	data['keys_url'] = entity.keysUrl;
	data['label_search_url'] = entity.labelSearchUrl;
	data['notifications_url'] = entity.notificationsUrl;
	data['organization_url'] = entity.organizationUrl;
	data['organization_repositories_url'] = entity.organizationRepositoriesUrl;
	data['organization_teams_url'] = entity.organizationTeamsUrl;
	data['public_gists_url'] = entity.publicGistsUrl;
	data['rate_limit_url'] = entity.rateLimitUrl;
	data['repository_url'] = entity.repositoryUrl;
	data['repository_search_url'] = entity.repositorySearchUrl;
	data['current_user_repositories_url'] = entity.currentUserRepositoriesUrl;
	data['starred_url'] = entity.starredUrl;
	data['starred_gists_url'] = entity.starredGistsUrl;
	data['user_url'] = entity.userUrl;
	data['user_organizations_url'] = entity.userOrganizationsUrl;
	data['user_repositories_url'] = entity.userRepositoriesUrl;
	data['user_search_url'] = entity.userSearchUrl;
	return data;
}