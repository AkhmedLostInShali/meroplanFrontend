import 'package:json_annotation/json_annotation.dart';

part 'mero_event.g.dart';

@JsonSerializable()
class MeroEvent {
  final String id;
  final String name;
  @JsonKey(name: 'image_path')
  final String imagePath;
  final List<int> categories;
  @JsonKey(name: 'is_membered')
  bool isMembered;
  int members;
  final String date;
  final String time;
  final String address;
  @JsonKey(name: 'sponsors_id')
  final String sponsorsId;
  @JsonKey(name: 'sponsors_name')
  final String sponsorsName;
  @JsonKey(name: 'sponsors_image_path')
  final String sponsorsImagePath;

  MeroEvent({
    required this.address,
    required this.id,
    required this.name,
    required this.imagePath,
    required this.categories,
    required this.members,
    required this.isMembered,
    required this.date,
    required this.time,
    required this.sponsorsId,
    required this.sponsorsName,
    required this.sponsorsImagePath,
  });

  factory MeroEvent.fromJson(Map<String, dynamic> json) => _$MeroEventFromJson(json);

  Map<String, dynamic> toJson() => _$MeroEventToJson(this);
}
