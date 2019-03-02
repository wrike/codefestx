// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lecture _$LectureFromJson(Map<String, dynamic> json) {
  return Lecture(
      id: json['id'] as String,
      title: json['title'] as String,
      speakers: (json['speakers'] as List)
          .map((e) => Speaker.fromJson(e as Map<String, dynamic>)),
      description: json['description'] as String,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      startTime: DateTime.parse(json['startTime'] as String),
      duration: json['duration'] as int);
}

Map<String, dynamic> _$LectureToJson(Lecture instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'speakers': instance.speakers.toList(),
      'description': instance.description,
      'location': instance.location,
      'startTime': instance.startTime.toIso8601String(),
      'duration': instance.duration
    };
