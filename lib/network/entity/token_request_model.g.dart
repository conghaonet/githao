// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenRequestModel _$TokenRequestModelFromJson(Map<String, dynamic> json) {
  return TokenRequestModel(
    json['client_id'] as String,
    json['client_secret'] as String,
    json['code'] as String,
    json['redirect_uri'] as String,
  );
}

Map<String, dynamic> _$TokenRequestModelToJson(TokenRequestModel instance) =>
    <String, dynamic>{
      'client_id': instance.clientId,
      'client_secret': instance.clientSecret,
      'code': instance.code,
      'redirect_uri': instance.redirectUri,
    };
