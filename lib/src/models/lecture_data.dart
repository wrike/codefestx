import 'package:codefest/src/models/_types.dart';
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
  final String sectionId;
  @JsonKey(nullable: false)
  final int startTime;
  @JsonKey(nullable: false)
  final int duration;
  @JsonKey(defaultValue: LanguageType.ru)
  final LanguageType lang;
  @JsonKey(defaultValue: false)
  final bool isFavorite;
  @JsonKey(defaultValue: false)
  final bool isLiked;
  @JsonKey(defaultValue: 0)
  final int likesCount;
  @JsonKey(defaultValue: 0)
  final int favoritesCount;

  LectureData({
    @required this.id,
    @required this.title,
    @required this.speakerIds,
    @required this.description,
    @required this.locationId,
    @required this.sectionId,
    @required this.startTime,
    @required this.duration,
    this.lang,
    this.type,
    this.isFavorite,
    this.isLiked,
    this.likesCount,
    this.favoritesCount,
  });

  factory LectureData.fromJson(Map<String, dynamic> json) => _$LectureDataFromJson(json);

  Map<String, dynamic> toJson() => _$LectureDataToJson(this);
}
