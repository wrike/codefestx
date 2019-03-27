import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/models/talk_post.dart';
import 'package:codefest/src/redux/actions/authorize_action.dart';
import 'package:codefest/src/redux/actions/change_lecture_favorite_action.dart';
import 'package:codefest/src/redux/actions/change_lecture_like_action.dart';
import 'package:codefest/src/redux/actions/change_search_mode_action.dart';
import 'package:codefest/src/redux/actions/change_selected_sections_action.dart';
import 'package:codefest/src/redux/actions/filter_lectures_action.dart';
import 'package:codefest/src/redux/actions/load_data_error_action.dart';
import 'package:codefest/src/redux/actions/load_data_start_action.dart';
import 'package:codefest/src/redux/actions/load_data_success_action.dart';
import 'package:codefest/src/redux/actions/load_talks_action.dart';
import 'package:codefest/src/redux/actions/load_user_data_success_action.dart';
import 'package:codefest/src/redux/actions/loaded_talks_action.dart';
import 'package:codefest/src/redux/actions/new_version_action.dart';
import 'package:codefest/src/redux/actions/search_lectures_action.dart';
import 'package:codefest/src/redux/actions/set_scroll_top_action.dart';
import 'package:codefest/src/redux/state/codefest_state.dart';
import 'package:redux/redux.dart';

class CodefestReducer {
  Reducer<CodefestState> _reducer;

  CodefestReducer() {
    _reducer = combineReducers<CodefestState>([
      TypedReducer<CodefestState, LoadDataStartAction>(_onStartLoading),
      TypedReducer<CodefestState, LoadDataSuccessAction>(_onLoadData),
      TypedReducer<CodefestState, LoadUserDataSuccessAction>(_onLoadUserData),
      TypedReducer<CodefestState, LoadDataErrorAction>(_onError),
      TypedReducer<CodefestState, AuthorizeAction>(_onAuthorize),
      TypedReducer<CodefestState, SearchLecturesAction>(_onSearchLectures),
      TypedReducer<CodefestState, ChangeSelectedSectionsAction>(_onChangeSelectedSections),
      TypedReducer<CodefestState, FilterLecturesAction>(_onFilterLectures),
      TypedReducer<CodefestState, ChangeSearchModeAction>(_onChangeSearchMode),
      TypedReducer<CodefestState, ChangeLectureLikeAction>(_onChangeLectureLike),
      TypedReducer<CodefestState, ChangeLectureFavoriteAction>(_onChangeLectureFavorite),
      TypedReducer<CodefestState, NewVersionAction>(_onNewVersion),
      TypedReducer<CodefestState, SetScrollTopAction>(_setScrollTopAction),
      TypedReducer<CodefestState, LoadTalksAction>(_resetTalkPosts),
      TypedReducer<CodefestState, LoadedTalksAction>(_loadedTalkPosts),
    ]);
  }

  CodefestState getState(CodefestState state, Object action) => _reducer(state, action);

  CodefestState _onAuthorize(CodefestState state, AuthorizeAction action) => state.rebuild((b) {
        final user = state.user.rebuild((b) {
          b.isAuthorized = true;
        });

        b.user.replace(user);
      });

  CodefestState _onChangeLectureFavorite(CodefestState state, ChangeLectureFavoriteAction action) => state.rebuild((b) {
        b.user.replace(state.user.rebuild((b) {
          if (action.isFavorite) {
            b.favoriteLectureIds.add(action.lectureId);
          } else {
            b.favoriteLectureIds.remove(action.lectureId);
          }
        }));
      });

  CodefestState _onChangeLectureLike(CodefestState state, ChangeLectureLikeAction action) => state.rebuild((b) {
        b.user.replace(state.user.rebuild((b) {
          if (action.isLiked) {
            b.likedLectureIds.add(action.lectureId);
          } else {
            b.likedLectureIds.remove(action.lectureId);
          }
        }));
      });

  CodefestState _onChangeSearchMode(CodefestState state, ChangeSearchModeAction action) => state.rebuild((b) {
        final user = state.user.rebuild((b) {
          b.isSearchMode = action.isSearchMode;

          if (!action.isSearchMode) {
            b.searchText = '';
          }
        });

        b.user.replace(user);
      });

  CodefestState _onChangeSelectedSections(CodefestState state, ChangeSelectedSectionsAction action) =>
      state.rebuild((b) {
        final user = state.user.rebuild((b) {
          b.selectedSectionIds.replace(action.sectionIds);
          b.isCustomSectionMode = action.isCustomSectionMode;
        });

        b.user.replace(user);
      });

  CodefestState _onError(CodefestState state, LoadDataErrorAction action) => state.rebuild((b) => b.isError = true);

  CodefestState _onFilterLectures(CodefestState state, FilterLecturesAction action) => state.rebuild((b) {
        final user = state.user.rebuild((b) {
          b.filterType = action.filterType;
          b.filterSectionId = action.filterSectionId;
        });

        b.user.replace(user);
      });

  CodefestState _onLoadData(CodefestState state, LoadDataSuccessAction action) => state.rebuild(
        (b) => b
          ..isReady = true
          ..isLoaded = true
          ..speakers.replace(action.speakers)
          ..locations.replace(action.locations)
          ..sections.replace(action.sections)
          ..lectures.replace(
            action.lectures.map(
              (lecture) => Lecture(
                    id: lecture.id,
                    title: lecture.title,
                    type: lecture.type,
                    language: lecture.lang,
                    description: lecture.description,
                    startTime: DateTime.fromMillisecondsSinceEpoch(lecture.startTime, isUtc: true),
                    duration: lecture.duration,
                    location: action.locations.firstWhere((location) => location.id == lecture.locationId),
                    section: action.sections.firstWhere((section) => section.id == lecture.sectionId),
                    speakers: action.speakers.where((speaker) => lecture.speakerIds.contains(speaker.id)).toList(),
                    isFavorite: lecture.isFavorite,
                    isLiked: lecture.isLiked,
                    likesCount: lecture.likesCount,
                    favoritesCount: lecture.favoritesCount,
                  ),
            ),
          ),
      );

  CodefestState _onLoadUserData(CodefestState state, LoadUserDataSuccessAction action) =>
      state.rebuild(
        (b) => b
          ..user.replace(state.user.rebuild((u) => u
              ..favoriteLectureIds.replace(action.favoriteLectureIds)
              ..selectedSectionIds.replace(action.selectedSectionIds)
              ..likedLectureIds.replace(action.likedLectureIds ?? [])
              ..displayName = action.displayName ?? ''
              ..avatarPath = action.avatarPath ?? ''
              ..isCustomSectionMode = action.isCustomSectionMode
          )));

  CodefestState _onNewVersion(CodefestState state, NewVersionAction action) =>
      state.rebuild((b) => b.releaseNote = action.releaseNote);

  CodefestState _onSearchLectures(CodefestState state, SearchLecturesAction action) =>
      state.rebuild((b) => b.user.update((u) => u.searchText = action.searchText));

  CodefestState _onStartLoading(CodefestState state, LoadDataStartAction action) =>
      state.rebuild((b) => b.isReady = false);

  CodefestState _setScrollTopAction(CodefestState state, SetScrollTopAction action) => state.rebuild((b) {
        b.scrollTop = action.scrollTop;
      });

  CodefestState _resetTalkPosts(CodefestState state, LoadTalksAction action) => state.rebuild((b) {
      if (state.currentLecture != action.lectureId) {
        b.talkPosts.replace([]);
      }
      b.currentLecture = action.lectureId;
  });

  CodefestState _loadedTalkPosts(CodefestState state, LoadedTalksAction action) => state.rebuild((b) {
    final posts = action.posts.map((p) {
      if (p.replyId != null) {
        final replyPost = action.posts.firstWhere((x) => x.id == p.replyId, orElse: () => null);
        if (replyPost != null) {
          p.replyText = replyPost.text;
          p.replyName = replyPost.authorName;
        } else {
          p.replyName = 'Неизвестный автор';
          p.replyText = 'Пост удален :(';
        }
      }
      return p;
    });
    b.talkPosts.replace(posts);
  });

}
