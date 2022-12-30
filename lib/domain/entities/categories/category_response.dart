import 'package:hacaton/domain/entities/categories/category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse {
  @JsonKey(name: 'status_code')
  final int statusCode;
  @JsonKey(name: 'items')
  final List<MyCategory> categories;

  CategoryResponse({
    required this.statusCode,
    required this.categories,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}
