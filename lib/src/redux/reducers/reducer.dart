import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/redux/actions/load_data_error_action.dart';
import 'package:codefest/src/redux/actions/load_program_start_action.dart';
import 'package:codefest/src/redux/actions/load_program_success_action.dart';
import 'package:codefest/src/redux/actions/search_lectures_action.dart';
import 'package:codefest/src/redux/actions/toggle_section_action.dart';
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
      TypedReducer<CodefestState, ToggleSectionAction>(_onToggleSection),
    ]);
  }

  CodefestState getState(CodefestState state, Object action) => _reducer(state, action);

  CodefestState _onSearchLectures(CodefestState state, SearchLecturesAction action) {
    return state.rebuild((b) {
      final user = b.user.build().rebuild((b) {
        b.searchText = action.searchText;
      });

      b.user.replace(user);
    });
  }

  CodefestState _onToggleSection(CodefestState state, ToggleSectionAction action) {
    return state.rebuild((b) {
      final user = b.user.build().rebuild((b) {
        if (state.user.selectedSectionIds.contains(action.sectionId)) {
          b.selectedSectionIds.remove(action.sectionId);
        } else {
          b.selectedSectionIds.add(action.sectionId);
        }
      });

      b.user.replace(user);
    });
  }

  CodefestState _onError(CodefestState state, LoadDataErrorAction action) => state.rebuild((b) => b.isError = true);

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
              isStarred: lecture.isStarred,
              isLiked: lecture.isLiked,
            ),
      ),
    ));

  CodefestState _onStartLoading(CodefestState state, LoadProgramStartAction action) =>
      state.rebuild((b) => b.isReady = false);
}
