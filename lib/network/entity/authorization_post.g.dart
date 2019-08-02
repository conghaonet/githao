// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorization_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorizationPost _$AuthorizationPostFromJson(Map<String, dynamic> json) {
  return AuthorizationPost(
    clientId: json['client_id'] as String,
    clientSecret: json['client_secret'] as String,
    appName: json['appName'] as String,
    callback: json['callback'] as String,
    scopes: (json['scopes'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$AuthorizationPostToJson(AuthorizationPost instance) =>
    <String, dynamic>{
      'client_id': instance.clientId,
      'client_secret': instance.clientSecret,
      'appName': instance.appName,
      'callback': instance.callback,
      'scopes': instance.scopes,
    };
