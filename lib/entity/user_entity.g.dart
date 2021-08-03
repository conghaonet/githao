// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) {
  return UserEntity(
    json['login'] as String?,
    json['id'] as int?,
    json['node_id'] as String?,
    json['avatar_url'] as String?,
    json['gravatar_id'] as String?,
    json['url'] as String?,
    json['html_url'] as String?,
    json['followers_url'] as String?,
    json['following_url'] as String?,
    json['gists_url'] as String?,
    json['starred_url'] as String?,
    json['subscriptions_url'] as String?,
    json['organizations_url'] as String?,
    json['repos_url'] as String?,
    json['events_url'] as String?,
    json['received_events_url'] as String?,
    json['type'] as String?,
    json['site_admin'] as bool?,
    json['name'] as String?,
    json['company'] as String?,
    json['blog'] as String?,
    json['location'] as String?,
    json['email'] as String?,
    json['hireable'] as bool?,
    json['bio'] as String?,
    json['twitter_username'] as String?,
    json['public_repos'] as int?,
    json['public_gists'] as int?,
    json['followers'] as int?,
    json['following'] as int?,
    json['created_at'] as String?,
    json['updated_at'] as String?,
    json['private_gists'] as int?,
    json['total_private_repos'] as int?,
    json['owned_private_repos'] as int?,
    json['disk_usage'] as int?,
    json['collaborators'] as int?,
    json['two_factor_authentication'] as bool?,
    json['plan'] == null
        ? null
        : UserPlan.fromJson(json['plan'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'node_id': instance.nodeId,
      'avatar_url': instance.avatarUrl,
      'gravatar_id': instance.gravatarId,
      'url': instance.url,
      'html_url': instance.htmlUrl,
      'followers_url': instance.followersUrl,
      'following_url': instance.followingUrl,
      'gists_url': instance.gistsUrl,
      'starred_url': instance.starredUrl,
      'subscriptions_url': instance.subscriptionsUrl,
      'organizations_url': instance.organizationsUrl,
      'repos_url': instance.reposUrl,
      'events_url': instance.eventsUrl,
      'received_events_url': instance.receivedEventsUrl,
      'type': instance.type,
      'site_admin': instance.siteAdmin,
      'name': instance.name,
      'company': instance.company,
      'blog': instance.blog,
      'location': instance.location,
      'email': instance.email,
      'hireable': instance.hireable,
      'bio': instance.bio,
      'twitter_username': instance.twitterUsername,
      'public_repos': instance.publicRepos,
      'public_gists': instance.publicGists,
      'followers': instance.followers,
      'following': instance.following,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'private_gists': instance.privateGists,
      'total_private_repos': instance.totalPrivateRepos,
      'owned_private_repos': instance.ownedPrivateRepos,
      'disk_usage': instance.diskUsage,
      'collaborators': instance.collaborators,
      'two_factor_authentication': instance.twoFactorAuthentication,
      'plan': instance.plan?.toJson(),
    };

UserPlan _$UserPlanFromJson(Map<String, dynamic> json) {
  return UserPlan(
    json['name'] as String?,
    json['space'] as int?,
    json['private_repos'] as int?,
    json['collaborators'] as int?,
  );
}

Map<String, dynamic> _$UserPlanToJson(UserPlan instance) => <String, dynamic>{
      'name': instance.name,
      'space': instance.space,
      'private_repos': instance.privateRepos,
      'collaborators': instance.collaborators,
    };
