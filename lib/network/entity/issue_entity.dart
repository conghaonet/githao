import 'package:githao/network/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'issue_entity.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class IssueEntity {
  int id;
  int number;
  int comments;
  bool locked;
  @JsonKey(name: 'node_id')
  String noteId;
  String title;
  String body;
  String state;
  UserEntity user;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'updated_at')
  String updatedAt;
  @JsonKey(name: 'closed_at')
  String closedAt;

  IssueEntity({this.id, this.number, this.comments, this.locked, this.noteId, this.title, this.body, this.state, this.user, this.createdAt,
    this.updatedAt, this.closedAt});

  factory IssueEntity.fromJson(Map<String, dynamic> json) => _$IssueEntityFromJson(json);
  Map<String, dynamic> toJson() => _$IssueEntityToJson(this);

  @override
  String toString() {
    return '{id: $id, number: $number, comments: $comments, locked: $locked, noteId: $noteId, title: $title, body: $body, state: $state, user: $user, createdAt: $createdAt, updatedAt: $updatedAt, closedAt: $closedAt}';
  }
}