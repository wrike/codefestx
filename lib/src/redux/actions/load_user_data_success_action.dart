import 'package:meta/meta.dart';

class LoadUserDataSuccessAction {
  final Iterable<String> favoriteLectureIds;
  final Iterable<String> likedLectureIds;
  final Iterable<String> selectedSectionIds;
  final String displayName;
  final String avatarPath;
  final bool isCustomSectionMode;

  LoadUserDataSuccessAction({
    @required this.favoriteLectureIds,
    @required this.selectedSectionIds,
    this.likedLectureIds,
    this.displayName,
    this.avatarPath,
    this.isCustomSectionMode,
  });
}
