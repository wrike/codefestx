import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'lecture_data.g.dart';

@JsonSerializable(nullable: false)
class LectureData {
  final String id;
  final String title;
  final Iterable<String> speakerIds;
  final String description;
  final String locationId;
  final DateTime startTime;
  final int duration;

  LectureData({
    @required this.id,
    @required this.title,
    @required this.speakerIds,
    @required this.description,
    @required this.locationId,
    @required this.startTime,
    @required this.duration,
  });

  factory LectureData.fromJson(Map<String, dynamic> json) => _$LectureDataFromJson(json);

  Map<String, dynamic> toJson() => _$LectureDataToJson(this);
}
