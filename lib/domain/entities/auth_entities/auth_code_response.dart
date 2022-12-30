import 'package:json_annotation/json_annotation.dart';

part 'auth_code_response.g.dart';

@JsonSerializable()
class AuthCodeResponse {
  final String result;
  @JsonKey(name: 'access_token')
  final String? accessToken;
  final String? message;

  AuthCodeResponse({
    required this.result,
    this.accessToken,
    this.message
  });

  factory AuthCodeResponse.fromJson(Map<String, dynamic> json) => _$AuthCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthCodeResponseToJson(this);
}
