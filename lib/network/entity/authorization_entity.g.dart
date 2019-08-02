// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorization_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorizationEntity _$AuthorizationEntityFromJson(Map<String, dynamic> json) {
  return AuthorizationEntity(
    app: json['app'] == null
        ? null
        : AuthorizationApp.fromJson(json['app'] as Map<String, dynamic>),
    hashedToken: json['hashed_token'] as String,
    note: json['note'],
    noteUrl: json['note_url'] as String,
    updatedAt: json['updated_at'] as String,
    tokenLastEight: json['token_last_eight'] as String,
    fingerprint: json['fingerprint'],
    createdAt: json['created_at'] as String,
    id: json['id'] as int,
    scopes: (json['scopes'] as List)?.map((e) => e as String)?.toList(),
    url: json['url'] as String,
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$AuthorizationEntityToJson(
        AuthorizationEntity instance) =>
    <String, dynamic>{
      'app': instance.app,
      'hashed_token': instance.hashedToken,
      'note': instance.note,
      'note_url': instance.noteUrl,
      'updated_at': instance.updatedAt,
      'token_last_eight': instance.tokenLastEight,
      'fingerprint': instance.fingerprint,
      'created_at': instance.createdAt,
      'id': instance.id,
      'scopes': instance.scopes,
      'url': instance.url,
      'token': instance.token,
    };

AuthorizationApp _$AuthorizationAppFromJson(Map<String, dynamic> json) {
  return AuthorizationApp(
    name: json['name'] as String,
    url: json['url'] as String,
    clientId: json['client_id'] as String,
  );
}

Map<String, dynamic> _$AuthorizationAppToJson(AuthorizationApp instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'client_id': instance.clientId,
    };
