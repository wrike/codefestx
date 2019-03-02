import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'location.g.dart';

@JsonSerializable(nullable: false)
class Location {
  final String id;
  final String title;
  final String logoPath;
  final String mapPath;
  final String description;

  Location({
    @required this.id,
    @required this.title,
    @required this.logoPath,
    @required this.mapPath,
    @required this.description,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
