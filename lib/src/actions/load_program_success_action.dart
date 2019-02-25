import 'package:codefest/src/models/lecture_data.dart';
import 'package:codefest/src/models/location.dart';
import 'package:codefest/src/models/speaker.dart';
import 'package:meta/meta.dart';

class LoadProgramSuccessAction {
  final Iterable<LectureData> lectures;
  final Iterable<Location> locations;
  final Iterable<Speaker> speakers;

  LoadProgramSuccessAction({
    @required this.lectures,
    @required this.locations,
    @required this.speakers,
  });
}
