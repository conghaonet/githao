// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventEntity _$EventEntityFromJson(Map<String, dynamic> json) {
  return EventEntity(
    id: json['id'] as String,
    type: json['type'] as String,
    actor: json['actor'] == null
        ? null
        : EventActor.fromJson(json['actor'] as Map<String, dynamic>),
    repo: json['repo'] == null
        ? null
        : EventRepo.fromJson(json['repo'] as Map<String, dynamic>),
    public: json['public'] as bool,
    createdAt: json['created_at'] as String,
    payload: json['payload'],
  );
}

Map<String, dynamic> _$EventEntityToJson(EventEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'actor': instance.actor,
      'repo': instance.repo,
      'public': instance.public,
      'created_at': instance.createdAt,
      'payload': instance.payload,
    };

EventActor _$EventActorFromJson(Map<String, dynamic> json) {
  return EventActor(
    id: json['id'] as int,
    login: json['login'] as String,
    displayLogin: json['display_login'] as String,
    gravatarId: json['gravatar_id'] as String,
    url: json['url'] as String,
    avatarUrl: json['avatar_url'] as String,
  );
}

Map<String, dynamic> _$EventActorToJson(EventActor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'display_login': instance.displayLogin,
      'gravatar_id': instance.gravatarId,
      'url': instance.url,
      'avatar_url': instance.avatarUrl,
    };

EventRepo _$EventRepoFromJson(Map<String, dynamic> json) {
  return EventRepo(
    id: json['id'] as int,
    name: json['name'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$EventRepoToJson(EventRepo instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
    };
