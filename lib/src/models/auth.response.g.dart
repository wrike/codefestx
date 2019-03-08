// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) {
  return AuthResponse(
      token: json['token'] as String, userName: json['userName'] as String);
}

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{'token': instance.token, 'userName': instance.userName};
