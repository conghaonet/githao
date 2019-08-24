import 'package:json_annotation/json_annotation.dart';

/// .g.dart 将在我们运行生成命令后自动生成
part 'search_entity.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutterchina.club/json/)
@JsonSerializable()
class SearchEntity {
  @JsonKey(name: 'total_count')
  int totalCount;
  @JsonKey(name: 'incomplete_results')
  bool incompleteResults;
  List<dynamic> items;

  SearchEntity({this.totalCount, this.incompleteResults, this.items});

  factory SearchEntity.fromJson(Map<String, dynamic> json) => _$SearchEntityFromJson(json);
  Map<String, dynamic> toJson() => _$SearchEntityToJson(this);


  @override
  String toString() {
    return '{totalCount: $totalCount, incompleteResults: $incompleteResults, items: $items}';
  }

}