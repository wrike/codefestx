import 'dart:async';

import 'package:codefest/src/models/lecture_data.dart';
import 'package:codefest/src/services/http_proxy.dart';

class ScheduleChecker {
  static const _path = 'lectures?is_lite=true';

  final HttpProxy _http;

  ScheduleChecker(this._http);

  Future run(Timer t) async {
    print('eee');
    print(t.tick);

    final data = await _http.getList<LectureData>(_path, (json) => LectureData.fromJson(json));
    print(data);
  }
}