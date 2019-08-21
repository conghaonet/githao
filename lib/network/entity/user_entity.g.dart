// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) {
  return UserEntity(
    gistsUrl: json['gists_url'] as String,
    reposUrl: json['repos_url'] as String,
    followingUrl: json['following_url'] as String,
    bio: json['bio'],
    createdAt: json['created_at'] as String,
    login: json['login'] as String,
    type: json['type'] as String,
    blog: json['blog'] as String,
    subscriptionsUrl: json['subscriptions_url'] as String,
    updatedAt: json['updated_at'] as String,
    siteAdmin: json['site_admin'] as bool,
    company: json['company'],
    id: json['id'] as int,
    publicRepos: json['public_repos'] as int,
    gravatarId: json['gravatar_id'] as String,
    email: json['email'],
    organizationsUrl: json['organizations_url'] as String,
    hireable: json['hireable'],
    starredUrl: json['starred_url'] as String,
    followersUrl: json['followers_url'] as String,
    publicGists: json['publicGists'] as int,
    url: json['url'] as String,
    receivedEventsUrl: json['received_events_url'] as String,
    followers: json['followers'] as int,
    avatarUrl: json['avatar_url'] as String,
    eventsUrl: json['events_url'] as String,
    htmlUrl: json['html_url'] as String,
    following: json['following'] as int,
    name: json['name'],
    location: json['location'],
    nodeId: json['node_id'] as String,
    privateGists: json['private_gists'] as int,
    totalPrivateRepos: json['total_private_repos'] as int,
    ownedPrivateRepos: json['owned_private_repos'] as int,
    diskUsage: json['disk_usage'] as int,
    collaborators: json['collaborators'] as int,
    twoFactorAuthentication: json['two_factor_authentication'] as bool,
    plan: json['plan'] == null
        ? null
        : UserPlan.fromJson(json['plan'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'gists_url': instance.gistsUrl,
      'repos_url': instance.reposUrl,
      'following_url': instance.followingUrl,
      'bio': instance.bio,
      'created_at': instance.createdAt,
      'login': instance.login,
      'type': instance.type,
      'blog': instance.blog,
      'subscriptions_url': instance.subscriptionsUrl,
      'updated_at': instance.updatedAt,
      'site_admin': instance.siteAdmin,
      'company': instance.company,
      'id': instance.id,
      'public_repos': instance.publicRepos,
      'gravatar_id': instance.gravatarId,
      'email': instance.email,
      'organizations_url': instance.organizationsUrl,
      'hireable': instance.hireable,
      'starred_url': instance.starredUrl,
      'followers_url': instance.followersUrl,
      'publicGists': instance.publicGists,
      'url': instance.url,
      'received_events_url': instance.receivedEventsUrl,
      'followers': instance.followers,
      'avatar_url': instance.avatarUrl,
      'events_url': instance.eventsUrl,
      'html_url': instance.htmlUrl,
      'following': instance.following,
      'name': instance.name,
      'location': instance.location,
      'node_id': instance.nodeId,
      'private_gists': instance.privateGists,
      'total_private_repos': instance.totalPrivateRepos,
      'owned_private_repos': instance.ownedPrivateRepos,
      'disk_usage': instance.diskUsage,
      'collaborators': instance.collaborators,
      'two_factor_authentication': instance.twoFactorAuthentication,
      'plan': instance.plan,
    };

UserPlan _$UserPlanFromJson(Map<String, dynamic> json) {
  return UserPlan(
    privateRepos: json['private_repos'] as int,
    name: json['name'] as String,
    collaborators: json['collaborators'] as int,
    space: json['space'] as int,
  );
}

Map<String, dynamic> _$UserPlanToJson(UserPlan instance) => <String, dynamic>{
      'private_repos': instance.privateRepos,
      'name': instance.name,
      'collaborators': instance.collaborators,
      'space': instance.space,
    };
