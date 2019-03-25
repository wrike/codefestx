import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'section.g.dart';

@JsonSerializable(nullable: false)
class Section {
  final String id;
  final String title;
  final String iconPath;
  final String color;
  final String description;
  final bool isCustom;

  Section({
    @required this.id,
    @required this.title,
    @required this.iconPath,
    @required this.color,
    @required this.description,
    @required this.isCustom,
  });

  factory Section.fromJson(Map<String, dynamic> json) => _$SectionFromJson(json);

  Map<String, dynamic> toJson() => _$SectionToJson(this);
}
