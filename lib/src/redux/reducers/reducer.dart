import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/redux/actions/change_search_mode_action.dart';
import 'package:codefest/src/redux/actions/change_selected_sections_action.dart';
import 'package:codefest/src/redux/actions/filter_lectures_action.dart';
import 'package:codefest/src/redux/actions/load_data_error_action.dart';
import 'package:codefest/src/redux/actions/load_program_start_action.dart';
import 'package:codefest/src/redux/actions/load_program_success_action.dart';
import 'package:codefest/src/redux/actions/search_lectures_action.dart';
import 'package:codefest/src/redux/state/codefest_state.dart';
import 'package:redux/redux.dart';

class CodefestReducer {
  Reducer<CodefestState> _reducer;

  CodefestReducer() {
    _reducer = combineReducers<CodefestState>([
      TypedReducer<CodefestState, LoadProgramStartAction>(_onStartLoading),
      TypedReducer<CodefestState, LoadProgramSuccessAction>(_onLoadProgram),
      TypedReducer<CodefestState, LoadDataErrorAction>(_onError),
      TypedReducer<CodefestState, SearchLecturesAction>(_onSearchLectures),
      TypedReducer<CodefestState, ChangeSelectedSectionsAction>(_onChangeSelectedSections),
      TypedReducer<CodefestState, FilterLecturesAction>(_onFilterLectures),
      TypedReducer<CodefestState, ChangeSearchModeAction>(_onChangeSearchMode),
    ]);
  }

  CodefestState getState(CodefestState state, Object action) => _reducer(state, action);

  CodefestState _onChangeSearchMode(CodefestState state, ChangeSearchModeAction action) {
    return state.rebuild((b) {
      final user = b.user.build().rebuild((b) {
        b.isSearchMode = action.isSearchMode;

        if (!action.isSearchMode) {
          b.searchText = '';
        }
      });

      b.user.replace(user);
    });
  }

  CodefestState _onChangeSelectedSections(CodefestState state, ChangeSelectedSectionsAction action) {
    return state.rebuild((b) {
      final user = b.user.build().rebuild((b) {
        b.selectedSectionIds.replace(action.sectionIds);
      });

      b.user.replace(user);
    });
  }

  CodefestState _onError(CodefestState state, LoadDataErrorAction action) => state.rebuild((b) => b.isError = true);

  CodefestState _onFilterLectures(CodefestState state, FilterLecturesAction action) {
    return state.rebuild((b) {
      final user = b.user.build().rebuild((b) {
        b.filterType = action.filterType;
        b.filterSectionId = action.filterSectionId;
      });

      b.user.replace(user);
    });
  }

  CodefestState _onLoadProgram(CodefestState state, LoadProgramSuccessAction action) => state.rebuild((b) => b
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
              startTime: lecture.startTime,
              duration: lecture.duration,
              location: action.locations.firstWhere((location) => location.id == lecture.locationId),
              section: action.sections.firstWhere((section) => section.id == lecture.sectionId),
              speakers: action.speakers.where((speaker) => lecture.speakerIds.contains(speaker.id)),
              isFavorite: lecture.isFavorite,
              isLiked: lecture.isLiked,
              likesCount: lecture.likesCount,
              favoritesCount: lecture.favoritesCount,
            ),
      ),
    ));

  CodefestState _onSearchLectures(CodefestState state, SearchLecturesAction action) {
    return state.rebuild((b) {
      final user = b.user.build().rebuild((b) {
        b.searchText = action.searchText;
      });

      b.user.replace(user);
    });
  }

  CodefestState _onStartLoading(CodefestState state, LoadProgramStartAction action) =>
      state.rebuild((b) => b.isReady = false);
}
