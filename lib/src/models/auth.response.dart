import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'auth.response.g.dart';

@JsonSerializable(nullable: false)
class AuthResponse {
  final String token;
  final String userName;
  final String userId;
  final String avatar;
  final Iterable<String> favoriteLecturesIds;
  final Iterable<String> likedLecturesIds;
  final Iterable<String> sectionIds;

  AuthResponse({
    @required this.token,
    this.userName,
    this.userId,
    this.avatar,
    this.favoriteLecturesIds,
    this.likedLecturesIds,
    this.sectionIds,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
