import 'package:codefest/src/models/_types.dart';
import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/models/section.dart';
import 'package:codefest/src/redux/state/codefest_state.dart';
import 'package:codefest/src/redux/state/user_state.dart';
import 'package:reselect/reselect.dart';

class Selectors {
  Selector<CodefestState, Iterable<Section>> getSelectedFilterSections;

  Selector<CodefestState, Iterable<Lecture>> getVisibleLectures;

  Selector<CodefestState, List<List<List<Lecture>>>> getGroupedVisibleLectures;

  Selector<CodefestState, Iterable<Lecture>> getFilterLectures;

  Selector<CodefestState, Iterable<Lecture>> getRatingSortedLectures;

  Selector<CodefestState, Iterable<String>> getSelectedMainSectionIds;

  Selector<CodefestState, Iterable<String>> getSelectedCustomSectionIds;

  Selectors() {
    getSelectedMainSectionIds = createSelector2(
      getSelectedSectionIds,
      getSections,
      _getFilterMainSectionIds,
    );
    getSelectedCustomSectionIds = createSelector2(
      getSelectedSectionIds,
      getSections,
      _getFilterCustomSectionIds,
    );

    getSelectedFilterSections = createSelector3(
      getSections,
      getSelectedMainSectionIds,
      getSelectedCustomSectionIds,
      _getSelectedFilterSections,
    );

    getFilterLectures = createSelector3(
      getLectures,
      getUser,
      getFilterType,
      _getFilterLectures,
    );

    getVisibleLectures = createSelector6(
      getLectures,
      getFilterLectures,
      getSelectedMainSectionIds,
      getSelectedCustomSectionIds,
      getSearchText,
      getFilterType,
      _getVisibleLectures,
    );

    getGroupedVisibleLectures = createSelector1(
      getVisibleLectures,
      _getGroupedVisibleLectures,
    );

    getRatingSortedLectures = createSelector1(
      getLectures,
      _getRatingSortedLectures,
    );
  }

  Iterable<Section> getCustomSections(CodefestState state) =>
      getSections(state).where((section) => section.isCustom).toList();

  DateTime getEndTime(Lecture lecture) => lecture.startTime.add(Duration(minutes: lecture.duration));

  String getEndTimeText(Lecture lecture) => _getTimeText(getEndTime(lecture));

  Iterable<String> getFavoriteLectureIds(CodefestState state) => getUser(state).favoriteLectureIds;

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

  Iterable<String> getLikedLectureIds(CodefestState state) => getUser(state).likedLectureIds;

  Iterable<Section> getMainSections(CodefestState state) =>
      getSections(state).where((section) => !section.isCustom).toList();

  String getSearchText(CodefestState state) => getUser(state).searchText;

  Iterable<Section> getSections(CodefestState state) => state.sections;

  int getSelectedSectionCount(CodefestState state) => getSelectedSectionIds(state).length;

  Iterable<String> getSelectedSectionIds(CodefestState state) => getUser(state).selectedSectionIds;

  String getStartTimeText(Lecture lecture) => _getTimeText(lecture.startTime);

  UserState getUser(CodefestState state) => state.user;

  String getUserAvatarPath(CodefestState state) => getUser(state).avatarPath;

  String getUserName(CodefestState state) => getUser(state).displayName;

  bool isAuthorized(CodefestState state) => getUser(state).isAuthorized;

  bool isError(CodefestState state) => state.isError;

  bool isFavoriteLecture(CodefestState state, Lecture lecture) => getFavoriteLectureIds(state).contains(lecture.id);

  bool isLikableLecture(Lecture lecture) => lecture.type == LectureType.lecture;

  bool isLikedLecture(CodefestState state, Lecture lecture) => getLikedLectureIds(state).contains(lecture.id);

  bool isLoaded(CodefestState state) => state.isLoaded;

  bool isReady(CodefestState state) => state.isReady;

  bool isSearchMode(CodefestState state) => getUser(state).isSearchMode;

  bool isSectionSelected(CodefestState state, String sectionId) => getSelectedSectionIds(state).contains(sectionId);

  bool isUpdateAvailable(CodefestState state) => state.releaseNote.isNotEmpty;

  bool lectureStarted(Lecture lecture) => lecture.startTime.isBefore(DateTime.now());

  String releaseNote(CodefestState state) => state.releaseNote;

  bool _fieldsContainsText(Iterable<String> fields, String text) =>
      fields.any((field) => field?.toLowerCase()?.contains(text) ?? false);

  String _formatHours(String hours) => hours.length == 1 ? '${hours}0' : hours;

  Iterable<Lecture> _getFavoriteLectures(Iterable<Lecture> lectures, UserState user) =>
      lectures.where((lecture) => user.favoriteLectureIds.contains(lecture.id)).toList();

  Iterable<Lecture> _getFilterLectures(Iterable<Lecture> lectures, UserState user, FilterTypeEnum filterType) {
    switch (filterType) {
      case FilterTypeEnum.favorite:
        return _getFavoriteLectures(lectures, user);
      case FilterTypeEnum.section:
        return _getSectionLectures(lectures, user.filterSectionId);
      default:
        return lectures;
    }
  }

  Iterable<String> _getFilterMainSectionIds(Iterable<String> selectedSectionIds, Iterable<Section> sections) {
    final sectionIds = sections.where((section) => !section.isCustom).map((section) => section.id);
    return selectedSectionIds.where(sectionIds.contains).toList();
  }

  Iterable<String> _getFilterCustomSectionIds(Iterable<String> selectedSectionIds, Iterable<Section> sections) {
    final sectionIds = sections.where((section) => section.isCustom).map((section) => section.id);
    return selectedSectionIds.where(sectionIds.contains).toList();
  }

  List<List<List<Lecture>>> _getGroupedVisibleLectures(Iterable<Lecture> lectures) {
    final group = _group(lectures.toList(), (last, next) {
      return last.startTime == next.startTime && last.duration == next.duration;
    });

    return _group(group, (last, next) {
      return last.last.startTime.day == next.last.startTime.day;
    });
  }

  Iterable<String> _getLectureShortSearchFields(Lecture lecture) => [lecture.title]
    ..addAll(lecture.speakers.expand((speaker) => [speaker.name, speaker.company]));

  Iterable<String> _getLectureFullSearchFields(Lecture lecture) => [lecture.title, lecture.description]
    ..addAll(lecture.speakers.expand((speaker) => [speaker.name, speaker.description, speaker.company]))
    ..addAll([lecture.location.title, lecture.location.description]);

  Iterable<Lecture> _getRatingSortedLectures(Iterable<Lecture> lectures) =>
      lectures.where((lecture) => lecture.likesCount > 3).toList()
        ..sort((lecture1, lecture2) => lecture1.likesCount < lecture2.likesCount ? 1 : -1);

  Iterable<Lecture> _getSectionLectures(Iterable<Lecture> lectures, String sectionId) =>
      lectures.where((lecture) => lecture.section.id == sectionId);

  Iterable<Section> _getSelectedFilterSections(
      Iterable<Section> sections, Iterable<String> mainSectionIds, Iterable<String> customSectionIds) {
    if (mainSectionIds.isEmpty && customSectionIds.isEmpty) {
      return sections;
    } else if (mainSectionIds.isEmpty) {
      return sections.where((section) => !section.isCustom || customSectionIds.contains(section.id));
    }

    final sectionIds = []..addAll(mainSectionIds)..addAll(customSectionIds);

    return sections.where((section) => sectionIds.contains(section.id));
  }

  String _getTimeText(DateTime date) => '${date.hour}:${_formatHours(date.minute.toString())}';

  Iterable<Lecture> _getVisibleLectures(
      Iterable<Lecture> allLectures,
      Iterable<Lecture> filteredLectures,
      Iterable<String> mainSectionIds,
      Iterable<String> customSectionIds,
      String searchText,
      FilterTypeEnum filterType,
  ) {
    Iterable<Lecture> result = [];

    if (searchText?.isNotEmpty ?? false) {
      result = allLectures.where((lecture) {
        final fields = _getLectureShortSearchFields(lecture);

        return _fieldsContainsText(fields, searchText.toLowerCase());
      }).toList();

      if (result.isEmpty) {
        result = allLectures.where((lecture) {
          final fields = _getLectureFullSearchFields(lecture);

          return _fieldsContainsText(fields, searchText.toLowerCase());
        }).toList();
      }
    } else {
      result = filteredLectures;

      if (filterType == FilterTypeEnum.favorite) {
        return result;
      }

      final sectionIds = []
        ..addAll(mainSectionIds)
        ..addAll(customSectionIds);

      if (mainSectionIds.isNotEmpty) {
        result = result
            .where((lecture) => sectionIds.contains(lecture.section.id))
            .toList();
      } else if (customSectionIds.isNotEmpty) {
        result = result
            .where((lecture) => !lecture.section.isCustom || customSectionIds.contains(lecture.section.id))
            .toList();
      }
    }

    return result;
  }

  List<List<T>> _group<T>(List<T> list, Function expression) => list.isEmpty
      ? [[]]
      : list.fold<List<List<T>>>([[]], (prev, next) {
          if (prev.last.isEmpty) {
            prev.last.add(next);
          } else {
            final last = prev.last.last;

            if (expression(last, next)) {
              prev.last.add(next);
            } else {
              prev.add([next]);
            }
          }

          return prev;
        }).toList();
}
