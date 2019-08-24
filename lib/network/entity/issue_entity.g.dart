// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueEntity _$IssueEntityFromJson(Map<String, dynamic> json) {
  return IssueEntity(
    id: json['id'] as int,
    number: json['number'] as int,
    comments: json['comments'] as int,
    locked: json['locked'] as bool,
    noteId: json['node_id'] as String,
    title: json['title'] as String,
    body: json['body'] as String,
    state: json['state'] as String,
    user: json['user'] == null
        ? null
        : UserEntity.fromJson(json['user'] as Map<String, dynamic>),
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
    closedAt: json['closed_at'] as String,
    url: json['url'] as String,
    repositoryUrl: json['repository_url'] as String,
    labelsUrl: json['labels_url'] as String,
    commentsUrl: json['comments_url'] as String,
    eventsUrl: json['events_url'] as String,
    htmlUrl: json['html_url'] as String,
    activeLockReason: json['active_lock_reason'] as String,
    labels: (json['labels'] as List)
        ?.map((e) =>
            e == null ? null : IssueLabel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    assignee: json['assignee'] == null
        ? null
        : UserEntity.fromJson(json['assignee'] as Map<String, dynamic>),
    assignees: (json['assignees'] as List)
        ?.map((e) =>
            e == null ? null : UserEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    milestone: json['milestone'] == null
        ? null
        : IssueMilestone.fromJson(json['milestone'] as Map<String, dynamic>),
    pullRequest: json['pull_request'] == null
        ? null
        : IssuePullRequest.fromJson(
            json['pull_request'] as Map<String, dynamic>),
    repository: json['repository'] == null
        ? null
        : RepoEntity.fromJson(json['repository'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$IssueEntityToJson(IssueEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'comments': instance.comments,
      'locked': instance.locked,
      'node_id': instance.noteId,
      'title': instance.title,
      'body': instance.body,
      'state': instance.state,
      'user': instance.user,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'closed_at': instance.closedAt,
      'url': instance.url,
      'repository_url': instance.repositoryUrl,
      'labels_url': instance.labelsUrl,
      'comments_url': instance.commentsUrl,
      'events_url': instance.eventsUrl,
      'html_url': instance.htmlUrl,
      'active_lock_reason': instance.activeLockReason,
      'labels': instance.labels,
      'assignee': instance.assignee,
      'assignees': instance.assignees,
      'milestone': instance.milestone,
      'pull_request': instance.pullRequest,
      'repository': instance.repository,
    };

IssueLabel _$IssueLabelFromJson(Map<String, dynamic> json) {
  return IssueLabel(
    id: json['id'] as int,
    noteId: json['node_id'] as String,
    url: json['url'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    color: json['color'] as String,
    defaulted: json['default'] as bool,
  );
}

Map<String, dynamic> _$IssueLabelToJson(IssueLabel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'node_id': instance.noteId,
      'url': instance.url,
      'name': instance.name,
      'description': instance.description,
      'color': instance.color,
      'default': instance.defaulted,
    };

IssueMilestone _$IssueMilestoneFromJson(Map<String, dynamic> json) {
  return IssueMilestone(
    url: json['url'] as String,
    htmlUrl: json['html_url'] as String,
    labelsUrl: json['labels_url'] as String,
    id: json['id'] as int,
    noteId: json['node_id'] as String,
    number: json['number'] as int,
    state: json['state'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    creator: json['creator'] == null
        ? null
        : UserEntity.fromJson(json['creator'] as Map<String, dynamic>),
    openIssues: json['open_issues'] as int,
    closedIssues: json['closed_issues'] as int,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
    closedAt: json['closed_at'] as String,
    dueOn: json['due_on'] as String,
  );
}

Map<String, dynamic> _$IssueMilestoneToJson(IssueMilestone instance) =>
    <String, dynamic>{
      'url': instance.url,
      'html_url': instance.htmlUrl,
      'labels_url': instance.labelsUrl,
      'id': instance.id,
      'node_id': instance.noteId,
      'number': instance.number,
      'state': instance.state,
      'title': instance.title,
      'description': instance.description,
      'creator': instance.creator,
      'open_issues': instance.openIssues,
      'closed_issues': instance.closedIssues,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'closed_at': instance.closedAt,
      'due_on': instance.dueOn,
    };

IssuePullRequest _$IssuePullRequestFromJson(Map<String, dynamic> json) {
  return IssuePullRequest(
    url: json['url'] as String,
    htmlUrl: json['html_url'] as String,
    diffUrl: json['diff_url'] as String,
    patchUrl: json['patch_url'] as String,
  );
}

Map<String, dynamic> _$IssuePullRequestToJson(IssuePullRequest instance) =>
    <String, dynamic>{
      'url': instance.url,
      'html_url': instance.htmlUrl,
      'diff_url': instance.diffUrl,
      'patch_url': instance.patchUrl,
    };
