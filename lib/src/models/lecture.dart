import 'package:codefest/src/models/_types.dart';
import 'package:codefest/src/models/location.dart';
import 'package:codefest/src/models/section.dart';
import 'package:codefest/src/models/speaker.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'lecture.g.dart';

@JsonSerializable(nullable: false)
class Lecture {
  final String id;
  final String title;
  final LectureType type;
  final Iterable<Speaker> speakers;
  final String description;
  final Location location;
  final Section section;
  final DateTime startTime;
  final int duration;
  final LanguageType language;
  final bool isFavorite;
  final bool isLiked;
  final int likesCount;
  final int favoritesCount;
  final int figureNumber;

  Lecture({
    @required this.id,
    @required this.title,
    @required this.type,
    @required this.speakers,
    @required this.description,
    @required this.location,
    @required this.section,
    @required this.startTime,
    @required this.duration,
    @required this.language,
    @required this.isFavorite,
    @required this.isLiked,
    @required this.likesCount,
    @required this.favoritesCount,
    @required this.figureNumber,
  });

  factory Lecture.fromJson(Map<String, dynamic> json) => _$LectureFromJson(json);

  Map<String, dynamic> toJson() => _$LectureToJson(this);
}
