import 'package:codefest/src/models/lecture_data.dart';
import 'package:codefest/src/models/location.dart';
import 'package:codefest/src/models/section.dart';
import 'package:codefest/src/models/speaker.dart';
import 'package:meta/meta.dart';

class LoadDataSuccessAction {
  final Iterable<LectureData> lectures;
  final Iterable<Location> locations;
  final Iterable<Section> sections;
  final Iterable<Speaker> speakers;

  LoadDataSuccessAction({
    @required this.lectures,
    @required this.locations,
    @required this.sections,
    @required this.speakers,
  });
}
