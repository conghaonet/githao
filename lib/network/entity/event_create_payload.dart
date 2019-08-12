import 'package:json_annotation/json_annotation.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'event_create_payload.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class EventCreatePayload {
  String ref;
  @JsonKey(name: 'ref_type')
  String refType;
  String masterBranch;
  String description;
  @JsonKey(name: 'pusher_type')
  String pusherType;

  EventCreatePayload({this.ref, this.refType, this.masterBranch, this.description, this.pusherType});

  factory EventCreatePayload.fromJson(Map<String, dynamic> json) => _$EventCreatePayloadFromJson(json);
  Map<String, dynamic> toJson() => _$EventCreatePayloadToJson(this);

  @override
  String toString() {
    return '{ref: $ref, refType: $refType, masterBranch: $masterBranch, description: $description, pusherType: $pusherType}';
  }
}