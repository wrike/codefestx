// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Section _$SectionFromJson(Map<String, dynamic> json) {
  return Section(
      id: json['id'] as String,
      title: json['title'] as String,
      iconPath: json['iconPath'] as String,
      color: json['color'] as String,
      description: json['description'] as String);
}

Map<String, dynamic> _$SectionToJson(Section instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'iconPath': instance.iconPath,
      'color': instance.color,
      'description': instance.description
    };
