import 'package:json_annotation/json_annotation.dart';

part 'repo_subscription_queries_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class RepoSubscriptionQueriesEntity {
  bool subscribed;
  bool ignored;

  RepoSubscriptionQueriesEntity(this.subscribed, this.ignored);

  factory RepoSubscriptionQueriesEntity.fromJson(Map<String, dynamic> json) => _$RepoSubscriptionQueriesEntityFromJson(json);
  Map<String, dynamic> toJson() => _$RepoSubscriptionQueriesEntityToJson(this);
}