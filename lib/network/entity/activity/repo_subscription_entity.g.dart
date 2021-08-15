// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo_subscription_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepoSubscriptionEntity _$RepoSubscriptionEntityFromJson(
    Map<String, dynamic> json) {
  return RepoSubscriptionEntity(
    json['subscribed'] as bool?,
    json['ignored'] as bool?,
    json['reason'] as String?,
    json['created_at'] as String?,
    json['url'] as String?,
    json['repository_url'] as String?,
  );
}

Map<String, dynamic> _$RepoSubscriptionEntityToJson(
        RepoSubscriptionEntity instance) =>
    <String, dynamic>{
      'subscribed': instance.subscribed,
      'ignored': instance.ignored,
      'reason': instance.reason,
      'created_at': instance.createdAt,
      'url': instance.url,
      'repository_url': instance.repositoryUrl,
    };
