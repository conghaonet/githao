// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_fork_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventForkPayload _$EventForkPayloadFromJson(Map<String, dynamic> json) {
  return EventForkPayload(
    json['forkee'] == null
        ? null
        : ForkeeEntity.fromJson(json['forkee'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EventForkPayloadToJson(EventForkPayload instance) =>
    <String, dynamic>{
      'forkee': instance.forkee,
    };

ForkeeEntity _$ForkeeEntityFromJson(Map<String, dynamic> json) {
  return ForkeeEntity(
    id: json['id'] as int,
    name: json['name'] as String,
    fullName: json['full_name'] as String,
    private: json['private'] as bool,
    owner: json['owner'] == null
        ? null
        : UserEntity.fromJson(json['owner'] as Map<String, dynamic>),
    fork: json['fork'] as bool,
  );
}

Map<String, dynamic> _$ForkeeEntityToJson(ForkeeEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'full_name': instance.fullName,
      'private': instance.private,
      'owner': instance.owner,
      'fork': instance.fork,
    };
