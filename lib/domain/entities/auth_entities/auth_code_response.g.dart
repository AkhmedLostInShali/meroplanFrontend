// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_code_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthCodeResponse _$AuthCodeResponseFromJson(Map<String, dynamic> json) =>
    AuthCodeResponse(
      result: json['result'] as String,
      accessToken: json['access_token'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AuthCodeResponseToJson(AuthCodeResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'access_token': instance.accessToken,
      'message': instance.message,
    };
