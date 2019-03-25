import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'speaker.g.dart';

@JsonSerializable(nullable: false)
class Speaker {
  final String id;
  final String name;
  final String company;
  final String avatarPath;
  final String description;

  Speaker({
    @required this.id,
    @required this.name,
    @required this.company,
    @required this.avatarPath,
    @required this.description,
  });

  factory Speaker.fromJson(Map<String, dynamic> json) => _$SpeakerFromJson(json);

  Map<String, dynamic> toJson() => _$SpeakerToJson(this);
}
