import 'package:hacaton/domain/entities/mero_events/mero_event.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mero_event_response.g.dart';

@JsonSerializable()
class MeroEventResponse {
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'status_code')
  final int statusCode;
  @JsonKey(name: 'items')
  final List<MeroEvent> meroEvents;

  MeroEventResponse({
    required this.totalPages,
    required this.statusCode,
    required this.meroEvents,
  });

  factory MeroEventResponse.fromJson(Map<String, dynamic> json) => _$MeroEventResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MeroEventResponseToJson(this);
}
