import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/models/section.dart';
import 'package:codefest/src/redux/state/codefest_state.dart';
import 'package:codefest/src/redux/state/user_state.dart';
import 'package:reselect/reselect.dart';

Selector<CodefestState, Iterable<Lecture>> getVisibleLectures = createSelector2(
  getLecturesFromSelectedSections,
  getSearchText,
  _getLecturesBySearchText,
);

Selector<CodefestState, Iterable<Lecture>> getLecturesFromSelectedSections = createSelector2(
  getLectures,
  getSelectedSectionIds,
  _getLecturesBySectionIds,
);

Selector<CodefestState, Iterable<Section>> getSelectedSections = createSelector2(
  getSections,
  getSelectedSectionIds,
  _getSelectedSections,
);

Iterable<Lecture> getLectures(CodefestState state) => state.lectures;

String getSearchText(CodefestState state) => getUser(state).searchText;

Iterable<Section> getSections(CodefestState state) => state.sections;

Iterable<String> getSelectedSectionIds(CodefestState state) => getUser(state).selectedSectionIds;

UserState getUser(CodefestState state) => state.user;

Iterable<Lecture> _getLecturesBySearchText(Iterable<Lecture> lectures, String searchText) {
  if (searchText == null || searchText.isEmpty) {
    return lectures;
  }

  return lectures.where((lecture) {
    final data = <String>[];

    data
      ..addAll([lecture.title, lecture.description])
      ..addAll(lecture.speakers.expand((speaker) => [speaker.name, speaker.description, speaker.company]))
      ..addAll([lecture.location.title, lecture.location.description]);

    if (_isContainsSearchText(data, searchText)) {
      return true;
    }

    return false;
  }).toList();
}

Iterable<Lecture> _getLecturesBySectionIds(Iterable<Lecture> lectures, Iterable<String> sectionIds) {
  return sectionIds.isEmpty ? lectures : lectures.where((lecture) => sectionIds.contains(lecture.section.id));
}

Iterable<Section> _getSelectedSections(Iterable<Section> sections, Iterable<String> sectionIds) {
  return sections.where((section) => sectionIds.contains(section.id));
}

bool _isContainsSearchText(Iterable<String> strings, String searchText) {
  for (final string in strings) {
    if (string != null && string.toLowerCase().contains(searchText.toLowerCase())) {
      return true;
    }
  }

  return false;
}

class Selectors {
  bool isError(CodefestState state) => state.isError;

  bool isReady(CodefestState state) => state.isReady;
}
