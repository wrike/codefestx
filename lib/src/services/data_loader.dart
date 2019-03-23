import 'package:codefest/src/models/lecture_data.dart';
import 'package:codefest/src/models/location.dart';
import 'package:codefest/src/models/section.dart';
import 'package:codefest/src/models/speaker.dart';
import 'package:codefest/src/services/http_proxy.dart';

class DataLoader {
  static const _speakersPath = 'speakers';
  static const _locationsPath = 'locations';
  static const _sectionsPath = 'sections';
  static const _lecturesPath = 'lectures';
  static const _lecturesLikePath = '${_lecturesPath}/like';

  final HttpProxy _http;

  DataLoader(this._http);

  Future<Null> addLecturesLike(String lectureId) => _http.post(_lecturesLikePath, {
        'lectureId': lectureId,
        'action': 'true',
      });

  Future<Iterable<LectureData>> getLectures() =>
      _http.getList<LectureData>(_lecturesPath, (json) => LectureData.fromJson(json));

  Future<Iterable<Location>> getLocations() =>
      _http.getList<Location>(_locationsPath, (json) => Location.fromJson(json));

  Future<Iterable<Section>> getSections() => _http.getList<Section>(_sectionsPath, (json) => Section.fromJson(json));

  Future<Iterable<Speaker>> getSpeakers() => _http.getList<Speaker>(_speakersPath, (json) => Speaker.fromJson(json));
}
