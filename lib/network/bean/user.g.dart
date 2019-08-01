// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    login: json['login'] as String,
    id: json['id'] as int,
    node_id: json['node_id'] as String,
    avatar_url: json['avatar_url'] as String,
    gravatar_id: json['gravatar_id'] as String,
    url: json['url'] as String,
    html_url: json['html_url'] as String,
    followers_url: json['followers_url'] as String,
    following_url: json['following_url'] as String,
    gists_url: json['gists_url'] as String,
    starred_url: json['starred_url'] as String,
    subscriptions_url: json['subscriptions_url'] as String,
    organizations_url: json['organizations_url'] as String,
    repos_url: json['repos_url'] as String,
    events_url: json['events_url'] as String,
    received_events_url: json['received_events_url'] as String,
    type: json['type'] as String,
    site_admin: json['site_admin'] as bool,
    name: json['name'] as String,
    company: json['company'] as String,
    blog: json['blog'] as String,
    location: json['location'] as String,
    email: json['email'] as String,
    hireable: json['hireable'] as String,
    bio: json['bio'] as String,
    public_repos: json['public_repos'] as int,
    public_gists: json['public_gists'] as int,
    followers: json['followers'] as int,
    following: json['following'] as int,
    created_at: json['created_at'] as String,
    updated_at: json['updated_at'] as String,
    private_gists: json['private_gists'] as int,
    total_private_repos: json['total_private_repos'] as int,
    owned_private_repos: json['owned_private_repos'] as int,
    disk_usage: json['disk_usage'] as int,
    collaborators: json['collaborators'] as int,
    two_factor_authentication: json['two_factor_authentication'] as bool,
    plan: json['plan'] == null
        ? null
        : UserPlan.fromJson(json['plan'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'node_id': instance.node_id,
      'avatar_url': instance.avatar_url,
      'gravatar_id': instance.gravatar_id,
      'url': instance.url,
      'html_url': instance.html_url,
      'followers_url': instance.followers_url,
      'following_url': instance.following_url,
      'gists_url': instance.gists_url,
      'starred_url': instance.starred_url,
      'subscriptions_url': instance.subscriptions_url,
      'organizations_url': instance.organizations_url,
      'repos_url': instance.repos_url,
      'events_url': instance.events_url,
      'received_events_url': instance.received_events_url,
      'type': instance.type,
      'site_admin': instance.site_admin,
      'name': instance.name,
      'company': instance.company,
      'blog': instance.blog,
      'location': instance.location,
      'email': instance.email,
      'hireable': instance.hireable,
      'bio': instance.bio,
      'public_repos': instance.public_repos,
      'public_gists': instance.public_gists,
      'followers': instance.followers,
      'following': instance.following,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'private_gists': instance.private_gists,
      'total_private_repos': instance.total_private_repos,
      'owned_private_repos': instance.owned_private_repos,
      'disk_usage': instance.disk_usage,
      'collaborators': instance.collaborators,
      'two_factor_authentication': instance.two_factor_authentication,
      'plan': instance.plan,
    };

UserPlan _$UserPlanFromJson(Map<String, dynamic> json) {
  return UserPlan(
    name: json['name'] as String,
    space: json['space'] as int,
    collaborators: json['collaborators'] as int,
    private_repos: json['private_repos'] as int,
  );
}

Map<String, dynamic> _$UserPlanToJson(UserPlan instance) => <String, dynamic>{
      'name': instance.name,
      'space': instance.space,
      'collaborators': instance.collaborators,
      'private_repos': instance.private_repos,
    };
