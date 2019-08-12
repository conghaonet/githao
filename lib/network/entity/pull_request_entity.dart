import 'package:json_annotation/json_annotation.dart';

import 'user_entity.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'pull_request_entity.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class PullRequestEntity {
  int id;
  int number;
  String state;
  bool locked;
  String title;
  String body;
  UserEntity user;

  PullRequestEntity({this.id, this.number, this.state, this.locked, this.title, this.body, this.user});

  factory PullRequestEntity.fromJson(Map<String, dynamic> json) => _$PullRequestEntityFromJson(json);
  Map<String, dynamic> toJson() => _$PullRequestEntityToJson(this);

  @override
  String toString() {
    return '{id: $id, number: $number, state: $state, locked: $locked, title: $title, body: $body, user: $user}';
  }

}