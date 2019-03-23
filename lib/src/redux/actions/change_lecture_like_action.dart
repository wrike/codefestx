import 'package:meta/meta.dart';

class ChangeLectureLikeAction {
  final String lectureId;
  final bool isLiked;

  ChangeLectureLikeAction({
    @required this.lectureId,
    @required this.isLiked,
  });
}
