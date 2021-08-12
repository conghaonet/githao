import 'package:githao/util/const.dart';
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
  @JsonKey(name: 'per_page')
  late final int perPage;
  // Can be one of all, owner, public, private, member.
  String? type;
  // Can be one of all, public, or private.
  String? visibility;
  // Default: owner,collaborator,organization_member
  String? affiliation;
  ReposQueriesEntity({
    this.sort = pushedSort,
    this.page = 1,
    this.perPage = Const.perPageNormal,
    this.type,
    this.visibility,
    this.affiliation
  });
  ReposQueriesEntity.userOrOrg({
    this.sort = pushedSort,
    this.page = 1,
    this.perPage = Const.perPageNormal,
    this.type = 'all'
  });

  ReposQueriesEntity.authedUser({
    this.sort = pushedSort,
    this.page = 1,
    this.perPage = Const.perPageNormal,
    this.visibility = 'all',
  });

  factory ReposQueriesEntity.fromJson(Map<String, dynamic> json) => _$ReposQueriesEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ReposQueriesEntityToJson(this);

}