import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'auth.response.g.dart';

@JsonSerializable(nullable: false)
class AuthResponse {
  final String token;
  final String userName;
  final String userId;
  final String avatar;

  AuthResponse({
    @required this.token,
    this.userName,
    this.userId,
    this.avatar,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
