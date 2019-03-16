// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
      id: json['id'] as String,
      title: json['title'] as String,
      iconPath: json['iconPath'] as String,
      mapPath: json['mapPath'] as String,
      description: json['description'] as String);
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'iconPath': instance.iconPath,
      'mapPath': instance.mapPath,
      'description': instance.description
    };
