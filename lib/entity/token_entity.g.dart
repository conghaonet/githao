// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenEntity _$TokenEntityFromJson(Map<String, dynamic> json) {
  return TokenEntity(
    json['access_token'] as String,
    json['scope'] as String,
    json['token_type'] as String,
  );
}

Map<String, dynamic> _$TokenEntityToJson(TokenEntity instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'scope': instance.scope,
      'token_type': instance.tokenType,
    };
