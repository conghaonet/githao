import 'package:githao/network/entity/release_entity.dart';
import 'package:json_annotation/json_annotation.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'event_release_payload.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class EventReleasePayload {
  String action;
  ReleaseEntity release;

  EventReleasePayload({this.action, this.release});

  factory EventReleasePayload.fromJson(Map<String, dynamic> json) => _$EventReleasePayloadFromJson(json);
  Map<String, dynamic> toJson() => _$EventReleasePayloadToJson(this);

  @override
  String toString() {
    return '{action: $action, release: $release}';
  }


}