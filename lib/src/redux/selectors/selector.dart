import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/redux/state/codefest_state.dart';

class Selector {
  bool isReady(CodefestState state) => state.isReady;

  bool isError(CodefestState state) => state.isError;
}

Iterable<Lecture> searchLectures(CodefestState state, String searchText) {
  if (searchText == null || searchText.isEmpty) {
    return state.lectures;
  }

  return state.lectures.where((lecture) {
    final data = <String>[];

    data
      ..addAll([lecture.title, lecture.description])
      ..addAll(lecture.speakers.expand((speaker) => [speaker.name, speaker.description, speaker.company]))
      ..addAll([lecture.location.title, lecture.location.description]);

    if (isContainsSearchText(data, searchText)) {
      return true;
    }

    return false;
  }).toList();
}

bool isContainsSearchText(Iterable<String> strings, String searchText) {
  for (final string in strings) {
    if (string != null && string.toLowerCase().contains(searchText.toLowerCase())) {
      return true;
    }
  }

  return false;
}
