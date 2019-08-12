// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_create_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventCreatePayload _$EventCreatePayloadFromJson(Map<String, dynamic> json) {
  return EventCreatePayload(
    ref: json['ref'] as String,
    refType: json['ref_type'] as String,
    masterBranch: json['masterBranch'] as String,
    description: json['description'] as String,
    pusherType: json['pusher_type'] as String,
  );
}

Map<String, dynamic> _$EventCreatePayloadToJson(EventCreatePayload instance) =>
    <String, dynamic>{
      'ref': instance.ref,
      'ref_type': instance.refType,
      'masterBranch': instance.masterBranch,
      'description': instance.description,
      'pusher_type': instance.pusherType,
    };
