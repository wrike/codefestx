import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'user.g.dart';

@JsonSerializable(nullable: false)
class User {
  final String displayName;
  final Iterable<String> likedLecturesIds;
  final Iterable<String> favoriteLecturesIds;
  final Iterable<String> sectionIds;
  final String avatar;
  final bool isCustomSectionMode;

  User({
    @required this.displayName,
    @required this.likedLecturesIds,
    @required this.favoriteLecturesIds,
    @required this.sectionIds,
    @required this.avatar,
    @required this.isCustomSectionMode,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
