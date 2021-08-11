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
  // Can be one of all, owner, public, private, member.
  String? type;
  // Can be one of all, public, or private.
  String? visibility;
  // Default: owner,collaborator,organization_member
  String? affiliation;
  ReposQueriesEntity({
    this.sort = pushedSort,
    this.type = 'all',
    this.visibility,
    this.affiliation,

    this.page = 1
  });

  factory ReposQueriesEntity.fromJson(Map<String, dynamic> json) => _$ReposQueriesEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ReposQueriesEntityToJson(this);

}