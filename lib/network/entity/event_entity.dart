import 'package:json_annotation/json_annotation.dart';
export 'package:githao/resources/event_types.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'event_entity.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class EventEntity {
  String id;
  String type;
  EventActor actor;
  EventRepo repo;
  bool public;
  @JsonKey(name: 'created_at')
  String createdAt;
  dynamic payload;

  EventEntity({this.id, this.type, this.actor, this.repo, this.public, this.createdAt, this.payload});
  factory EventEntity.fromJson(Map<String, dynamic> json) => _$EventEntityFromJson(json);
  Map<String, dynamic> toJson() => _$EventEntityToJson(this);

  @override
  String toString() {
    return '{id: $id, type: $type, actor: $actor, repo: $repo, public: $public, createdAt: $createdAt, payload: $payload}';
  }


}

@JsonSerializable()
class EventActor {
  int id;
  String login;
  @JsonKey(name: 'display_login')
  String displayLogin;
  @JsonKey(name: 'gravatar_id')
  String gravatarId;
  String url;
  @JsonKey(name: 'avatar_url')
  String avatarUrl;

  EventActor({this.id, this.login, this.displayLogin, this.gravatarId, this.url, this.avatarUrl});
  factory EventActor.fromJson(Map<String, dynamic> json) => _$EventActorFromJson(json);
  Map<String, dynamic> toJson() => _$EventActorToJson(this);

  @override
  String toString() {
    return '{id: $id, login: $login, displayLogin: $displayLogin, gravatarId: $gravatarId, url: $url, avatarUrl: $avatarUrl}';
  }

}

@JsonSerializable()
class EventRepo {
  int id;
  String name;
  String url;

  EventRepo({this.id, this.name, this.url});
  factory EventRepo.fromJson(Map<String, dynamic> json) => _$EventRepoFromJson(json);
  Map<String, dynamic> toJson() => _$EventRepoToJson(this);

  @override
  String toString() {
    return '{id: $id, name: $name, url: $url}';
  }

}