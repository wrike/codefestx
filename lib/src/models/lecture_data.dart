import 'package:meta/meta.dart';

class LectureData {
  final String id;
  final String title;
  final Iterable<String> speakerIds;
  final String description;
  final String locationId;
  final DateTime startTime;
  final int duration;

  LectureData({
    @required this.id,
    @required this.title,
    @required this.speakerIds,
    @required this.description,
    @required this.locationId,
    @required this.startTime,
    @required this.duration,
  });
}
