// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mero_event_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeroEventResponse _$MeroEventResponseFromJson(Map<String, dynamic> json) =>
    MeroEventResponse(
      totalPages: json['total_pages'] as int,
      statusCode: json['status_code'] as int,
      meroEvents: (json['items'] as List<dynamic>)
          .map((e) => MeroEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MeroEventResponseToJson(MeroEventResponse instance) =>
    <String, dynamic>{
      'total_pages': instance.totalPages,
      'status_code': instance.statusCode,
      'items': instance.meroEvents,
    };
