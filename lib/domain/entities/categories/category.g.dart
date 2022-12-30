// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyCategory _$MyCategoryFromJson(Map<String, dynamic> json) => MyCategory(
      id: json['id'] as int,
      name: json['name'] as String,
      imagePath: json['image_path'] as String,
      rootChain:
          (json['root_chain'] as List<dynamic>).map((e) => e as int).toList(),
      parentsId: json['parents_id'] as int?,
    );

Map<String, dynamic> _$MyCategoryToJson(MyCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'root_chain': instance.rootChain,
      'image_path': instance.imagePath,
      'parents_id': instance.parentsId,
    };
