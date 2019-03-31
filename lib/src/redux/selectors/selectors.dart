import 'package:codefest/src/models/_types.dart';
import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/models/section.dart';
import 'package:codefest/src/models/talk_post.dart';
import 'package:codefest/src/redux/state/codefest_state.dart';
import 'package:codefest/src/redux/state/user_state.dart';
import 'package:reselect/reselect.dart';

class Selectors {
  Selector<CodefestState, Iterable<Section>> getSelectedSections;

  Selector<CodefestState, Iterable<Section>> getMainSections;

  Selector<CodefestState, Iterable<Lecture>> getVisibleLectures;

  Selector<CodefestState, List<List<List<Lecture>>>> getGroupedVisibleLectures;

  Selector<CodefestState, Iterable<Lecture>> getFilteredLectures;

  Selector<CodefestState, Iterable<Lecture>> getRatingSortedLectures;

  Selector<CodefestState, String> getNearestLectureId;

  Selectors() {
    getMainSections = createSelector1(
      getSections,
      _getMainSections,
    );

    getSelectedSections = createSelector2(
      getSections,
      getSelectedSectionIds,
      _getSelectedSections,
    );

    getFilteredLectures = createSelector3(
      getLectures,
      getFavoriteLectureIds,
      getFilterType,
      _getFilteredLectures,
    );

    getVisibleLectures = createSelector7(
      getLectures,
      getFilteredLectures,
      getSelectedSectionIds,
      getSearchMode,
      getSearchText,
      getCustomSectionMode,
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

    getNearestLectureId = createSelector1(
      getVisibleLectures,
      _getNearestLectureId,
    );
  }

  DateTime getCurrentTimeZoneDate(DateTime date) => date.add(Duration(hours: 7));

  bool getCustomSectionMode(CodefestState state) => getUser(state).isCustomSectionMode;

  DateTime getDateNow() => DateTime.now().toUtc();

  DateTime getEndTime(Lecture lecture) => lecture.startTime.add(Duration(minutes: lecture.duration));

  String getEndTimeText(Lecture lecture) => _getTimeText(getEndTime(lecture));

  Iterable<String> getFavoriteLectureIds(CodefestState state) => getUser(state).favoriteLectureIds;

  FilterTypeEnum getFilterType(CodefestState state) => getUser(state).filterType;

  String getFlag(Lecture lecture) => lecture.language == LanguageType.en ? '🇬🇧󠁧󠁢󠁥󠁮󠁧󠁿' : '🇷🇺';

  Lecture getLecture(CodefestState state, String lectureId) => getLectures(state).firstWhere(
        (lecture) => lecture.id == lectureId,
        orElse: () => null,
      );

  Iterable<Lecture> getLectures(CodefestState state) => state.lectures;

  Iterable<String> getLikedLectureIds(CodefestState state) => getUser(state).likedLectureIds;

  bool getSearchMode(CodefestState state) => getUser(state).isSearchMode;

  String getSearchText(CodefestState state) => getUser(state).searchText;

  Iterable<Section> getSections(CodefestState state) => state.sections;

  Iterable<String> getSelectedSectionIds(CodefestState state) => getUser(state).selectedSectionIds;

  String getStartTimeText(Lecture lecture) => _getTimeText(lecture.startTime);

  String getDateText(Lecture lecture) => _getDateText(lecture.startTime);

  UserState getUser(CodefestState state) => state.user;

  String getUserAvatarPath(CodefestState state) => getUser(state).avatarPath;

  String getUserName(CodefestState state) => getUser(state).displayName;

  bool isAuthorized(CodefestState state) => getUser(state).isAuthorized;

  bool isError(CodefestState state) => state.isError;

  bool isFavoriteLecture(CodefestState state, Lecture lecture) => getFavoriteLectureIds(state).contains(lecture.id);

  bool isLectureStarted(Lecture lecture) => lecture.startTime.isBefore(getDateNow().add(Duration(minutes: 10)));

  bool isLikableLecture(Lecture lecture) => lecture.type == LectureType.lecture;

  bool isLikedLecture(CodefestState state, Lecture lecture) => getLikedLectureIds(state).contains(lecture.id);

  bool isLoaded(CodefestState state) => state.isLoaded;

  bool isReady(CodefestState state) => state.isReady;

  bool isSearchMode(CodefestState state) => getUser(state).isSearchMode;

  bool isSectionSelected(CodefestState state, String sectionId) => getSelectedSectionIds(state).contains(sectionId);

  bool isUpdateAvailable(CodefestState state) => state.releaseNote.isNotEmpty;

  String releaseNote(CodefestState state) => state.releaseNote;

  bool _fieldsContainsText(Iterable<String> fields, String text) =>
      fields.any((field) => field?.toLowerCase()?.contains(text) ?? false);

  String _formatMinutes(String minutes) => minutes.length == 1 ? '${minutes}0' : minutes;

  Iterable<Lecture> _getCustomSectionLectures(Iterable<Lecture> lectures) =>
      lectures.where((lecture) => lecture.section.isCustom).toList();

  Iterable<Lecture> _getFavoriteLectures(Iterable<Lecture> lectures, Iterable<String> favoriteLectureIds) =>
      lectures.where((lecture) => favoriteLectureIds.contains(lecture.id)).toList();

  Iterable<Lecture> _getFilteredLectures(
    Iterable<Lecture> lectures,
    Iterable<String> favoriteLectureIds,
    FilterTypeEnum filterType,
  ) {
    switch (filterType) {
      case FilterTypeEnum.favorite:
        return _getFavoriteLectures(lectures, favoriteLectureIds);
      case FilterTypeEnum.custom:
        return _getCustomSectionLectures(lectures);
      case FilterTypeEnum.now:
        return _getNowLectures(lectures);
      default:
        return lectures;
    }
  }

  List<List<List<Lecture>>> _getGroupedVisibleLectures(Iterable<Lecture> lectures) {
    final groupedByTime = _groupBy(lectures.toList(), (last, next) {
      return last.startTime == next.startTime && last.duration == next.duration;
    });

    final groupedByDay = _groupBy(groupedByTime, (last, next) {
      return last.last.startTime.day == next.last.startTime.day;
    });

    return groupedByDay;
  }

  Iterable<String> _getLectureFullSearchFields(Lecture lecture) => [lecture.title, lecture.description]
    ..addAll(lecture.speakers.expand((speaker) => [speaker.name, speaker.description, speaker.company]))
    ..addAll([lecture.location.title, lecture.location.description]);

  Iterable<String> _getLectureShortSearchFields(Lecture lecture) =>
      [lecture.title]..addAll(lecture.speakers.expand((speaker) => [speaker.name, speaker.company]));

  Iterable<Section> _getMainSections(Iterable<Section> sections) =>
      sections.where((section) => !section.isCustom).toList();

  String _getNearestLectureId(Iterable<Lecture> lectures) {
    var id;
    var prev;

    final now = getDateNow();

    for (final lecture in lectures) {
      final startTime = lecture.startTime;

      if (now.isAfter(startTime) && startTime != prev) {
        id = lecture.id;
      }

      prev = startTime;
    }

    return id;
  }

  Iterable<Lecture> _getNowLectures(Iterable<Lecture> lectures) {
    final now = getDateNow();
    return lectures.where((lecture) {
      final endTime = getEndTime(lecture);
      return now.isAfter(lecture.startTime) && now.isBefore(endTime);
    }).toList();
  }

  Iterable<Lecture> _getRatingSortedLectures(Iterable<Lecture> lectures) =>
      lectures.where((lecture) => lecture.likesCount > 3).toList()
        ..sort((lecture1, lecture2) => lecture1.likesCount < lecture2.likesCount ? 1 : -1);

  Iterable<Section> _getSelectedSections(Iterable<Section> sections, Iterable<String> sectionIds) =>
      sections.where((section) => sectionIds.contains(section.id) && !section.isCustom);

  String _getTimeText(DateTime date) {
    final currentTimeZoneDate = getCurrentTimeZoneDate(date);
    return '${currentTimeZoneDate.hour}:${_formatMinutes(currentTimeZoneDate.minute.toString())}';
  }

  String _getDateText(DateTime date) {
    final currentTimeZoneDate = getCurrentTimeZoneDate(date);

    return '${currentTimeZoneDate.day} марта';
  }

  Iterable<Lecture> _getVisibleLectures(
    Iterable<Lecture> allLectures,
    Iterable<Lecture> filteredLectures,
    Iterable<String> sectionIds,
    bool isSearchMode,
    String searchText,
    bool isCustomSectionMode,
    FilterTypeEnum filterType,
  ) {
    if (isSearchMode) {
      if (searchText == '') {
        return const [];
      }

      var result = allLectures.where((lecture) {
        final fields = _getLectureShortSearchFields(lecture);
        return _fieldsContainsText(fields, searchText.toLowerCase());
      }).toList();

      if (result.isEmpty) {
        result = allLectures.where((lecture) {
          final fields = _getLectureFullSearchFields(lecture);
          return _fieldsContainsText(fields, searchText.toLowerCase());
        }).toList();
      }

      return result;
    }

    if (filterType != FilterTypeEnum.all) {
      return filteredLectures.toList();
    }

    if (sectionIds.isEmpty) {
      return allLectures
          .where((lecture) => !lecture.section.isCustom || isCustomSectionMode && lecture.section.isCustom)
          .toList();
    }

    return allLectures
        .where((lecture) => sectionIds.contains(lecture.section.id) || isCustomSectionMode && lecture.section.isCustom)
        .toList();
  }

  List<TalkPost> getPosts(CodefestState state) => state.talkPosts.toList(growable: false);

  List<List<T>> _groupBy<T>(List<T> list, Function expression) => list.isEmpty
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
        });
}
