// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      displayName: json['displayName'] as String,
      likedLecturesIds:
          (json['likedLecturesIds'] as List).map((e) => e as String),
      favoriteLecturesIds:
          (json['favoriteLecturesIds'] as List).map((e) => e as String),
      sectionIds: (json['sectionIds'] as List).map((e) => e as String),
      avatar: json['avatar'] as String);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'displayName': instance.displayName,
      'likedLecturesIds': instance.likedLecturesIds.toList(),
      'favoriteLecturesIds': instance.favoriteLecturesIds.toList(),
      'sectionIds': instance.sectionIds.toList(),
      'avatar': instance.avatar
    };
