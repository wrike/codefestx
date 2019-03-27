import 'package:codefest/src/models/lecture_data.dart';
import 'package:meta/meta.dart';

class LoadLecturesDataAction {
  final Iterable<LectureData> lectures;

  LoadLecturesDataAction({
    @required this.lectures,
  });
}
