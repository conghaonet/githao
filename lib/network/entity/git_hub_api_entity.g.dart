// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_hub_api_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitHubApiEntity _$GitHubApiEntityFromJson(Map<String, dynamic> json) {
  return GitHubApiEntity(
    json['current_user_url'] as String,
    json['current_user_authorizations_html_url'] as String,
    json['authorizations_url'] as String,
    json['code_search_url'] as String,
    json['commit_search_url'] as String,
    json['emails_url'] as String,
    json['emojis_url'] as String,
    json['events_url'] as String,
    json['feeds_url'] as String,
    json['followers_url'] as String,
    json['following_url'] as String,
    json['gists_url'] as String,
    json['hub_url'] as String,
    json['issue_search_url'] as String,
    json['issues_url'] as String,
    json['keys_url'] as String,
    json['label_search_url'] as String,
    json['notifications_url'] as String,
    json['organization_url'] as String,
    json['organization_repositories_url'] as String,
    json['organization_teams_url'] as String,
    json['public_gists_url'] as String,
    json['rate_limit_url'] as String,
    json['repository_url'] as String,
    json['repository_search_url'] as String,
    json['current_user_repositories_url'] as String,
    json['starred_url'] as String,
    json['starred_gists_url'] as String,
    json['user_url'] as String,
    json['user_organizations_url'] as String,
    json['user_repositories_url'] as String,
    json['user_search_url'] as String,
  );
}

Map<String, dynamic> _$GitHubApiEntityToJson(GitHubApiEntity instance) =>
    <String, dynamic>{
      'current_user_url': instance.currentUserUrl,
      'current_user_authorizations_html_url':
          instance.currentUserAuthorizationsHtmlUrl,
      'authorizations_url': instance.authorizationsUrl,
      'code_search_url': instance.codeSearchUrl,
      'commit_search_url': instance.commitSearchUrl,
      'emails_url': instance.emailsUrl,
      'emojis_url': instance.emojisUrl,
      'events_url': instance.eventsUrl,
      'feeds_url': instance.feedsUrl,
      'followers_url': instance.followersUrl,
      'following_url': instance.followingUrl,
      'gists_url': instance.gistsUrl,
      'hub_url': instance.hubUrl,
      'issue_search_url': instance.issueSearchUrl,
      'issues_url': instance.issuesUrl,
      'keys_url': instance.keysUrl,
      'label_search_url': instance.labelSearchUrl,
      'notifications_url': instance.notificationsUrl,
      'organization_url': instance.organizationUrl,
      'organization_repositories_url': instance.organizationRepositoriesUrl,
      'organization_teams_url': instance.organizationTeamsUrl,
      'public_gists_url': instance.publicGistsUrl,
      'rate_limit_url': instance.rateLimitUrl,
      'repository_url': instance.repositoryUrl,
      'repository_search_url': instance.repositorySearchUrl,
      'current_user_repositories_url': instance.currentUserRepositoriesUrl,
      'starred_url': instance.starredUrl,
      'starred_gists_url': instance.starredGistsUrl,
      'user_url': instance.userUrl,
      'user_organizations_url': instance.userOrganizationsUrl,
      'user_repositories_url': instance.userRepositoriesUrl,
      'user_search_url': instance.userSearchUrl,
    };
