import 'package:codefest/src/models/api_response.dart';
import 'package:codefest/src/models/lecture_data.dart';
import 'package:codefest/src/models/location.dart';
import 'package:codefest/src/models/section.dart';
import 'package:codefest/src/models/speaker.dart';
import 'package:codefest/src/models/user.dart';
import 'package:codefest/src/services/http_proxy.dart';
import 'package:meta/meta.dart';

class DataLoader {
  static const _speakersPath = 'speakers';
  static const _locationsPath = 'locations';
  static const _sectionsPath = 'sections';
  static const _lecturesPath = 'lectures';
  static const _lecturesLikePath = '${_lecturesPath}/like';
  static const _lecturesFavoritePath = '${_lecturesPath}/favorite';
  static const _userPath = 'user';

  final HttpProxy _http;

  DataLoader(this._http);

  Future<Iterable<LectureData>> getLectures() =>
      _http.getList<LectureData>(_lecturesPath, (json) => LectureData.fromJson(json));

  Future<Iterable<Location>> getLocations() =>
      _http.getList<Location>(_locationsPath, (json) => Location.fromJson(json));

  Future<Iterable<Section>> getSections() => _http.getList<Section>(_sectionsPath, (json) => Section.fromJson(json));

  Future<Iterable<Speaker>> getSpeakers() => _http.getList<Speaker>(_speakersPath, (json) => Speaker.fromJson(json));

  Future<User> getUser() => _http.get<User>(_userPath, decoder: (json) => User.fromJson(json));

  Future<ApiResponse> updateLectureFavorite({
    @required String lectureId,
    @required bool value,
  }) =>
      _http.post(_lecturesFavoritePath, {
        'lectureId': lectureId,
        'action': value,
      });

  Future<ApiResponse> updateLectureLike({
    @required String lectureId,
    @required bool value,
  }) =>
      _http.post(_lecturesLikePath, {
        'lectureId': lectureId,
        'action': value,
      });

  Future<ApiResponse> updateUser({
    @required Iterable<String> sectionIds,
    @required Iterable<String> favoriteLectureIds,
  }) =>
      _http.put(_userPath, {
        'sectionIds': sectionIds,
        'favoriteIds': favoriteLectureIds,
      });
}
