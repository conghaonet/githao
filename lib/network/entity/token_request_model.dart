import 'package:json_annotation/json_annotation.dart';

part 'token_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TokenRequestModel {
  @JsonKey(name: 'client_id')
  final String clientId;
  @JsonKey(name: 'client_secret')
  final String clientSecret;
  final String code;
  @JsonKey(name: 'redirect_uri')
  final String redirectUri;

  TokenRequestModel(this.clientId, this.clientSecret, this.code, this.redirectUri);

  factory TokenRequestModel.fromJson(Map<String, dynamic> json) => _$TokenRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$TokenRequestModelToJson(this);
}
