import 'package:githao/network/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'comment_entity.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class CommentEntity {
  int id;
  @JsonKey(name: 'node_id')
  String noteId;
  String body;
  UserEntity user;
  @JsonKey(name: 'author_association')
  String authorAssociation;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'updated_at')
  String updatedAt;


  CommentEntity({this.id, this.noteId, this.body, this.user, this.authorAssociation, this.createdAt, this.updatedAt});

  factory CommentEntity.fromJson(Map<String, dynamic> json) => _$CommentEntityFromJson(json);
  Map<String, dynamic> toJson() => _$CommentEntityToJson(this);

  @override
  String toString() {
    return '{id: $id, noteId: $noteId, body: $body, user: $user, authorAssociation: $authorAssociation, createdAt: $createdAt, updatedAt: $updatedAt}';
  }


}