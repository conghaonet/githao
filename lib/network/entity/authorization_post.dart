import 'package:json_annotation/json_annotation.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'authorization_post.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class AuthorizationPost {
  static const CLIENT_ID  = "c868cf1dc9c48103bb55";
  static const CLIENT_SECRET  = "b341fe1eb154f1d78b4f8f58288106d95bce3bf0";
  static const APPLICATION_NAME = "HaoGitHub";
  static const CALLBACK_URL = "https://github.com/conghaonet/HaoGitHub/callback";
  static const List<String> SCOPES = ["user", "repo", "gist", "notifications"];

  @JsonKey(name: 'client_id')
  String clientId;
  @JsonKey(name: 'client_secret')
  String clientSecret;
  String appName;
  String callback;
  List<String> scopes;

  AuthorizationPost({this.clientId, this.clientSecret, this.appName, this.callback, this.scopes}) {
    this.clientId = CLIENT_ID;
    this.clientSecret = CLIENT_SECRET;
    this.appName = APPLICATION_NAME;
    this.callback = CALLBACK_URL;
    this.scopes = SCOPES;
  }

  factory AuthorizationPost.fromJson(Map<String, dynamic> json) => _$AuthorizationPostFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorizationPostToJson(this);

}