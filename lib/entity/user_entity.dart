import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class UserEntity {
  final String? login;
  final int? id;
  @JsonKey(name: "node_id")
  final String? nodeId;
  @JsonKey(name: "avatar_url")
  final String? avatarUrl;
  @JsonKey(name: "gravatar_id")
  final String? gravatarId;
  final String? url;
  @JsonKey(name: "html_url")
  final String? htmlUrl;
  @JsonKey(name: "followers_url")
  final String? followersUrl;
  @JsonKey(name: "following_url")
  final String? followingUrl;
  @JsonKey(name: "gists_url")
  final String? gistsUrl;
  @JsonKey(name: "starred_url")
  final String? starredUrl;
  @JsonKey(name: "subscriptions_url")
  final String? subscriptionsUrl;
  @JsonKey(name: "organizations_url")
  final String? organizationsUrl;
  @JsonKey(name: "repos_url")
  final String? reposUrl;
  @JsonKey(name: "events_url")
  final String? eventsUrl;
  @JsonKey(name: "received_events_url")
  final String? receivedEventsUrl;
  final String? type;
  @JsonKey(name: "site_admin")
  final bool? siteAdmin;
  final String? name;
  final String? company;
  final String? blog;
  final String? location;
  final String? email;
  final bool? hireable;
  final String? bio;
  @JsonKey(name: "twitter_username")
  final String? twitterUsername;
  @JsonKey(name: "public_repos")
  final int? publicRepos;
  @JsonKey(name: "public_gists")
  final int? publicGists;
  final int? followers;
  final int? following;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "updated_at")
  final String? updatedAt;
  @JsonKey(name: "private_gists")
  final int? privateGists;
  @JsonKey(name: "total_private_repos")
  final int? totalPrivateRepos;
  @JsonKey(name: "owned_private_repos")
  final int? ownedPrivateRepos;
  @JsonKey(name: "disk_usage")
  final int? diskUsage;
  final int? collaborators;
  @JsonKey(name: "two_factor_authentication")
  final bool? twoFactorAuthentication;
  final UserPlan? plan;

  UserEntity(
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
      this.siteAdmin,
      this.name,
      this.company,
      this.blog,
      this.location,
      this.email,
      this.hireable,
      this.bio,
      this.twitterUsername,
      this.publicRepos,
      this.publicGists,
      this.followers,
      this.following,
      this.createdAt,
      this.updatedAt,
      this.privateGists,
      this.totalPrivateRepos,
      this.ownedPrivateRepos,
      this.diskUsage,
      this.collaborators,
      this.twoFactorAuthentication,
      this.plan);

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserPlan {
  final String? name;
  final int? space;
  @JsonKey(name: "private_repos")
  final int? privateRepos;
  final int? collaborators;

  UserPlan(this.name, this.space, this.privateRepos, this.collaborators);

  factory UserPlan.fromJson(Map<String, dynamic> json) => _$UserPlanFromJson(json);

  Map<String, dynamic> toJson() => _$UserPlanToJson(this);
}
