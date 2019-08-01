// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorizations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Authorizations _$AuthorizationsFromJson(Map<String, dynamic> json) {
  return Authorizations(
    app: json['app'] == null
        ? null
        : AuthorizationsApp.fromJson(json['app'] as Map<String, dynamic>),
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

Map<String, dynamic> _$AuthorizationsToJson(Authorizations instance) =>
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

AuthorizationsApp _$AuthorizationsAppFromJson(Map<String, dynamic> json) {
  return AuthorizationsApp(
    name: json['name'] as String,
    url: json['url'] as String,
    clientId: json['client_id'] as String,
  );
}

Map<String, dynamic> _$AuthorizationsAppToJson(AuthorizationsApp instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'client_id': instance.clientId,
    };
