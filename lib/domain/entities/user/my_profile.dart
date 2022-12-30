import 'package:hacaton/domain/entities/user/address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_profile.g.dart';

@JsonSerializable()
class MyProfile {
  final String id;
  final String? name;
  final String phone;
  final String rank;
  @JsonKey(name: 'image_path')
  final String? imagePath;
  @JsonKey(name: 'address_list')
  final List<Address> addressList;

  MyProfile({
    required this.id,
    required this.name,
    this.imagePath,
    required this.phone,
    required this.rank,
    required this.addressList,
  });

  factory MyProfile.fromJson(Map<String, dynamic> json) => _$MyProfileFromJson(json);

  Map<String, dynamic> toJson() => _$MyProfileToJson(this);
}
