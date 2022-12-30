// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyProfile _$MyProfileFromJson(Map<String, dynamic> json) => MyProfile(
      id: json['id'] as String,
      name: json['name'] as String?,
      imagePath: json['image_path'] as String?,
      phone: json['phone'] as String,
      rank: json['rank'] as String,
      addressList: (json['address_list'] as List<dynamic>)
          .map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyProfileToJson(MyProfile instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'rank': instance.rank,
      'image_path': instance.imagePath,
      'address_list': instance.addressList,
    };
