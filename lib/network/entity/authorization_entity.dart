import 'package:json_annotation/json_annotation.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'authorization_entity.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class AuthorizationEntity {
  AuthorizationApp app;
  @JsonKey(name: 'hashed_token')
  String hashedToken;
  dynamic note;
  @JsonKey(name: 'note_url')
  String noteUrl;
  @JsonKey(name: 'updated_at')
  String updatedAt;
  @JsonKey(name: 'token_last_eight')
  String tokenLastEight;
  dynamic fingerprint;
  @JsonKey(name: 'created_at')
  String createdAt;
  int id;
  List<String> scopes;
  String url;
  String token;
  AuthorizationEntity({this.app, this.hashedToken, this.note, this.noteUrl, this.updatedAt, this.tokenLastEight, this.fingerprint, this.createdAt, this.id, this.scopes, this.url, this.token});

  factory AuthorizationEntity.fromJson(Map<String, dynamic> json) => _$AuthorizationEntityFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorizationEntityToJson(this);

}

@JsonSerializable()
class AuthorizationApp {
  String name;
  String url;
  @JsonKey(name: 'client_id')
  String clientId;
  AuthorizationApp({this.name, this.url, this.clientId});

  factory AuthorizationApp.fromJson(Map<String, dynamic> json) => _$AuthorizationAppFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorizationAppToJson(this);

}
