// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) {
  return AuthResponse(
      token: json['token'] as String,
      userName: json['userName'] as String,
      userId: json['userId'] as String,
      avatar: json['avatar'] as String,
      favoriteLecturesIds:
          (json['favoriteLecturesIds'] as List).map((e) => e as String),
      likedLecturesIds:
          (json['likedLecturesIds'] as List).map((e) => e as String),
      sectionIds: (json['sectionIds'] as List).map((e) => e as String));
}

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'userName': instance.userName,
      'userId': instance.userId,
      'avatar': instance.avatar,
      'favoriteLecturesIds': instance.favoriteLecturesIds.toList(),
      'likedLecturesIds': instance.likedLecturesIds.toList(),
      'sectionIds': instance.sectionIds.toList()
    };
