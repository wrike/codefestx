import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/redux/actions/actions.dart';
import 'package:codefest/src/redux/state/codefest_state.dart';
import 'package:redux/redux.dart';

class CodefestReducer {
  Reducer<CodefestState> _reducer;

  CodefestReducer() {
    _reducer = combineReducers<CodefestState>([
      TypedReducer<CodefestState, LoadDataStartAction>(_onStartLoading),
      TypedReducer<CodefestState, LoadDataSuccessAction>(_onLoadDataSuccess),
      TypedReducer<CodefestState, LoadDataErrorAction>(_onLoadDataError),
      TypedReducer<CodefestState, SetDataAction>(_onSetData),
      TypedReducer<CodefestState, SetUserDataAction>(_onSetUserData),
      TypedReducer<CodefestState, AuthorizeAction>(_onAuthorize),
      TypedReducer<CodefestState, SearchLecturesAction>(_onSearchLectures),
      TypedReducer<CodefestState, SetSelectedSectionsAction>(_onSetSelectedSections),
      TypedReducer<CodefestState, FilterLecturesAction>(_onFilterLectures),
      TypedReducer<CodefestState, SetSearchModeAction>(_onSetSearchMode),
      TypedReducer<CodefestState, SetLectureLikeAction>(_onSetLectureLike),
      TypedReducer<CodefestState, SetLectureFavoriteAction>(_onSetLectureFavorite),
      TypedReducer<CodefestState, NewVersionAction>(_onNewVersion),
      TypedReducer<CodefestState, SetScrollTopAction>(_setScrollTopAction),
    ]);
  }

  CodefestState getState(CodefestState state, Object action) => _reducer(state, action);

  CodefestState _onAuthorize(CodefestState state, AuthorizeAction action) => state.rebuild((b) {
        final user = state.user.rebuild((b) {
          b.isAuthorized = true;
        });

        b.user.replace(user);
      });

  CodefestState _onFilterLectures(CodefestState state, FilterLecturesAction action) => state.rebuild((b) {
        final user = state.user.rebuild((b) {
          b.filterType = action.filterType;
        });

        b.user.replace(user);
      });

  CodefestState _onLoadDataError(CodefestState state, LoadDataErrorAction action) => state.rebuild(
        (b) => b.isError = true,
      );

  CodefestState _onLoadDataSuccess(CodefestState state, LoadDataSuccessAction action) => state.rebuild(
        (b) => b
          ..isReady = true
          ..isLoaded = true,
      );

  CodefestState _onNewVersion(CodefestState state, NewVersionAction action) => state.rebuild(
        (b) => b.releaseNote = action.releaseNote,
      );

  CodefestState _onSearchLectures(CodefestState state, SearchLecturesAction action) => state.rebuild(
        (b) => b.user.update((u) => u.searchText = action.searchText),
      );

  CodefestState _onSetData(CodefestState state, SetDataAction action) => state.rebuild(
        (b) => b
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

  CodefestState _onSetLectureFavorite(CodefestState state, SetLectureFavoriteAction action) => state.rebuild((b) {
        b.user.replace(state.user.rebuild((b) {
          if (action.isFavorite) {
            b.favoriteLectureIds.add(action.lectureId);
          } else {
            b.favoriteLectureIds.remove(action.lectureId);
          }
        }));
      });

  CodefestState _onSetLectureLike(CodefestState state, SetLectureLikeAction action) => state.rebuild((b) {
        b.user.replace(state.user.rebuild((b) {
          if (action.isLiked) {
            b.likedLectureIds.add(action.lectureId);
          } else {
            b.likedLectureIds.remove(action.lectureId);
          }
        }));
      });

  CodefestState _onSetSearchMode(CodefestState state, SetSearchModeAction action) => state.rebuild((b) {
        final user = state.user.rebuild((b) {
          b.isSearchMode = action.isSearchMode;

          if (!action.isSearchMode) {
            b.searchText = '';
          }
        });

        b.user.replace(user);
      });

  CodefestState _onSetSelectedSections(CodefestState state, SetSelectedSectionsAction action) => state.rebuild((b) {
        final user = state.user.rebuild((b) {
          b.selectedSectionIds.replace(action.sectionIds);
          b.isCustomSectionMode = action.isCustomSectionMode;
        });

        b.user.replace(user);
      });

  CodefestState _onSetUserData(CodefestState state, SetUserDataAction action) => state.rebuild((b) => b
    ..user.replace(state.user.rebuild((u) => u
      ..favoriteLectureIds.replace(action.favoriteLectureIds)
      ..selectedSectionIds.replace(action.selectedSectionIds)
      ..likedLectureIds.replace(action.likedLectureIds ?? state.user.likedLectureIds)
      ..displayName = action.displayName ?? state.user.displayName
      ..avatarPath = action.avatarPath ?? state.user.avatarPath
      ..isCustomSectionMode = action.isCustomSectionMode ?? state.user.isCustomSectionMode)));

  CodefestState _onStartLoading(CodefestState state, LoadDataStartAction action) =>
      state.rebuild((b) => b.isReady = false);

  CodefestState _setScrollTopAction(CodefestState state, SetScrollTopAction action) => state.rebuild((b) {
        b.scrollTop = action.scrollTop;
      });
}
