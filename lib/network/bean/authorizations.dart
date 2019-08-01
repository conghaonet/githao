import 'package:json_annotation/json_annotation.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'authorizations.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class Authorizations {
  AuthorizationsApp app;
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
  Authorizations({this.app, this.hashedToken, this.note, this.noteUrl, this.updatedAt, this.tokenLastEight, this.fingerprint, this.createdAt, this.id, this.scopes, this.url, this.token});

  factory Authorizations.fromJson(Map<String, dynamic> json) {
    Authorizations _authorizations = _$AuthorizationsFromJson(json);
    return _authorizations;
  }
  Map<String, dynamic> toJson() => _$AuthorizationsToJson(this);

}

@JsonSerializable()
class AuthorizationsApp {
  String name;
  String url;
  @JsonKey(name: 'client_id')
  String clientId;
  AuthorizationsApp({this.name, this.url, this.clientId});

  factory AuthorizationsApp.fromJson(Map<String, dynamic> json) {
    AuthorizationsApp _authorizationsApp = _$AuthorizationsAppFromJson(json);
    return _authorizationsApp;
  }
  Map<String, dynamic> toJson() => _$AuthorizationsAppToJson(this);

}
