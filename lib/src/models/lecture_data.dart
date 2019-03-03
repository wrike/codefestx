import 'package:codefest/src/models/lecture_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'lecture_data.g.dart';

@JsonSerializable()
class LectureData {
  @JsonKey(nullable: false)
  final String id;
  @JsonKey(nullable: false)
  final String title;
  @JsonKey(defaultValue: LectureType.lecture)
  final LectureType type;
  @JsonKey(defaultValue: const <String>[])
  final Iterable<String> speakerIds;
  @JsonKey(nullable: false)
  final String description;
  @JsonKey(nullable: false)
  final String locationId;
  @JsonKey(nullable: false)
  final DateTime startTime;
  @JsonKey(nullable: false)
  final int duration;
  @JsonKey(defaultValue: false)
  final bool isStarred;
  @JsonKey(defaultValue: false)
  final bool isLiked;

  LectureData({
    @required this.id,
    @required this.title,
    @required this.speakerIds,
    @required this.description,
    @required this.locationId,
    @required this.startTime,
    @required this.duration,
    this.type,
    this.isStarred,
    this.isLiked,
  });

  factory LectureData.fromJson(Map<String, dynamic> json) => _$LectureDataFromJson(json);

  Map<String, dynamic> toJson() => _$LectureDataToJson(this);
}
