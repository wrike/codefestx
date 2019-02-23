import 'package:codefest/src/models/location.dart';
import 'package:codefest/src/models/speaker.dart';
import 'package:meta/meta.dart';

class Lecture {
  final String title;
  final Iterable<Speaker> speakers;
  final String description;
  final Location location;
  final DateTime startTime;

  Lecture({
    @required this.title,
    @required this.speakers,
    @required this.description,
    @required this.location,
    @required this.startTime,
  });
}
