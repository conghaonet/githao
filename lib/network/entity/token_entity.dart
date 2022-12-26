import 'package:json_annotation/json_annotation.dart';

part 'token_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class TokenEntity {
  @JsonKey(name: 'access_token')
  final String accessToken;
  final String scope;
  @JsonKey(name: 'token_type')
  final String tokenType;

  TokenEntity(this.accessToken, this.scope, this.tokenType);

  factory TokenEntity.fromJson(Map<String, dynamic> json) => _$TokenEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TokenEntityToJson(this);
}
