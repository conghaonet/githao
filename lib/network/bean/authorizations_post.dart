import 'package:json_annotation/json_annotation.dart';

import '../dio_client.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'authorizations_post.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class AuthorizationsPost {
  @JsonKey(name: 'client_id')
  String clientId;
  @JsonKey(name: 'client_secret')
  String clientSecret;
  String appName;
  String callback;
  List<String> scopes;

  AuthorizationsPost({this.clientId, this.clientSecret, this.appName, this.callback, this.scopes}) {
    this.clientId = DioClient.CLIENT_ID;
    this.clientSecret = DioClient.CLIENT_SECRET;
    this.appName = DioClient.APPLICATION_NAME;
    this.callback = DioClient.CALLBACK_URL;
    this.scopes = ["user", "repo", "gist", "notifications"];
  }

  factory AuthorizationsPost.fromJson(Map<String, dynamic> json) => _$AuthorizationsPostFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorizationsPostToJson(this);

}