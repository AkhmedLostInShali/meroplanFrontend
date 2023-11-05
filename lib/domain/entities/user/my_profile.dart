import 'package:hacaton/domain/entities/user/address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_profile.g.dart';

@JsonSerializable()
class MyProfile {
  final String id;
  final String? name;
  final String? surname;
  final String? nickname;
  final String phone;
  @JsonKey(name: 'image_path')
  final String? imagePath;

  MyProfile({
    required this.id,
    required this.name,
    this.surname,
    this.nickname,
    this.imagePath,
    required this.phone,
  });

  factory MyProfile.fromJson(Map<String, dynamic> json) => _$MyProfileFromJson(json);

  Map<String, dynamic> toJson() => _$MyProfileToJson(this);
}
