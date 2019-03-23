import 'package:meta/meta.dart';

class ChangeLectureFavoriteAction {
  final String lectureId;
  final bool isFavorite;

  ChangeLectureFavoriteAction({
    @required this.lectureId,
    @required this.isFavorite,
  });
}
