import 'package:meta/meta.dart';

class UpdateLectureFavoriteAction {
  final String lectureId;
  final bool isFavorite;

  UpdateLectureFavoriteAction({
    @required this.lectureId,
    @required this.isFavorite,
  });
}
