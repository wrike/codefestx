import 'package:meta/meta.dart';

class SetUserDataAction {
  final Iterable<String> favoriteLectureIds;
  final Iterable<String> selectedSectionIds;
  final Iterable<String> likedLectureIds;
  final String displayName;
  final String avatarPath;
  final bool isCustomSectionMode;

  SetUserDataAction({
    @required this.favoriteLectureIds,
    @required this.selectedSectionIds,
    this.likedLectureIds,
    this.displayName,
    this.avatarPath,
    this.isCustomSectionMode,
  });
}
