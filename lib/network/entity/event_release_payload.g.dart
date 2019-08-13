// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_release_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventReleasePayload _$EventReleasePayloadFromJson(Map<String, dynamic> json) {
  return EventReleasePayload(
    action: json['action'] as String,
    release: json['release'] == null
        ? null
        : ReleaseEntity.fromJson(json['release'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EventReleasePayloadToJson(
        EventReleasePayload instance) =>
    <String, dynamic>{
      'action': instance.action,
      'release': instance.release,
    };
