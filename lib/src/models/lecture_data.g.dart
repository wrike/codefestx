// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LectureData _$LectureDataFromJson(Map<String, dynamic> json) {
  return LectureData(
      id: json['id'] as String,
      title: json['title'] as String,
      speakerIds: (json['speakerIds'] as List).map((e) => e as String),
      description: json['description'] as String,
      locationId: json['locationId'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      duration: json['duration'] as int);
}

Map<String, dynamic> _$LectureDataToJson(LectureData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'speakerIds': instance.speakerIds.toList(),
      'description': instance.description,
      'locationId': instance.locationId,
      'startTime': instance.startTime.toIso8601String(),
      'duration': instance.duration
    };
