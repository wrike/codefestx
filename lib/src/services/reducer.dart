import 'package:codefest/src/actions/change_location_action.dart';
import 'package:codefest/src/actions/load_program_success_action.dart';
import 'package:codefest/src/models/codefest_state.dart';
import 'package:codefest/src/models/lecture.dart';
import 'package:redux/redux.dart';

class CodefestReducer {
  Reducer<CodefestState> _reducer;

  CodefestReducer() {
    _reducer = combineReducers<CodefestState>([
      TypedReducer<CodefestState, LoadProgramSuccessAction>(_onLoadProgram),
      TypedReducer<CodefestState, ChangeLocationAction>(_onChangeLocation),
    ]);
  }

  CodefestState getState(CodefestState state, Object action) =>
      _reducer(state, action);

  CodefestState _onLoadProgram(CodefestState state, LoadProgramSuccessAction action) =>
      state.rebuild((b) => b
        ..isReady = true
        ..speakers.replace(action.speakers)
        ..locations.replace(action.locations)
        ..lectures.replace(action.lectures.map((lecture) =>
            Lecture(
              id: lecture.id,
              title: lecture.title,
              type: lecture.type,
              description: lecture.description,
              startTime: lecture.startTime,
              duration: lecture.duration,
              location: action.locations.firstWhere((location) => location.id == lecture.locationId),
              speakers: action.speakers.where((speaker) => lecture.speakerIds.contains(speaker.id)),
              isStarred: lecture.isStarred,
              isLiked: lecture.isLiked,
            ))));

  CodefestState _onChangeLocation(CodefestState state, ChangeLocationAction action) =>
      state.rebuild((b) => b.path = action.path);
}
