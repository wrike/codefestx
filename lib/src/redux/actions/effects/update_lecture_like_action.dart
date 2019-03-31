import 'package:meta/meta.dart';

class UpdateLectureLikeAction {
  final String lectureId;
  final bool isLiked;

  UpdateLectureLikeAction({
    @required this.lectureId,
    @required this.isLiked,
  });
}
