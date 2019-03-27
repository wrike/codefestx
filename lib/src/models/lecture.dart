import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:codefest/src/models/_types.dart';
import 'package:codefest/src/models/location.dart';
import 'package:codefest/src/models/section.dart';
import 'package:codefest/src/models/speaker.dart';

part 'lecture.g.dart';

abstract class Lecture implements Built<Lecture, LectureBuilder> {
  factory Lecture([void updates(LectureBuilder b)]) = _$Lecture;

  Lecture._();

  String get id;

  String get title;

  LectureType get type;

  BuiltList<Speaker> get speakers;

  String get description;

  Location get location;

  Section get section;

  DateTime get startTime;

  int get duration;

  LanguageType get language;

  bool get isFavorite;

  bool get isLiked;

  int get likesCount;

  int get favoritesCount;

  bool get isActual;
}
