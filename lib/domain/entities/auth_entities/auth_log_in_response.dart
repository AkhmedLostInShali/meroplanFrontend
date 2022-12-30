import 'package:json_annotation/json_annotation.dart';

part 'auth_log_in_response.g.dart';

@JsonSerializable()
class AuthLogInResponse {
  final String result;
  @JsonKey(name: 'auth_token')
  final String? authToken;
  final String? message;

  AuthLogInResponse({
    required this.result,
    this.authToken,
    this.message
  });

  factory AuthLogInResponse.fromJson(Map<String, dynamic> json) => _$AuthLogInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthLogInResponseToJson(this);
}
