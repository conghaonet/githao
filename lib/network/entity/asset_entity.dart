import 'package:githao/network/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'asset_entity.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class AssetEntity {
  int id;
  @JsonKey(name: 'node_id')
  String noteId;
  String name;
  String label;
  UserEntity uploader;
  @JsonKey(name: 'content_type')
  String contentType;
  String state;
  int size;
  @JsonKey(name: 'download_count')
  int downloadCount;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'updated_at')
  String updatedAt;
  @JsonKey(name: 'browser_download_url')
  String browserDownloadUrl;

  AssetEntity({this.id, this.noteId, this.name, this.label, this.uploader, this.contentType, this.state, this.size, this.downloadCount, this.createdAt,
    this.updatedAt, this.browserDownloadUrl});

  factory AssetEntity.fromJson(Map<String, dynamic> json) => _$AssetEntityFromJson(json);
  Map<String, dynamic> toJson() => _$AssetEntityToJson(this);

  @override
  String toString() {
    return '{id: $id, noteId: $noteId, name: $name, label: $label, uploader: $uploader, contentType: $contentType, state: $state, size: $size, downloadCount: $downloadCount, createdAt: $createdAt, updatedAt: $updatedAt, browserDownloadUrl: $browserDownloadUrl}';
  }
}