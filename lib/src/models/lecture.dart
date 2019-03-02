import 'package:codefest/src/models/location.dart';
import 'package:codefest/src/models/speaker.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'lecture.g.dart';

@JsonSerializable(nullable: false)
class Lecture {
  final String id;
  final String title;
  final Iterable<Speaker> speakers;
  final String description;
  final Location location;
  final DateTime startTime;
  final int duration;

  Lecture({
    @required this.id,
    @required this.title,
    @required this.speakers,
    @required this.description,
    @required this.location,
    @required this.startTime,
    @required this.duration,
  });

  factory Lecture.fromJson(Map<String, dynamic> json) => _$LectureFromJson(json);

  Map<String, dynamic> toJson() => _$LectureToJson(this);
}
