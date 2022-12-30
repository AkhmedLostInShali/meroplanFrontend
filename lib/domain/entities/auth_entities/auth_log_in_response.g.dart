// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_log_in_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthLogInResponse _$AuthLogInResponseFromJson(Map<String, dynamic> json) =>
    AuthLogInResponse(
      result: json['result'] as String,
      authToken: json['auth_token'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AuthLogInResponseToJson(AuthLogInResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'auth_token': instance.authToken,
      'message': instance.message,
    };
