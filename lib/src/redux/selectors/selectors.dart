import 'package:codefest/src/models/_types.dart';
import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/models/section.dart';
import 'package:codefest/src/redux/state/codefest_state.dart';
import 'package:codefest/src/redux/state/user_state.dart';
import 'package:reselect/reselect.dart';

class Selectors {
  Selector<CodefestState, Iterable<Section>> getSelectedSections;

  Selector<CodefestState, Iterable<Lecture>> getVisibleLectures;

  Selector<CodefestState, Iterable<Lecture>> getFilterLectures;

  Selector<CodefestState, Iterable<Lecture>> getRatingLectures;

  Selectors() {
    getSelectedSections = createSelector2(
      getSections,
      getSelectedSectionIds,
      _getSelectedSections,
    );

    getFilterLectures = createSelector3(
      getLectures,
      getUser,
      getFilterType,
      _getFilterLectures,
    );

    getVisibleLectures = createSelector3(
      getFilterLectures,
      getSelectedSectionIds,
      getSearchText,
      _getVisibleLectures,
    );

    getRatingLectures = createSelector1(
      getLectures,
      _getRatingLectures,
    );
  }

  Iterable<Lecture> _getRatingLectures(Iterable<Lecture> lectures) {
    final result = lectures.toList();
    return result..sort((lecture1, lecture2) => lecture1.isLiked && !lecture2.isLiked ? 1 : -1);
  }

  String getEndTime(Lecture lecture) {
    final endTime = lecture.startTime.add(new Duration(minutes: lecture.duration));
    return _getTime(endTime);
  }

  String getFilterSectionId(CodefestState state) {
    final user = getUser(state);

    if (user.filterType == FilterTypeEnum.section) {
      return user.filterSectionId;
    }

    return null;
  }

  FilterTypeEnum getFilterType(CodefestState state) => getUser(state).filterType;

  String getFlag(Lecture lecture) => lecture.language == LanguageType.en ? '🇬🇧󠁧󠁢󠁥󠁮󠁧󠁿' : '🇷🇺';

  Lecture getLecture(CodefestState state, String lectureId) =>
    getVisibleLectures(state).firstWhere((lecture) => lecture.id == lectureId, orElse: () => null);

  Iterable<Lecture> getLectures(CodefestState state) => state.lectures;

  String getSearchText(CodefestState state) => getUser(state).searchText;

  Iterable<Section> getSections(CodefestState state) => state.sections;

  int getSelectedSectionCount(CodefestState state) => getSelectedSectionIds(state).length;

  Iterable<String> getSelectedSectionIds(CodefestState state) => getUser(state).selectedSectionIds;

  String getStartTime(Lecture lecture) => _getTime(lecture.startTime);

  UserState getUser(CodefestState state) => state.user;

  bool isError(CodefestState state) => state.isError;

  bool isReady(CodefestState state) => state.isReady;

  bool isAuthorized(CodefestState state) => getUser(state).isAuthorized;

  bool isSearchMode(CodefestState state) => getUser(state).isSearchMode;

  bool isSectionSelected(CodefestState state, String sectionId) => getSelectedSectionIds(state).contains(sectionId);

  bool _fieldsContainsText(Iterable<String> fields, String text) {
    for (final field in fields) {
      if (field != null && field.toLowerCase().contains(text.toLowerCase())) {
        return true;
      }
    }

    return false;
  }

  String _formatHours(String hours) => hours.length == 1 ? '${hours}0' : hours;

  Iterable<Lecture> _getFavoriteLectures(Iterable<Lecture> lectures) =>
      lectures.where((lectures) => lectures.isFavorite).toList();

  Iterable<Lecture> _getFilterLectures(Iterable<Lecture> lectures, UserState user, FilterTypeEnum filterType) {
    switch (filterType) {
      case FilterTypeEnum.favorite:
        return _getFavoriteLectures(lectures);
      case FilterTypeEnum.section:
        return _getSectionLectures(lectures, user.filterSectionId);
      default:
        return lectures;
    }
  }

  Iterable<String> _getLectureSearchFields(Lecture lecture) =>
    [lecture.title, lecture.description]
      ..addAll(lecture.speakers.expand((speaker) => [speaker.name, speaker.description, speaker.company]))
      ..addAll([lecture.location.title, lecture.location.description]);

  Iterable<Lecture> _getSectionLectures(Iterable<Lecture> lectures, String sectionId) =>
    lectures.where((lecture) => lecture.section.id == sectionId);

  Iterable<Section> _getSelectedSections(Iterable<Section> sections, Iterable<String> sectionIds) =>
    sections.where((section) => sectionIds.contains(section.id));

  String _getTime(DateTime date) => '${date.hour}:${_formatHours(date.minute.toString())}';

  Iterable<Lecture> _getVisibleLectures(Iterable<Lecture> lectures, Iterable<String> sectionIds, String searchText) {
    Iterable<Lecture> result = lectures;

    if (sectionIds.isNotEmpty) {
      result = result.where((lecture) => sectionIds.contains(lecture.section.id)).toList();
    }

    if (searchText != null && searchText.isNotEmpty) {
      result = result.where((lecture) {
        final fields = _getLectureSearchFields(lecture);

        if (_fieldsContainsText(fields, searchText)) {
          return true;
        }

        return false;
      }).toList();
    }

    return result;
  }
}
