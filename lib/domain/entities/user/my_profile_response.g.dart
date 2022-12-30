// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyProfileResponse _$MyProfileResponseFromJson(Map<String, dynamic> json) =>
    MyProfileResponse(
      statusCode: json['status_code'] as int,
      myProfile: MyProfile.fromJson(json['item'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyProfileResponseToJson(MyProfileResponse instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'item': instance.myProfile,
    };
