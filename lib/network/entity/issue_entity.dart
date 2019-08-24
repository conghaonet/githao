import 'package:githao/network/entity/repo_entity.dart';
import 'package:githao/network/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'issue_entity.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class IssueEntity {
  int id;
  int number;
  int comments;
  bool locked;
  @JsonKey(name: 'node_id')
  String noteId;
  String title;
  String body;
  String state;
  UserEntity user;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'updated_at')
  String updatedAt;
  @JsonKey(name: 'closed_at')
  String closedAt;

  String url;
  @JsonKey(name: 'repository_url')
  String repositoryUrl;
  @JsonKey(name: 'labels_url')
  String labelsUrl;
  @JsonKey(name: 'comments_url')
  String commentsUrl;
  @JsonKey(name: 'events_url')
  String eventsUrl;
  @JsonKey(name: 'html_url')
  String htmlUrl;
  @JsonKey(name: 'active_lock_reason')
  String activeLockReason;
  List<IssueLabel> labels;
  UserEntity assignee;
  List<UserEntity> assignees;
  IssueMilestone milestone;
  @JsonKey(name: 'pull_request')
  IssuePullRequest pullRequest;
  RepoEntity repository;

  IssueEntity({this.id, this.number, this.comments, this.locked, this.noteId, this.title, this.body, this.state, this.user, this.createdAt,
    this.updatedAt, this.closedAt, this.url, this.repositoryUrl, this.labelsUrl, this.commentsUrl, this.eventsUrl, this.htmlUrl,
    this.activeLockReason, this.labels, this.assignee, this.assignees, this.milestone, this.pullRequest, this.repository});

  factory IssueEntity.fromJson(Map<String, dynamic> json) => _$IssueEntityFromJson(json);
  Map<String, dynamic> toJson() => _$IssueEntityToJson(this);

  @override
  String toString() {
    return '{id: $id, number: $number, comments: $comments, locked: $locked, noteId: $noteId, title: $title, body: $body, state: $state, user: $user, createdAt: $createdAt, updatedAt: $updatedAt, closedAt: $closedAt, url: $url, repositoryUrl: $repositoryUrl, labelsUrl: $labelsUrl, commentsUrl: $commentsUrl, eventsUrl: $eventsUrl, htmlUrl: $htmlUrl, activeLockReason: $activeLockReason, labels: $labels, assignee: $assignee, assignees: $assignees, milestone: $milestone, pullRequest: $pullRequest, repository: $repository}';
  }
}

@JsonSerializable()
class IssueLabel {
  int id;
  @JsonKey(name: 'node_id')
  String noteId;
  String url;
  String name;
  String description;
  String color;
  @JsonKey(name: 'default')
  bool defaulted;

  IssueLabel({this.id, this.noteId, this.url, this.name, this.description, this.color, this.defaulted});

  factory IssueLabel.fromJson(Map<String, dynamic> json) => _$IssueLabelFromJson(json);
  Map<String, dynamic> toJson() => _$IssueLabelToJson(this);

  @override
  String toString() {
    return '{id: $id, noteId: $noteId, url: $url, name: $name, description: $description, color: $color, defaulted: $defaulted}';
  }
}

@JsonSerializable()
class IssueMilestone {
  String url;
  @JsonKey(name: 'html_url')
  String htmlUrl;
  @JsonKey(name: 'labels_url')
  String labelsUrl;
  int id;
  @JsonKey(name: 'node_id')
  String noteId;
  int number;
  String state;
  String title;
  String description;
  UserEntity creator;
  @JsonKey(name: 'open_issues')
  int openIssues;
  @JsonKey(name: 'closed_issues')
  int closedIssues;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'updated_at')
  String updatedAt;
  @JsonKey(name: 'closed_at')
  String closedAt;
  @JsonKey(name: 'due_on')
  String dueOn;

  IssueMilestone({this.url, this.htmlUrl, this.labelsUrl, this.id, this.noteId, this.number, this.state, this.title, this.description, this.creator,
    this.openIssues, this.closedIssues, this.createdAt, this.updatedAt, this.closedAt, this.dueOn});

  factory IssueMilestone.fromJson(Map<String, dynamic> json) => _$IssueMilestoneFromJson(json);
  Map<String, dynamic> toJson() => _$IssueMilestoneToJson(this);

  @override
  String toString() {
    return '{url: $url, htmlUrl: $htmlUrl, labelsUrl: $labelsUrl, id: $id, noteId: $noteId, number: $number, state: $state, title: $title, description: $description, creator: $creator, openIssues: $openIssues, closedIssues: $closedIssues, createdAt: $createdAt, updatedAt: $updatedAt, closedAt: $closedAt, dueOn: $dueOn}';
  }
}

@JsonSerializable()
class IssuePullRequest {
  String url;
  @JsonKey(name: 'html_url')
  String htmlUrl;
  @JsonKey(name: 'diff_url')
  String diffUrl;
  @JsonKey(name: 'patch_url')
  String patchUrl;

  IssuePullRequest({this.url, this.htmlUrl, this.diffUrl, this.patchUrl});

  factory IssuePullRequest.fromJson(Map<String, dynamic> json) => _$IssuePullRequestFromJson(json);
  Map<String, dynamic> toJson() => _$IssuePullRequestToJson(this);

  @override
  String toString() {
    return '{url: $url, htmlUrl: $htmlUrl, diffUrl: $diffUrl, patchUrl: $patchUrl}';
  }
}