import 'package:json_annotation/json_annotation.dart';

part 'repo_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class RepoEntity {
	int? id;
	@JsonKey(name: "node_id")
	String? nodeId;
	String? name;
	@JsonKey(name: "full_name")
	String? fullName;
	RepoOwner? owner;
	bool? private;
	@JsonKey(name: "html_url")
	String? htmlUrl;
	String? description;
	bool? fork;
	String? url;
	@JsonKey(name: "archive_url")
	String? archiveUrl;
	@JsonKey(name: "assignees_url")
	String? assigneesUrl;
	@JsonKey(name: "blobs_url")
	String? blobsUrl;
	@JsonKey(name: "branches_url")
	String? branchesUrl;
	@JsonKey(name: "collaborators_url")
	String? collaboratorsUrl;
	@JsonKey(name: "comments_url")
	String? commentsUrl;
	@JsonKey(name: "commits_url")
	String? commitsUrl;
	@JsonKey(name: "compare_url")
	String? compareUrl;
	@JsonKey(name: "contents_url")
	String? contentsUrl;
	@JsonKey(name: "contributors_url")
	String? contributorsUrl;
	@JsonKey(name: "deployments_url")
	String? deploymentsUrl;
	@JsonKey(name: "downloads_url")
	String? downloadsUrl;
	@JsonKey(name: "events_url")
	String? eventsUrl;
	@JsonKey(name: "forks_url")
	String? forksUrl;
	@JsonKey(name: "git_commits_url")
	String? gitCommitsUrl;
	@JsonKey(name: "git_refs_url")
	String? gitRefsUrl;
	@JsonKey(name: "git_tags_url")
	String? gitTagsUrl;
	@JsonKey(name: "git_url")
	String? gitUrl;
	@JsonKey(name: "issue_comment_url")
	String? issueCommentUrl;
	@JsonKey(name: "issue_events_url")
	String? issueEventsUrl;
	@JsonKey(name: "issues_url")
	String? issuesUrl;
	@JsonKey(name: "keys_url")
	String? keysUrl;
	@JsonKey(name: "labels_url")
	String? labelsUrl;
	@JsonKey(name: "languages_url")
	String? languagesUrl;
	@JsonKey(name: "merges_url")
	String? mergesUrl;
	@JsonKey(name: "milestones_url")
	String? milestonesUrl;
	@JsonKey(name: "notifications_url")
	String? notificationsUrl;
	@JsonKey(name: "pulls_url")
	String? pullsUrl;
	@JsonKey(name: "releases_url")
	String? releasesUrl;
	@JsonKey(name: "ssh_url")
	String? sshUrl;
	@JsonKey(name: "stargazers_url")
	String? stargazersUrl;
	@JsonKey(name: "statuses_url")
	String? statusesUrl;
	@JsonKey(name: "subscribers_url")
	String? subscribersUrl;
	@JsonKey(name: "subscription_url")
	String? subscriptionUrl;
	@JsonKey(name: "tags_url")
	String? tagsUrl;
	@JsonKey(name: "teams_url")
	String? teamsUrl;
	@JsonKey(name: "trees_url")
	String? treesUrl;
	@JsonKey(name: "clone_url")
	String? cloneUrl;
	@JsonKey(name: "mirror_url")
	String? mirrorUrl;
	@JsonKey(name: "hooks_url")
	String? hooksUrl;
	@JsonKey(name: "svn_url")
	String? svnUrl;
	String? homepage;
	String? language;
	@JsonKey(name: "forks_count")
	int? forksCount;
	int? forks;
	@JsonKey(name: "stargazers_count")
	int? stargazersCount;
	@JsonKey(name: "watchers_count")
	int? watchersCount;
	int? watchers;
	int? size;
	@JsonKey(name: "default_branch")
	String? defaultBranch;
	@JsonKey(name: "open_issues_count")
	int? openIssuesCount;
	@JsonKey(name: "open_issues")
	int? openIssues;
	@JsonKey(name: "is_template")
	bool? isTemplate;
	List<String>? topics;
	@JsonKey(name: "has_issues")
	bool? hasIssues;
	@JsonKey(name: "has_projects")
	bool? hasProjects;
	@JsonKey(name: "has_wiki")
	bool? hasWiki;
	@JsonKey(name: "has_pages")
	bool? hasPages;
	@JsonKey(name: "has_downloads")
	bool? hasDownloads;
	bool? archived;
	bool? disabled;
	String? visibility;
	@JsonKey(name: "pushed_at")
	String? pushedAt;
	@JsonKey(name: "created_at")
	String? createdAt;
	@JsonKey(name: "updated_at")
	String? updatedAt;
	RepoPermissions? permissions;
	@JsonKey(name: "allow_rebase_merge")
	bool? allowRebaseMerge;
	@JsonKey(name: "template_repository")
	RepoTemplateRepository? templateRepository;
	@JsonKey(name: "temp_clone_token")
	String? tempCloneToken;
	@JsonKey(name: "allow_squash_merge")
	bool? allowSquashMerge;
	@JsonKey(name: "allow_auto_merge")
	bool? allowAutoMerge;
	@JsonKey(name: "delete_branch_on_merge")
	bool? deleteBranchOnMerge;
	@JsonKey(name: "allow_merge_commit")
	bool? allowMergeCommit;
	@JsonKey(name: "subscribers_count")
	int? subscribersCount;
	@JsonKey(name: "network_count")
	int? networkCount;
	RepoLicense? license;
	RepoOrganization? organization;
	RepoParent? parent;
	RepoSource? source;

	RepoEntity(
      this.id,
      this.nodeId,
      this.name,
      this.fullName,
      this.owner,
      this.private,
      this.htmlUrl,
      this.description,
      this.fork,
      this.url,
      this.archiveUrl,
      this.assigneesUrl,
      this.blobsUrl,
      this.branchesUrl,
      this.collaboratorsUrl,
      this.commentsUrl,
      this.commitsUrl,
      this.compareUrl,
      this.contentsUrl,
      this.contributorsUrl,
      this.deploymentsUrl,
      this.downloadsUrl,
      this.eventsUrl,
      this.forksUrl,
      this.gitCommitsUrl,
      this.gitRefsUrl,
      this.gitTagsUrl,
      this.gitUrl,
      this.issueCommentUrl,
      this.issueEventsUrl,
      this.issuesUrl,
      this.keysUrl,
      this.labelsUrl,
      this.languagesUrl,
      this.mergesUrl,
      this.milestonesUrl,
      this.notificationsUrl,
      this.pullsUrl,
      this.releasesUrl,
      this.sshUrl,
      this.stargazersUrl,
      this.statusesUrl,
      this.subscribersUrl,
      this.subscriptionUrl,
      this.tagsUrl,
      this.teamsUrl,
      this.treesUrl,
      this.cloneUrl,
      this.mirrorUrl,
      this.hooksUrl,
      this.svnUrl,
      this.homepage,
      this.language,
      this.forksCount,
      this.forks,
      this.stargazersCount,
      this.watchersCount,
      this.watchers,
      this.size,
      this.defaultBranch,
      this.openIssuesCount,
      this.openIssues,
      this.isTemplate,
      this.topics,
      this.hasIssues,
      this.hasProjects,
      this.hasWiki,
      this.hasPages,
      this.hasDownloads,
      this.archived,
      this.disabled,
      this.visibility,
      this.pushedAt,
      this.createdAt,
      this.updatedAt,
      this.permissions,
      this.allowRebaseMerge,
      this.templateRepository,
      this.tempCloneToken,
      this.allowSquashMerge,
      this.allowAutoMerge,
      this.deleteBranchOnMerge,
      this.allowMergeCommit,
      this.subscribersCount,
      this.networkCount,
      this.license,
      this.organization,
      this.parent,
      this.source);

  factory RepoEntity.fromJson(Map<String, dynamic> json) => _$RepoEntityFromJson(json);
	Map<String, dynamic> toJson() => _$RepoEntityToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RepoOwner {
	String? login;
	int? id;
	@JsonKey(name: "node_id")
	String? nodeId;
	@JsonKey(name: "avatar_url")
	String? avatarUrl;
	@JsonKey(name: "gravatar_id")
	String? gravatarId;
	String? url;
	@JsonKey(name: "html_url")
	String? htmlUrl;
	@JsonKey(name: "followers_url")
	String? followersUrl;
	@JsonKey(name: "following_url")
	String? followingUrl;
	@JsonKey(name: "gists_url")
	String? gistsUrl;
	@JsonKey(name: "starred_url")
	String? starredUrl;
	@JsonKey(name: "subscriptions_url")
	String? subscriptionsUrl;
	@JsonKey(name: "organizations_url")
	String? organizationsUrl;
	@JsonKey(name: "repos_url")
	String? reposUrl;
	@JsonKey(name: "events_url")
	String? eventsUrl;
	@JsonKey(name: "received_events_url")
	String? receivedEventsUrl;
	String? type;
	@JsonKey(name: "site_admin")
	bool? siteAdmin;

	RepoOwner(
      this.login,
      this.id,
      this.nodeId,
      this.avatarUrl,
      this.gravatarId,
      this.url,
      this.htmlUrl,
      this.followersUrl,
      this.followingUrl,
      this.gistsUrl,
      this.starredUrl,
      this.subscriptionsUrl,
      this.organizationsUrl,
      this.reposUrl,
      this.eventsUrl,
      this.receivedEventsUrl,
      this.type,
      this.siteAdmin);

  factory RepoOwner.fromJson(Map<String, dynamic> json) => _$RepoOwnerFromJson(json);
	Map<String, dynamic> toJson() => _$RepoOwnerToJson(this);

}

@JsonSerializable(explicitToJson: true)
class RepoPermissions {
	bool? pull;
	bool? push;
	bool? admin;

	RepoPermissions(this.pull, this.push, this.admin);

  factory RepoPermissions.fromJson(Map<String, dynamic> json) => _$RepoPermissionsFromJson(json);
	Map<String, dynamic> toJson() => _$RepoPermissionsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RepoTemplateRepository {
	int? id;
	@JsonKey(name: "node_id")
	String? nodeId;
	String? name;
	@JsonKey(name: "full_name")
	String? fullName;
	RepoTemplateRepositoryOwner? owner;
	bool? private;
	@JsonKey(name: "html_url")
	String? htmlUrl;
	String? description;
	bool? fork;
	String? url;
	@JsonKey(name: "archive_url")
	String? archiveUrl;
	@JsonKey(name: "assignees_url")
	String? assigneesUrl;
	@JsonKey(name: "blobs_url")
	String? blobsUrl;
	@JsonKey(name: "branches_url")
	String? branchesUrl;
	@JsonKey(name: "collaborators_url")
	String? collaboratorsUrl;
	@JsonKey(name: "comments_url")
	String? commentsUrl;
	@JsonKey(name: "commits_url")
	String? commitsUrl;
	@JsonKey(name: "compare_url")
	String? compareUrl;
	@JsonKey(name: "contents_url")
	String? contentsUrl;
	@JsonKey(name: "contributors_url")
	String? contributorsUrl;
	@JsonKey(name: "deployments_url")
	String? deploymentsUrl;
	@JsonKey(name: "downloads_url")
	String? downloadsUrl;
	@JsonKey(name: "events_url")
	String? eventsUrl;
	@JsonKey(name: "forks_url")
	String? forksUrl;
	@JsonKey(name: "git_commits_url")
	String? gitCommitsUrl;
	@JsonKey(name: "git_refs_url")
	String? gitRefsUrl;
	@JsonKey(name: "git_tags_url")
	String? gitTagsUrl;
	@JsonKey(name: "git_url")
	String? gitUrl;
	@JsonKey(name: "issue_comment_url")
	String? issueCommentUrl;
	@JsonKey(name: "issue_events_url")
	String? issueEventsUrl;
	@JsonKey(name: "issues_url")
	String? issuesUrl;
	@JsonKey(name: "keys_url")
	String? keysUrl;
	@JsonKey(name: "labels_url")
	String? labelsUrl;
	@JsonKey(name: "languages_url")
	String? languagesUrl;
	@JsonKey(name: "merges_url")
	String? mergesUrl;
	@JsonKey(name: "milestones_url")
	String? milestonesUrl;
	@JsonKey(name: "notifications_url")
	String? notificationsUrl;
	@JsonKey(name: "pulls_url")
	String? pullsUrl;
	@JsonKey(name: "releases_url")
	String? releasesUrl;
	@JsonKey(name: "ssh_url")
	String? sshUrl;
	@JsonKey(name: "stargazers_url")
	String? stargazersUrl;
	@JsonKey(name: "statuses_url")
	String? statusesUrl;
	@JsonKey(name: "subscribers_url")
	String? subscribersUrl;
	@JsonKey(name: "subscription_url")
	String? subscriptionUrl;
	@JsonKey(name: "tags_url")
	String? tagsUrl;
	@JsonKey(name: "teams_url")
	String? teamsUrl;
	@JsonKey(name: "trees_url")
	String? treesUrl;
	@JsonKey(name: "clone_url")
	String? cloneUrl;
	@JsonKey(name: "mirror_url")
	String? mirrorUrl;
	@JsonKey(name: "hooks_url")
	String? hooksUrl;
	@JsonKey(name: "svn_url")
	String? svnUrl;
	String? homepage;
	String? language;
	int? forks;
	@JsonKey(name: "forks_count")
	int? forksCount;
	@JsonKey(name: "stargazers_count")
	int? stargazersCount;
	@JsonKey(name: "watchers_count")
	int? watchersCount;
	int? watchers;
	int? size;
	@JsonKey(name: "default_branch")
	String? defaultBranch;
	@JsonKey(name: "open_issues")
	int? openIssues;
	@JsonKey(name: "open_issues_count")
	int? openIssuesCount;
	@JsonKey(name: "is_template")
	bool? isTemplate;
	RepoTemplateRepositoryLicense? license;
	List<String>? topics;
	@JsonKey(name: "has_issues")
	bool? hasIssues;
	@JsonKey(name: "has_projects")
	bool? hasProjects;
	@JsonKey(name: "has_wiki")
	bool? hasWiki;
	@JsonKey(name: "has_pages")
	bool? hasPages;
	@JsonKey(name: "has_downloads")
	bool? hasDownloads;
	bool? archived;
	bool? disabled;
	String? visibility;
	@JsonKey(name: "pushed_at")
	String? pushedAt;
	@JsonKey(name: "created_at")
	String? createdAt;
	@JsonKey(name: "updated_at")
	String? updatedAt;
	RepoTemplateRepositoryPermissions? permissions;
	@JsonKey(name: "allow_rebase_merge")
	bool? allowRebaseMerge;
	@JsonKey(name: "temp_clone_token")
	String? tempCloneToken;
	@JsonKey(name: "allow_squash_merge")
	bool? allowSquashMerge;
	@JsonKey(name: "allow_auto_merge")
	bool? allowAutoMerge;
	@JsonKey(name: "delete_branch_on_merge")
	bool? deleteBranchOnMerge;
	@JsonKey(name: "allow_merge_commit")
	bool? allowMergeCommit;
	@JsonKey(name: "subscribers_count")
	int? subscribersCount;
	@JsonKey(name: "network_count")
	int? networkCount;

	RepoTemplateRepository(
      this.id,
      this.nodeId,
      this.name,
      this.fullName,
      this.owner,
      this.private,
      this.htmlUrl,
      this.description,
      this.fork,
      this.url,
      this.archiveUrl,
      this.assigneesUrl,
      this.blobsUrl,
      this.branchesUrl,
      this.collaboratorsUrl,
      this.commentsUrl,
      this.commitsUrl,
      this.compareUrl,
      this.contentsUrl,
      this.contributorsUrl,
      this.deploymentsUrl,
      this.downloadsUrl,
      this.eventsUrl,
      this.forksUrl,
      this.gitCommitsUrl,
      this.gitRefsUrl,
      this.gitTagsUrl,
      this.gitUrl,
      this.issueCommentUrl,
      this.issueEventsUrl,
      this.issuesUrl,
      this.keysUrl,
      this.labelsUrl,
      this.languagesUrl,
      this.mergesUrl,
      this.milestonesUrl,
      this.notificationsUrl,
      this.pullsUrl,
      this.releasesUrl,
      this.sshUrl,
      this.stargazersUrl,
      this.statusesUrl,
      this.subscribersUrl,
      this.subscriptionUrl,
      this.tagsUrl,
      this.teamsUrl,
      this.treesUrl,
      this.cloneUrl,
      this.mirrorUrl,
      this.hooksUrl,
      this.svnUrl,
      this.homepage,
      this.language,
      this.forks,
      this.forksCount,
      this.stargazersCount,
      this.watchersCount,
      this.watchers,
      this.size,
      this.defaultBranch,
      this.openIssues,
      this.openIssuesCount,
      this.isTemplate,
      this.license,
      this.topics,
      this.hasIssues,
      this.hasProjects,
      this.hasWiki,
      this.hasPages,
      this.hasDownloads,
      this.archived,
      this.disabled,
      this.visibility,
      this.pushedAt,
      this.createdAt,
      this.updatedAt,
      this.permissions,
      this.allowRebaseMerge,
      this.tempCloneToken,
      this.allowSquashMerge,
      this.allowAutoMerge,
      this.deleteBranchOnMerge,
      this.allowMergeCommit,
      this.subscribersCount,
      this.networkCount);

  factory RepoTemplateRepository.fromJson(Map<String, dynamic> json) => _$RepoTemplateRepositoryFromJson(json);
	Map<String, dynamic> toJson() => _$RepoTemplateRepositoryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RepoTemplateRepositoryOwner {
	String? login;
	int? id;
	@JsonKey(name: "node_id")
	String? nodeId;
	@JsonKey(name: "avatar_url")
	String? avatarUrl;
	@JsonKey(name: "gravatar_id")
	String? gravatarId;
	String? url;
	@JsonKey(name: "html_url")
	String? htmlUrl;
	@JsonKey(name: "followers_url")
	String? followersUrl;
	@JsonKey(name: "following_url")
	String? followingUrl;
	@JsonKey(name: "gists_url")
	String? gistsUrl;
	@JsonKey(name: "starred_url")
	String? starredUrl;
	@JsonKey(name: "subscriptions_url")
	String? subscriptionsUrl;
	@JsonKey(name: "organizations_url")
	String? organizationsUrl;
	@JsonKey(name: "repos_url")
	String? reposUrl;
	@JsonKey(name: "events_url")
	String? eventsUrl;
	@JsonKey(name: "received_events_url")
	String? receivedEventsUrl;
	String? type;
	@JsonKey(name: "site_admin")
	bool? siteAdmin;

	RepoTemplateRepositoryOwner(
      this.login,
      this.id,
      this.nodeId,
      this.avatarUrl,
      this.gravatarId,
      this.url,
      this.htmlUrl,
      this.followersUrl,
      this.followingUrl,
      this.gistsUrl,
      this.starredUrl,
      this.subscriptionsUrl,
      this.organizationsUrl,
      this.reposUrl,
      this.eventsUrl,
      this.receivedEventsUrl,
      this.type,
      this.siteAdmin);

  factory RepoTemplateRepositoryOwner.fromJson(Map<String, dynamic> json) => _$RepoTemplateRepositoryOwnerFromJson(json);
	Map<String, dynamic> toJson() => _$RepoTemplateRepositoryOwnerToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RepoTemplateRepositoryLicense {
	String? key;
	String? name;
	String? url;
	@JsonKey(name: "spdx_id")
	String? spdxId;
	@JsonKey(name: "node_id")
	String? nodeId;
	@JsonKey(name: "html_url")
	String? htmlUrl;

	RepoTemplateRepositoryLicense(this.key, this.name, this.url, this.spdxId, this.nodeId, this.htmlUrl);

  factory RepoTemplateRepositoryLicense.fromJson(Map<String, dynamic> json) => _$RepoTemplateRepositoryLicenseFromJson(json);
	Map<String, dynamic> toJson() => _$RepoTemplateRepositoryLicenseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RepoTemplateRepositoryPermissions {
	bool? admin;
	bool? push;
	bool? pull;

	RepoTemplateRepositoryPermissions(this.admin, this.push, this.pull);

  factory RepoTemplateRepositoryPermissions.fromJson(Map<String, dynamic> json) => _$RepoTemplateRepositoryPermissionsFromJson(json);
	Map<String, dynamic> toJson() => _$RepoTemplateRepositoryPermissionsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RepoLicense {
	String? key;
	String? name;
	@JsonKey(name: "spdx_id")
	String? spdxId;
	String? url;
	@JsonKey(name: "node_id")
	String? nodeId;

	RepoLicense(this.key, this.name, this.spdxId, this.url, this.nodeId);

  factory RepoLicense.fromJson(Map<String, dynamic> json) => _$RepoLicenseFromJson(json);
	Map<String, dynamic> toJson() => _$RepoLicenseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RepoOrganization {
	String? login;
	int? id;
	@JsonKey(name: "node_id")
	String? nodeId;
	@JsonKey(name: "avatar_url")
	String? avatarUrl;
	@JsonKey(name: "gravatar_id")
	String? gravatarId;
	String? url;
	@JsonKey(name: "html_url")
	String? htmlUrl;
	@JsonKey(name: "followers_url")
	String? followersUrl;
	@JsonKey(name: "following_url")
	String? followingUrl;
	@JsonKey(name: "gists_url")
	String? gistsUrl;
	@JsonKey(name: "starred_url")
	String? starredUrl;
	@JsonKey(name: "subscriptions_url")
	String? subscriptionsUrl;
	@JsonKey(name: "organizations_url")
	String? organizationsUrl;
	@JsonKey(name: "repos_url")
	String? reposUrl;
	@JsonKey(name: "events_url")
	String? eventsUrl;
	@JsonKey(name: "received_events_url")
	String? receivedEventsUrl;
	String? type;
	@JsonKey(name: "site_admin")
	bool? siteAdmin;

	RepoOrganization(
      this.login,
      this.id,
      this.nodeId,
      this.avatarUrl,
      this.gravatarId,
      this.url,
      this.htmlUrl,
      this.followersUrl,
      this.followingUrl,
      this.gistsUrl,
      this.starredUrl,
      this.subscriptionsUrl,
      this.organizationsUrl,
      this.reposUrl,
      this.eventsUrl,
      this.receivedEventsUrl,
      this.type,
      this.siteAdmin);

  factory RepoOrganization.fromJson(Map<String, dynamic> json) => _$RepoOrganizationFromJson(json);
	Map<String, dynamic> toJson() => _$RepoOrganizationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RepoParent {
	int? id;
	@JsonKey(name: "node_id")
	String? nodeId;
	String? name;
	@JsonKey(name: "full_name")
	String? fullName;
	RepoParentOwner? owner;
	bool? private;
	@JsonKey(name: "html_url")
	String? htmlUrl;
	String? description;
	bool? fork;
	String? url;
	@JsonKey(name: "archive_url")
	String? archiveUrl;
	@JsonKey(name: "assignees_url")
	String? assigneesUrl;
	@JsonKey(name: "blobs_url")
	String? blobsUrl;
	@JsonKey(name: "branches_url")
	String? branchesUrl;
	@JsonKey(name: "collaborators_url")
	String? collaboratorsUrl;
	@JsonKey(name: "comments_url")
	String? commentsUrl;
	@JsonKey(name: "commits_url")
	String? commitsUrl;
	@JsonKey(name: "compare_url")
	String? compareUrl;
	@JsonKey(name: "contents_url")
	String? contentsUrl;
	@JsonKey(name: "contributors_url")
	String? contributorsUrl;
	@JsonKey(name: "deployments_url")
	String? deploymentsUrl;
	@JsonKey(name: "downloads_url")
	String? downloadsUrl;
	@JsonKey(name: "events_url")
	String? eventsUrl;
	@JsonKey(name: "forks_url")
	String? forksUrl;
	@JsonKey(name: "git_commits_url")
	String? gitCommitsUrl;
	@JsonKey(name: "git_refs_url")
	String? gitRefsUrl;
	@JsonKey(name: "git_tags_url")
	String? gitTagsUrl;
	@JsonKey(name: "git_url")
	String? gitUrl;
	@JsonKey(name: "issue_comment_url")
	String? issueCommentUrl;
	@JsonKey(name: "issue_events_url")
	String? issueEventsUrl;
	@JsonKey(name: "issues_url")
	String? issuesUrl;
	@JsonKey(name: "keys_url")
	String? keysUrl;
	@JsonKey(name: "labels_url")
	String? labelsUrl;
	@JsonKey(name: "languages_url")
	String? languagesUrl;
	@JsonKey(name: "merges_url")
	String? mergesUrl;
	@JsonKey(name: "milestones_url")
	String? milestonesUrl;
	@JsonKey(name: "notifications_url")
	String? notificationsUrl;
	@JsonKey(name: "pulls_url")
	String? pullsUrl;
	@JsonKey(name: "releases_url")
	String? releasesUrl;
	@JsonKey(name: "ssh_url")
	String? sshUrl;
	@JsonKey(name: "stargazers_url")
	String? stargazersUrl;
	@JsonKey(name: "statuses_url")
	String? statusesUrl;
	@JsonKey(name: "subscribers_url")
	String? subscribersUrl;
	@JsonKey(name: "subscription_url")
	String? subscriptionUrl;
	@JsonKey(name: "tags_url")
	String? tagsUrl;
	@JsonKey(name: "teams_url")
	String? teamsUrl;
	@JsonKey(name: "trees_url")
	String? treesUrl;
	@JsonKey(name: "clone_url")
	String? cloneUrl;
	@JsonKey(name: "mirror_url")
	String? mirrorUrl;
	@JsonKey(name: "hooks_url")
	String? hooksUrl;
	@JsonKey(name: "svn_url")
	String? svnUrl;
	String? homepage;
	String? language;
	@JsonKey(name: "forks_count")
	int? forksCount;
	@JsonKey(name: "stargazers_count")
	int? stargazersCount;
	@JsonKey(name: "watchers_count")
	int? watchersCount;
	int? size;
	@JsonKey(name: "default_branch")
	String? defaultBranch;
	@JsonKey(name: "open_issues_count")
	int? openIssuesCount;
	@JsonKey(name: "is_template")
	bool? isTemplate;
	List<String>? topics;
	@JsonKey(name: "has_issues")
	bool? hasIssues;
	@JsonKey(name: "has_projects")
	bool? hasProjects;
	@JsonKey(name: "has_wiki")
	bool? hasWiki;
	@JsonKey(name: "has_pages")
	bool? hasPages;
	@JsonKey(name: "has_downloads")
	bool? hasDownloads;
	bool? archived;
	bool? disabled;
	String? visibility;
	@JsonKey(name: "pushed_at")
	String? pushedAt;
	@JsonKey(name: "created_at")
	String? createdAt;
	@JsonKey(name: "updated_at")
	String? updatedAt;
	RepoParentPermissions? permissions;
	@JsonKey(name: "allow_rebase_merge")
	bool? allowRebaseMerge;
	@JsonKey(name: "temp_clone_token")
	String? tempCloneToken;
	@JsonKey(name: "allow_squash_merge")
	bool? allowSquashMerge;
	@JsonKey(name: "allow_auto_merge")
	bool? allowAutoMerge;
	@JsonKey(name: "delete_branch_on_merge")
	bool? deleteBranchOnMerge;
	@JsonKey(name: "allow_merge_commit")
	bool? allowMergeCommit;
	@JsonKey(name: "subscribers_count")
	int? subscribersCount;
	@JsonKey(name: "network_count")
	int? networkCount;
	RepoParentLicense? license;
	int? forks;
	@JsonKey(name: "open_issues")
	int? openIssues;
	int? watchers;

	RepoParent(
      this.id,
      this.nodeId,
      this.name,
      this.fullName,
      this.owner,
      this.private,
      this.htmlUrl,
      this.description,
      this.fork,
      this.url,
      this.archiveUrl,
      this.assigneesUrl,
      this.blobsUrl,
      this.branchesUrl,
      this.collaboratorsUrl,
      this.commentsUrl,
      this.commitsUrl,
      this.compareUrl,
      this.contentsUrl,
      this.contributorsUrl,
      this.deploymentsUrl,
      this.downloadsUrl,
      this.eventsUrl,
      this.forksUrl,
      this.gitCommitsUrl,
      this.gitRefsUrl,
      this.gitTagsUrl,
      this.gitUrl,
      this.issueCommentUrl,
      this.issueEventsUrl,
      this.issuesUrl,
      this.keysUrl,
      this.labelsUrl,
      this.languagesUrl,
      this.mergesUrl,
      this.milestonesUrl,
      this.notificationsUrl,
      this.pullsUrl,
      this.releasesUrl,
      this.sshUrl,
      this.stargazersUrl,
      this.statusesUrl,
      this.subscribersUrl,
      this.subscriptionUrl,
      this.tagsUrl,
      this.teamsUrl,
      this.treesUrl,
      this.cloneUrl,
      this.mirrorUrl,
      this.hooksUrl,
      this.svnUrl,
      this.homepage,
      this.language,
      this.forksCount,
      this.stargazersCount,
      this.watchersCount,
      this.size,
      this.defaultBranch,
      this.openIssuesCount,
      this.isTemplate,
      this.topics,
      this.hasIssues,
      this.hasProjects,
      this.hasWiki,
      this.hasPages,
      this.hasDownloads,
      this.archived,
      this.disabled,
      this.visibility,
      this.pushedAt,
      this.createdAt,
      this.updatedAt,
      this.permissions,
      this.allowRebaseMerge,
      this.tempCloneToken,
      this.allowSquashMerge,
      this.allowAutoMerge,
      this.deleteBranchOnMerge,
      this.allowMergeCommit,
      this.subscribersCount,
      this.networkCount,
      this.license,
      this.forks,
      this.openIssues,
      this.watchers);

  factory RepoParent.fromJson(Map<String, dynamic> json) => _$RepoParentFromJson(json);
	Map<String, dynamic> toJson() => _$RepoParentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RepoParentOwner {
	String? login;
	int? id;
	@JsonKey(name: "node_id")
	String? nodeId;
	@JsonKey(name: "avatar_url")
	String? avatarUrl;
	@JsonKey(name: "gravatar_id")
	String? gravatarId;
	String? url;
	@JsonKey(name: "html_url")
	String? htmlUrl;
	@JsonKey(name: "followers_url")
	String? followersUrl;
	@JsonKey(name: "following_url")
	String? followingUrl;
	@JsonKey(name: "gists_url")
	String? gistsUrl;
	@JsonKey(name: "starred_url")
	String? starredUrl;
	@JsonKey(name: "subscriptions_url")
	String? subscriptionsUrl;
	@JsonKey(name: "organizations_url")
	String? organizationsUrl;
	@JsonKey(name: "repos_url")
	String? reposUrl;
	@JsonKey(name: "events_url")
	String? eventsUrl;
	@JsonKey(name: "received_events_url")
	String? receivedEventsUrl;
	String? type;
	@JsonKey(name: "site_admin")
	bool? siteAdmin;

	RepoParentOwner(
      this.login,
      this.id,
      this.nodeId,
      this.avatarUrl,
      this.gravatarId,
      this.url,
      this.htmlUrl,
      this.followersUrl,
      this.followingUrl,
      this.gistsUrl,
      this.starredUrl,
      this.subscriptionsUrl,
      this.organizationsUrl,
      this.reposUrl,
      this.eventsUrl,
      this.receivedEventsUrl,
      this.type,
      this.siteAdmin);

  factory RepoParentOwner.fromJson(Map<String, dynamic> json) => _$RepoParentOwnerFromJson(json);
	Map<String, dynamic> toJson() => _$RepoParentOwnerToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RepoParentPermissions {
	bool? admin;
	bool? push;
	bool? pull;

	RepoParentPermissions(this.admin, this.push, this.pull);

  factory RepoParentPermissions.fromJson(Map<String, dynamic> json) => _$RepoParentPermissionsFromJson(json);
	Map<String, dynamic> toJson() => _$RepoParentPermissionsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RepoParentLicense {
	String? key;
	String? name;
	String? url;
	@JsonKey(name: "spdx_id")
	String? spdxId;
	@JsonKey(name: "node_id")
	String? nodeId;
	@JsonKey(name: "html_url")
	String? htmlUrl;

	RepoParentLicense(this.key, this.name, this.url, this.spdxId, this.nodeId, this.htmlUrl);

  factory RepoParentLicense.fromJson(Map<String, dynamic> json) => _$RepoParentLicenseFromJson(json);
	Map<String, dynamic> toJson() => _$RepoParentLicenseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RepoSource {
	int? id;
	@JsonKey(name: "node_id")
	String? nodeId;
	String? name;
	@JsonKey(name: "full_name")
	String? fullName;
	RepoSourceOwner? owner;
	bool? private;
	@JsonKey(name: "html_url")
	String? htmlUrl;
	String? description;
	bool? fork;
	String? url;
	@JsonKey(name: "archive_url")
	String? archiveUrl;
	@JsonKey(name: "assignees_url")
	String? assigneesUrl;
	@JsonKey(name: "blobs_url")
	String? blobsUrl;
	@JsonKey(name: "branches_url")
	String? branchesUrl;
	@JsonKey(name: "collaborators_url")
	String? collaboratorsUrl;
	@JsonKey(name: "comments_url")
	String? commentsUrl;
	@JsonKey(name: "commits_url")
	String? commitsUrl;
	@JsonKey(name: "compare_url")
	String? compareUrl;
	@JsonKey(name: "contents_url")
	String? contentsUrl;
	@JsonKey(name: "contributors_url")
	String? contributorsUrl;
	@JsonKey(name: "deployments_url")
	String? deploymentsUrl;
	@JsonKey(name: "downloads_url")
	String? downloadsUrl;
	@JsonKey(name: "events_url")
	String? eventsUrl;
	@JsonKey(name: "forks_url")
	String? forksUrl;
	@JsonKey(name: "git_commits_url")
	String? gitCommitsUrl;
	@JsonKey(name: "git_refs_url")
	String? gitRefsUrl;
	@JsonKey(name: "git_tags_url")
	String? gitTagsUrl;
	@JsonKey(name: "git_url")
	String? gitUrl;
	@JsonKey(name: "issue_comment_url")
	String? issueCommentUrl;
	@JsonKey(name: "issue_events_url")
	String? issueEventsUrl;
	@JsonKey(name: "issues_url")
	String? issuesUrl;
	@JsonKey(name: "keys_url")
	String? keysUrl;
	@JsonKey(name: "labels_url")
	String? labelsUrl;
	@JsonKey(name: "languages_url")
	String? languagesUrl;
	@JsonKey(name: "merges_url")
	String? mergesUrl;
	@JsonKey(name: "milestones_url")
	String? milestonesUrl;
	@JsonKey(name: "notifications_url")
	String? notificationsUrl;
	@JsonKey(name: "pulls_url")
	String? pullsUrl;
	@JsonKey(name: "releases_url")
	String? releasesUrl;
	@JsonKey(name: "ssh_url")
	String? sshUrl;
	@JsonKey(name: "stargazers_url")
	String? stargazersUrl;
	@JsonKey(name: "statuses_url")
	String? statusesUrl;
	@JsonKey(name: "subscribers_url")
	String? subscribersUrl;
	@JsonKey(name: "subscription_url")
	String? subscriptionUrl;
	@JsonKey(name: "tags_url")
	String? tagsUrl;
	@JsonKey(name: "teams_url")
	String? teamsUrl;
	@JsonKey(name: "trees_url")
	String? treesUrl;
	@JsonKey(name: "clone_url")
	String? cloneUrl;
	@JsonKey(name: "mirror_url")
	String? mirrorUrl;
	@JsonKey(name: "hooks_url")
	String? hooksUrl;
	@JsonKey(name: "svn_url")
	String? svnUrl;
	String? homepage;
	String? language;
	@JsonKey(name: "forks_count")
	int? forksCount;
	@JsonKey(name: "stargazers_count")
	int? stargazersCount;
	@JsonKey(name: "watchers_count")
	int? watchersCount;
	int? size;
	@JsonKey(name: "default_branch")
	String? defaultBranch;
	@JsonKey(name: "open_issues_count")
	int? openIssuesCount;
	@JsonKey(name: "is_template")
	bool? isTemplate;
	List<String>? topics;
	@JsonKey(name: "has_issues")
	bool? hasIssues;
	@JsonKey(name: "has_projects")
	bool? hasProjects;
	@JsonKey(name: "has_wiki")
	bool? hasWiki;
	@JsonKey(name: "has_pages")
	bool? hasPages;
	@JsonKey(name: "has_downloads")
	bool? hasDownloads;
	bool? archived;
	bool? disabled;
	String? visibility;
	@JsonKey(name: "pushed_at")
	String? pushedAt;
	@JsonKey(name: "created_at")
	String? createdAt;
	@JsonKey(name: "updated_at")
	String? updatedAt;
	RepoSourcePermissions? permissions;
	@JsonKey(name: "allow_rebase_merge")
	bool? allowRebaseMerge;
	@JsonKey(name: "temp_clone_token")
	String? tempCloneToken;
	@JsonKey(name: "allow_squash_merge")
	bool? allowSquashMerge;
	@JsonKey(name: "allow_auto_merge")
	bool? allowAutoMerge;
	@JsonKey(name: "delete_branch_on_merge")
	bool? deleteBranchOnMerge;
	@JsonKey(name: "allow_merge_commit")
	bool? allowMergeCommit;
	@JsonKey(name: "subscribers_count")
	int? subscribersCount;
	@JsonKey(name: "network_count")
	int? networkCount;
	RepoSourceLicense? license;
	int? forks;
	@JsonKey(name: "open_issues")
	int? openIssues;
	int? watchers;

	RepoSource(
      this.id,
      this.nodeId,
      this.name,
      this.fullName,
      this.owner,
      this.private,
      this.htmlUrl,
      this.description,
      this.fork,
      this.url,
      this.archiveUrl,
      this.assigneesUrl,
      this.blobsUrl,
      this.branchesUrl,
      this.collaboratorsUrl,
      this.commentsUrl,
      this.commitsUrl,
      this.compareUrl,
      this.contentsUrl,
      this.contributorsUrl,
      this.deploymentsUrl,
      this.downloadsUrl,
      this.eventsUrl,
      this.forksUrl,
      this.gitCommitsUrl,
      this.gitRefsUrl,
      this.gitTagsUrl,
      this.gitUrl,
      this.issueCommentUrl,
      this.issueEventsUrl,
      this.issuesUrl,
      this.keysUrl,
      this.labelsUrl,
      this.languagesUrl,
      this.mergesUrl,
      this.milestonesUrl,
      this.notificationsUrl,
      this.pullsUrl,
      this.releasesUrl,
      this.sshUrl,
      this.stargazersUrl,
      this.statusesUrl,
      this.subscribersUrl,
      this.subscriptionUrl,
      this.tagsUrl,
      this.teamsUrl,
      this.treesUrl,
      this.cloneUrl,
      this.mirrorUrl,
      this.hooksUrl,
      this.svnUrl,
      this.homepage,
      this.language,
      this.forksCount,
      this.stargazersCount,
      this.watchersCount,
      this.size,
      this.defaultBranch,
      this.openIssuesCount,
      this.isTemplate,
      this.topics,
      this.hasIssues,
      this.hasProjects,
      this.hasWiki,
      this.hasPages,
      this.hasDownloads,
      this.archived,
      this.disabled,
      this.visibility,
      this.pushedAt,
      this.createdAt,
      this.updatedAt,
      this.permissions,
      this.allowRebaseMerge,
      this.tempCloneToken,
      this.allowSquashMerge,
      this.allowAutoMerge,
      this.deleteBranchOnMerge,
      this.allowMergeCommit,
      this.subscribersCount,
      this.networkCount,
      this.license,
      this.forks,
      this.openIssues,
      this.watchers);

  factory RepoSource.fromJson(Map<String, dynamic> json) => _$RepoSourceFromJson(json);
	Map<String, dynamic> toJson() => _$RepoSourceToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RepoSourceOwner {
	String? login;
	int? id;
	@JsonKey(name: "node_id")
	String? nodeId;
	@JsonKey(name: "avatar_url")
	String? avatarUrl;
	@JsonKey(name: "gravatar_id")
	String? gravatarId;
	String? url;
	@JsonKey(name: "html_url")
	String? htmlUrl;
	@JsonKey(name: "followers_url")
	String? followersUrl;
	@JsonKey(name: "following_url")
	String? followingUrl;
	@JsonKey(name: "gists_url")
	String? gistsUrl;
	@JsonKey(name: "starred_url")
	String? starredUrl;
	@JsonKey(name: "subscriptions_url")
	String? subscriptionsUrl;
	@JsonKey(name: "organizations_url")
	String? organizationsUrl;
	@JsonKey(name: "repos_url")
	String? reposUrl;
	@JsonKey(name: "events_url")
	String? eventsUrl;
	@JsonKey(name: "received_events_url")
	String? receivedEventsUrl;
	String? type;
	@JsonKey(name: "site_admin")
	bool? siteAdmin;

	RepoSourceOwner(
      this.login,
      this.id,
      this.nodeId,
      this.avatarUrl,
      this.gravatarId,
      this.url,
      this.htmlUrl,
      this.followersUrl,
      this.followingUrl,
      this.gistsUrl,
      this.starredUrl,
      this.subscriptionsUrl,
      this.organizationsUrl,
      this.reposUrl,
      this.eventsUrl,
      this.receivedEventsUrl,
      this.type,
      this.siteAdmin);

  factory RepoSourceOwner.fromJson(Map<String, dynamic> json) => _$RepoSourceOwnerFromJson(json);
	Map<String, dynamic> toJson() => _$RepoSourceOwnerToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RepoSourcePermissions {
	bool? admin;
	bool? push;
	bool? pull;

	RepoSourcePermissions(this.admin, this.push, this.pull);

  factory RepoSourcePermissions.fromJson(Map<String, dynamic> json) => _$RepoSourcePermissionsFromJson(json);
	Map<String, dynamic> toJson() => _$RepoSourcePermissionsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RepoSourceLicense {
	String? key;
	String? name;
	String? url;
	@JsonKey(name: "spdx_id")
	String? spdxId;
	@JsonKey(name: "node_id")
	String? nodeId;
	@JsonKey(name: "html_url")
	String? htmlUrl;

	RepoSourceLicense(this.key, this.name, this.url, this.spdxId, this.nodeId, this.htmlUrl);

  factory RepoSourceLicense.fromJson(Map<String, dynamic> json) => _$RepoSourceLicenseFromJson(json);
	Map<String, dynamic> toJson() => _$RepoSourceLicenseToJson(this);
}
