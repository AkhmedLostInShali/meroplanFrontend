import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  final String id;
  final String name;
  final String city;
  final String street;
  final String house;
  final int? flat;
  final int? entrance;
  final int? level;
  final int? comment;

  Address({
    required this.id,
    required this.name,
    required this.city,
    required this.street,
    required this.house,
    this.flat,
    this.entrance,
    this.level,
    this.comment,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
