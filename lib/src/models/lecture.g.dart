// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lecture _$LectureFromJson(Map<String, dynamic> json) {
  return Lecture(
      id: json['id'] as String,
      title: json['title'] as String,
      type: _$enumDecode(_$LectureTypeEnumMap, json['type']),
      speakers: (json['speakers'] as List)
          .map((e) => Speaker.fromJson(e as Map<String, dynamic>)),
      description: json['description'] as String,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      section: Section.fromJson(json['section'] as Map<String, dynamic>),
      startTime: DateTime.parse(json['startTime'] as String),
      duration: json['duration'] as int,
      isStarred: json['isStarred'] as bool,
      isLiked: json['isLiked'] as bool);
}

Map<String, dynamic> _$LectureToJson(Lecture instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': _$LectureTypeEnumMap[instance.type],
      'speakers': instance.speakers.toList(),
      'description': instance.description,
      'location': instance.location,
      'section': instance.section,
      'startTime': instance.startTime.toIso8601String(),
      'duration': instance.duration,
      'isStarred': instance.isStarred,
      'isLiked': instance.isLiked
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

const _$LectureTypeEnumMap = <LectureType, dynamic>{
  LectureType.lecture: 'lecture',
  LectureType.custom: 'custom',
  LectureType.wrike: 'wrike'
};
