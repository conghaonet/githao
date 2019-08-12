import 'package:json_annotation/json_annotation.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'only_action_payload.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class OnlyActionPayload {
  String action;

  OnlyActionPayload(this.action);

  factory OnlyActionPayload.fromJson(Map<String, dynamic> json) => _$OnlyActionPayloadFromJson(json);
  Map<String, dynamic> toJson() => _$OnlyActionPayloadToJson(this);


  @override
  String toString() {
    return '{action: $action}';
  }


}