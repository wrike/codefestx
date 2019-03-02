import 'dart:convert';

import 'package:codefest/src/models/lecture_data.dart';
import 'package:codefest/src/models/lecture_type.dart';
import 'package:codefest/src/models/location.dart';
import 'package:codefest/src/models/speaker.dart';
import 'package:http/http.dart';

class DataLoader {
  static final _speakersPath = 'speakers';
  static final _locationsPath = 'locations';
  static final _lecturesPath = 'lectures';
  final Client _http;

  DataLoader(this._http);

  dynamic _extractData(Response resp) => json.decode(resp.body)['data'];

  Future<Iterable<Speaker>> getSpeakers() async {
    final response = await _http.get(_speakersPath);
    return (_extractData(response) as List).map((json) => Speaker.fromJson(json)).toList();
  }

  Future<Iterable<Location>> getLocations() async {
    final response = await _http.get(_locationsPath);
    return (_extractData(response) as List).map((json) => Location.fromJson(json)).toList();
  }

  Future<Iterable<LectureData>> getLectures() async {
    final response = await _http.get(_lecturesPath);
    return (_extractData(response) as List).map((json) => LectureData.fromJson(json)).toList();
  }
}
