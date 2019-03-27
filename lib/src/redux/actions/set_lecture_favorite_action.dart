import 'package:meta/meta.dart';

class SetLectureFavoriteAction {
  final String lectureId;
  final bool isFavorite;

  SetLectureFavoriteAction({
    @required this.lectureId,
    @required this.isFavorite,
  });
}
