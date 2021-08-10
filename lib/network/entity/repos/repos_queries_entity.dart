import 'package:json_annotation/json_annotation.dart';

part 'repos_queries_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class ReposQueriesEntity {
  static const createdSort = 'created';
  static const updatedSort = 'updated';
  static const pushedSort = 'pushed';
  static const fullNameSort = 'full_name';
  late String sort;
  late int page;

  ReposQueriesEntity({this.sort = pushedSort, this.page = 1});

  factory ReposQueriesEntity.fromJson(Map<String, dynamic> json) => _$ReposQueriesEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ReposQueriesEntityToJson(this);

}