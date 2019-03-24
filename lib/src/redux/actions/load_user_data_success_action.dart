import 'package:meta/meta.dart';

class LoadUserDataSuccessAction {
  final Iterable<String> favoriteLectureIds;
  final Iterable<String> likedLectureIds;
  final Iterable<String> selectedSectionIds;

  LoadUserDataSuccessAction({
    @required this.favoriteLectureIds,
    @required this.selectedSectionIds,
    this.likedLectureIds,
  });
}
