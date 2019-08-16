import 'package:githao/network/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'repo_entity.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class RepoEntity {
	@JsonKey(name: 'stargazers_count')
	int stargazersCount;
	@JsonKey(name: 'pushed_at')
	String pushedAt;
	@JsonKey(name: 'subscription_url')
	String subscriptionUrl;
	String language;
	@JsonKey(name: 'branches_url')
	String branchesUrl;
	@JsonKey(name: 'issueComment_url')
	String issueCommentUrl;
	@JsonKey(name: 'labels_url')
	String labelsUrl;
	@JsonKey(name: 'subscribers_url')
	String subscribersUrl;
	RepoPermissions permissions;
	@JsonKey(name: 'releases_url')
	String releasesUrl;
	@JsonKey(name: 'svn_url')
	String svnUrl;
	int id;
	int forks;
	@JsonKey(name: 'archive_url')
	String archiveUrl;
	@JsonKey(name: 'git_refs_url')
	String gitRefsUrl;
	@JsonKey(name: 'forks_url')
	String forksUrl;
	@JsonKey(name: 'statuses_url')
	String statusesUrl;
	@JsonKey(name: 'ssh_url')
	String sshUrl;
	RepoLicense license;
	@JsonKey(name: 'full_name')
	String fullName;
	int size;
	@JsonKey(name: 'languages_url')
	String languagesUrl;
	@JsonKey(name: 'html_url')
	String htmlUrl;
	@JsonKey(name: 'collaborators_url')
	String collaboratorsUrl;
	@JsonKey(name: 'clone_url')
	String cloneUrl;
	String name;
	@JsonKey(name: 'pulls_url')
	String pullsUrl;
	@JsonKey(name: 'default_branch')
	String defaultBranch;
	@JsonKey(name: 'hooks_url')
	String hooksUrl;
	@JsonKey(name: 'trees_url')
	String treesUrl;
	@JsonKey(name: 'tags_url')
	String tagsUrl;
	bool private;
	@JsonKey(name: 'contributors_url')
	String contributorsUrl;
	@JsonKey(name: 'has_downloads')
	bool hasDownloads;
	@JsonKey(name: 'notifications_url')
	String notificationsUrl;
	@JsonKey(name: 'open_issues_count')
	int openIssuesCount;
	String description;
	@JsonKey(name: 'created_at')
	String createdAt;
	int watchers;
	@JsonKey(name: 'keys_url')
	String keysUrl;
	@JsonKey(name: 'deployments_url')
	String deploymentsUrl;
	@JsonKey(name: 'has_projects')
	bool hasProjects;
	bool archived;
	@JsonKey(name: 'has_wiki')
	bool hasWiki;
	@JsonKey(name: 'updated_at')
	String updatedAt;
	@JsonKey(name: 'comments_url')
	String commentsUrl;
	@JsonKey(name: 'stargazers_url')
	String stargazersUrl;
	bool disabled;
	@JsonKey(name: 'git_url')
	String gitUrl;
	@JsonKey(name: 'has_pages')
	bool hasPages;
	UserEntity owner;
	@JsonKey(name: 'commits_url')
	String commitsUrl;
	@JsonKey(name: 'compare_url')
	String compareUrl;
	@JsonKey(name: 'git_commits_url')
	String gitCommitsUrl;
	@JsonKey(name: 'blobs_url')
	String blobsUrl;
	@JsonKey(name: 'gitTags_url')
	String gitTagsUrl;
	@JsonKey(name: 'merges_url')
	String mergesUrl;
	@JsonKey(name: 'downloads_url')
	String downloadsUrl;
	@JsonKey(name: 'has_issues')
	bool hasIssues;
	String url;
	@JsonKey(name: 'contents_url')
	String contentsUrl;
	@JsonKey(name: 'mirror_url')
	dynamic mirrorUrl;
	@JsonKey(name: 'milestones_url')
	String milestonesUrl;
	@JsonKey(name: 'teams_url')
	String teamsUrl;
	bool fork;
	@JsonKey(name: 'issues_url')
	String issuesUrl;
	@JsonKey(name: 'events_url')
	String eventsUrl;
	@JsonKey(name: 'issue_events_url')
	String issueEventsUrl;
	@JsonKey(name: 'assignees_url')
	String assigneesUrl;
	@JsonKey(name: 'open_issues')
	int openIssues;
	@JsonKey(name: 'watchers_count')
	int watchersCount;
	@JsonKey(name: 'node_id')
	String nodeId;
	dynamic homepage;
	@JsonKey(name: 'forks_count')
	int forksCount;
	RepoEntity({this.stargazersCount, this.pushedAt, this.subscriptionUrl, this.language, this.branchesUrl, this.issueCommentUrl, this.labelsUrl,
		this.subscribersUrl, this.permissions, this.releasesUrl, this.svnUrl, this.id, this.forks, this.archiveUrl, this.gitRefsUrl, this.forksUrl,
		this.statusesUrl, this.sshUrl, this.license, this.fullName, this.size, this.languagesUrl, this.htmlUrl, this.collaboratorsUrl, this.cloneUrl,
		this.name, this.pullsUrl, this.defaultBranch, this.hooksUrl, this.treesUrl, this.tagsUrl, this.private, this.contributorsUrl, this.hasDownloads,
		this.notificationsUrl, this.openIssuesCount, this.description, this.createdAt, this.watchers, this.keysUrl, this.deploymentsUrl, this.hasProjects,
		this.archived, this.hasWiki, this.updatedAt, this.commentsUrl, this.stargazersUrl, this.disabled, this.gitUrl, this.hasPages, this.owner,
		this.commitsUrl, this.compareUrl, this.gitCommitsUrl, this.blobsUrl, this.gitTagsUrl, this.mergesUrl, this.downloadsUrl, this.hasIssues, this.url,
		this.contentsUrl, this.mirrorUrl, this.milestonesUrl, this.teamsUrl, this.fork, this.issuesUrl, this.eventsUrl, this.issueEventsUrl,
		this.assigneesUrl, this.openIssues, this.watchersCount, this.nodeId, this.homepage, this.forksCount});
	factory RepoEntity.fromJson(Map<String, dynamic> json) => _$RepoEntityFromJson(json);
	Map<String, dynamic> toJson() => _$RepoEntityToJson(this);

	@override
	String toString() {
		return 'RepoEntity{stargazersCount: $stargazersCount, pushedAt: $pushedAt, subscriptionUrl: $subscriptionUrl, language: $language, branchesUrl: $branchesUrl, issueCommentUrl: $issueCommentUrl, labelsUrl: $labelsUrl, subscribersUrl: $subscribersUrl, permissions: $permissions, releasesUrl: $releasesUrl, svnUrl: $svnUrl, id: $id, forks: $forks, archiveUrl: $archiveUrl, gitRefsUrl: $gitRefsUrl, forksUrl: $forksUrl, statusesUrl: $statusesUrl, sshUrl: $sshUrl, license: $license, fullName: $fullName, size: $size, languagesUrl: $languagesUrl, htmlUrl: $htmlUrl, collaboratorsUrl: $collaboratorsUrl, cloneUrl: $cloneUrl, name: $name, pullsUrl: $pullsUrl, defaultBranch: $defaultBranch, hooksUrl: $hooksUrl, treesUrl: $treesUrl, tagsUrl: $tagsUrl, private: $private, contributorsUrl: $contributorsUrl, hasDownloads: $hasDownloads, notificationsUrl: $notificationsUrl, openIssuesCount: $openIssuesCount, description: $description, createdAt: $createdAt, watchers: $watchers, keysUrl: $keysUrl, deploymentsUrl: $deploymentsUrl, hasProjects: $hasProjects, archived: $archived, hasWiki: $hasWiki, updatedAt: $updatedAt, commentsUrl: $commentsUrl, stargazersUrl: $stargazersUrl, disabled: $disabled, gitUrl: $gitUrl, hasPages: $hasPages, owner: $owner, commitsUrl: $commitsUrl, compareUrl: $compareUrl, gitCommitsUrl: $gitCommitsUrl, blobsUrl: $blobsUrl, gitTagsUrl: $gitTagsUrl, mergesUrl: $mergesUrl, downloadsUrl: $downloadsUrl, hasIssues: $hasIssues, url: $url, contentsUrl: $contentsUrl, mirrorUrl: $mirrorUrl, milestonesUrl: $milestonesUrl, teamsUrl: $teamsUrl, fork: $fork, issuesUrl: $issuesUrl, eventsUrl: $eventsUrl, issueEventsUrl: $issueEventsUrl, assigneesUrl: $assigneesUrl, openIssues: $openIssues, watchersCount: $watchersCount, nodeId: $nodeId, homepage: $homepage, forksCount: $forksCount}';
	}

}

@JsonSerializable()
class RepoPermissions {
	bool pull;
	bool admin;
	bool push;
	RepoPermissions({this.pull, this.admin, this.push});
	factory RepoPermissions.fromJson(Map<String, dynamic> json) => _$RepoPermissionsFromJson(json);
	Map<String, dynamic> toJson() => _$RepoPermissionsToJson(this);

	@override
	String toString() {
		return '{pull: $pull, admin: $admin, push: $push}';
	}

}

@JsonSerializable()
class RepoLicense {
	String name;
	@JsonKey(name: 'spdx_id')
	String spdxId;
	String key;
	String url;
	String nodeId;
	RepoLicense({this.name, this.spdxId, this.key, this.url, this.nodeId});
	factory RepoLicense.fromJson(Map<String, dynamic> json) => _$RepoLicenseFromJson(json);
	Map<String, dynamic> toJson() => _$RepoLicenseToJson(this);

	@override
	String toString() {
		return '{name: $name, spdxId: $spdxId, key: $key, url: $url, nodeId: $nodeId}';
	}

}

@JsonSerializable()
class RepoOwner {
	@JsonKey(name: 'gists_url')
	String gistsUrl;
	@JsonKey(name: 'repos_url')
	String reposUrl;
	@JsonKey(name: 'following_url')
	String followingUrl;
	@JsonKey(name: 'starred_url')
	String starredUrl;
	String login;
	@JsonKey(name: 'followers_url')
	String followersUrl;
	String type;
	String url;
	@JsonKey(name: 'subscriptions_url')
	String subscriptionsUrl;
	@JsonKey(name: 'received_events_url')
	String receivedEventsUrl;
	@JsonKey(name: 'avatar_url')
	String avatarUrl;
	@JsonKey(name: 'events_url')
	String eventsUrl;
	@JsonKey(name: 'html_url')
	String htmlUrl;
	@JsonKey(name: 'site_admin')
	bool siteAdmin;
	int id;
	@JsonKey(name: 'gravatar_id')
	String gravatarId;
	@JsonKey(name: 'node_id')
	String nodeId;
	@JsonKey(name: 'organizations_url')
	String organizationsUrl;
	RepoOwner({this.gistsUrl, this.reposUrl, this.followingUrl, this.starredUrl, this.login, this.followersUrl, this.type, this.url,
		this.subscriptionsUrl, this.receivedEventsUrl, this.avatarUrl, this.eventsUrl, this.htmlUrl, this.siteAdmin, this.id, this.gravatarId,
		this.nodeId, this.organizationsUrl});
	factory RepoOwner.fromJson(Map<String, dynamic> json) => _$RepoOwnerFromJson(json);
	Map<String, dynamic> toJson() => _$RepoOwnerToJson(this);

	@override
	String toString() {
		return '{gistsUrl: $gistsUrl, reposUrl: $reposUrl, followingUrl: $followingUrl, starredUrl: $starredUrl, login: $login, followersUrl: $followersUrl, type: $type, url: $url, subscriptionsUrl: $subscriptionsUrl, receivedEventsUrl: $receivedEventsUrl, avatarUrl: $avatarUrl, eventsUrl: $eventsUrl, htmlUrl: $htmlUrl, siteAdmin: $siteAdmin, id: $id, gravatarId: $gravatarId, nodeId: $nodeId, organizationsUrl: $organizationsUrl}';
	}

}
