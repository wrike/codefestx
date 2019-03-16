// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LectureData _$LectureDataFromJson(Map<String, dynamic> json) {
  return LectureData(
      id: json['id'] as String,
      title: json['title'] as String,
      speakerIds: (json['speakerIds'] as List)?.map((e) => e as String) ?? [],
      description: json['description'] as String,
      locationId: json['locationId'] as String,
      sectionId: json['sectionId'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      duration: json['duration'] as int,
      lang: _$enumDecodeNullable(_$LanguageTypeEnumMap, json['lang']) ??
          LanguageType.ru,
      type: _$enumDecodeNullable(_$LectureTypeEnumMap, json['type']) ??
          LectureType.lecture,
      isStarred: json['isStarred'] as bool ?? false,
      isLiked: json['isLiked'] as bool ?? false);
}

Map<String, dynamic> _$LectureDataToJson(LectureData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': _$LectureTypeEnumMap[instance.type],
      'speakerIds': instance.speakerIds?.toList(),
      'description': instance.description,
      'locationId': instance.locationId,
      'sectionId': instance.sectionId,
      'startTime': instance.startTime.toIso8601String(),
      'duration': instance.duration,
      'lang': _$LanguageTypeEnumMap[instance.lang],
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

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$LanguageTypeEnumMap = <LanguageType, dynamic>{
  LanguageType.ru: 'ru',
  LanguageType.en: 'en'
};

const _$LectureTypeEnumMap = <LectureType, dynamic>{
  LectureType.lecture: 'lecture',
  LectureType.custom: 'custom',
  LectureType.wrike: 'wrike'
};
