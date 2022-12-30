import 'package:hacaton/domain/entities/user/my_profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_profile_response.g.dart';

@JsonSerializable()
class MyProfileResponse {
  @JsonKey(name: 'status_code')
  final int statusCode;
  @JsonKey(name: 'item')
  final MyProfile myProfile;

  MyProfileResponse({
    required this.statusCode,
    required this.myProfile
  });

  factory MyProfileResponse.fromJson(Map<String, dynamic> json) => _$MyProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyProfileResponseToJson(this);
}
