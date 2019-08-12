import 'package:githao/network/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'event_fork_payload.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class EventForkPayload {
  ForkeeEntity forkee;

  EventForkPayload(this.forkee);

  factory EventForkPayload.fromJson(Map<String, dynamic> json) => _$EventForkPayloadFromJson(json);
  Map<String, dynamic> toJson() => _$EventForkPayloadToJson(this);

  @override
  String toString() {
    return '{frokee: $forkee}';
  }
}

@JsonSerializable()
class ForkeeEntity {
  int id;
  String name;
  @JsonKey(name: 'full_name')
  String fullName;
  bool private;
  UserEntity owner;
  bool fork;

  ForkeeEntity({this.id, this.name, this.fullName, this.private, this.owner, this.fork});
  factory ForkeeEntity.fromJson(Map<String, dynamic> json) => _$ForkeeEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ForkeeEntityToJson(this);
  @override
  String toString() {
    return '{id: $id, name: $name, fullName: $fullName, private: $private, owner: $owner, fork: $fork}';
  }


}