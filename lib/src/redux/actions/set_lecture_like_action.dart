import 'package:meta/meta.dart';

class SetLectureLikeAction {
  final String lectureId;
  final bool isLiked;

  SetLectureLikeAction({
    @required this.lectureId,
    @required this.isLiked,
  });
}
