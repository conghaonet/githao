import 'package:json_annotation/json_annotation.dart';

part 'repo_subscription_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class RepoSubscriptionEntity {
	bool? subscribed;
	bool? ignored;
	String? reason;
	@JsonKey(name: "created_at")
	String? createdAt;
	String? url;
	@JsonKey(name: "repository_url")
	String? repositoryUrl;


	RepoSubscriptionEntity(this.subscribed, this.ignored, this.reason, this.createdAt, this.url, this.repositoryUrl);

  factory RepoSubscriptionEntity.fromJson(Map<String, dynamic> json) => _$RepoSubscriptionEntityFromJson(json);
	Map<String, dynamic> toJson() => _$RepoSubscriptionEntityToJson(this);

}
