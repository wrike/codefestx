import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/models/location.dart';

class CodefestState {
  final Iterable<Lecture> lectures;
  final Iterable<Location> locations;

  CodefestState(this.lectures, this.locations);
}
