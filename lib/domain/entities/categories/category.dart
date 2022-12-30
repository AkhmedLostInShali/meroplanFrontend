import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class MyCategory {
  final int id;
  final String name;
  @JsonKey(name: 'root_chain')
  final List<int> rootChain;
  @JsonKey(name: 'image_path')
  final String imagePath;
  @JsonKey(name: 'parents_id')
  final int? parentsId;

  MyCategory({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.rootChain,
    this.parentsId,
  });

  factory MyCategory.fromJson(Map<String, dynamic> json) => _$MyCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$MyCategoryToJson(this);
}
