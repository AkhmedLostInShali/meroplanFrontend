// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: json['id'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      street: json['street'] as String,
      house: json['house'] as String,
      flat: json['flat'] as int?,
      entrance: json['entrance'] as int?,
      level: json['level'] as int?,
      comment: json['comment'] as int?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'city': instance.city,
      'street': instance.street,
      'house': instance.house,
      'flat': instance.flat,
      'entrance': instance.entrance,
      'level': instance.level,
      'comment': instance.comment,
    };
