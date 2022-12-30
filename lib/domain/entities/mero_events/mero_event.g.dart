// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mero_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeroEvent _$MeroEventFromJson(Map<String, dynamic> json) => MeroEvent(
      address: json['address'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      imagePath: json['image_path'] as String,
      categories:
          (json['categories'] as List<dynamic>).map((e) => e as int).toList(),
      members: json['members'] as int,
      isMembered: json['is_membered'] as bool,
      date: json['date'] as String,
      time: json['time'] as String,
      sponsorsId: json['sponsors_id'] as String,
      sponsorsName: json['sponsors_name'] as String,
      sponsorsImagePath: json['sponsors_image_path'] as String,
    );

Map<String, dynamic> _$MeroEventToJson(MeroEvent instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_path': instance.imagePath,
      'categories': instance.categories,
      'is_membered': instance.isMembered,
      'members': instance.members,
      'date': instance.date,
      'time': instance.time,
      'address': instance.address,
      'sponsors_id': instance.sponsorsId,
      'sponsors_name': instance.sponsorsName,
      'sponsors_image_path': instance.sponsorsImagePath,
    };
