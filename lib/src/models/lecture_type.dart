import 'package:json_annotation/json_annotation.dart';

enum LectureType {
  @JsonValue('lecture')
  lecture,
  @JsonValue('custom')
  custom,
  @JsonValue('wrike')
  wrike,
}
