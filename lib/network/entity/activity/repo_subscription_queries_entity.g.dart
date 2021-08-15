// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo_subscription_queries_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepoSubscriptionQueriesEntity _$RepoSubscriptionQueriesEntityFromJson(
    Map<String, dynamic> json) {
  return RepoSubscriptionQueriesEntity(
    json['subscribed'] as bool,
    json['ignored'] as bool,
  );
}

Map<String, dynamic> _$RepoSubscriptionQueriesEntityToJson(
        RepoSubscriptionQueriesEntity instance) =>
    <String, dynamic>{
      'subscribed': instance.subscribed,
      'ignored': instance.ignored,
    };
