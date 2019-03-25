// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Speaker _$SpeakerFromJson(Map<String, dynamic> json) {
  return Speaker(
      id: json['id'] as String,
      name: json['name'] as String,
      company: json['company'] as String,
      avatarPath: json['avatarPath'] as String,
      description: json['description'] as String);
}

Map<String, dynamic> _$SpeakerToJson(Speaker instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'company': instance.company,
      'avatarPath': instance.avatarPath,
      'description': instance.description
    };
