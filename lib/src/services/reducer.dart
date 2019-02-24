import 'package:codefest/src/actions/load_program_action.dart';
import 'package:codefest/src/models/codefest_state.dart';
import 'package:redux/redux.dart';

class CodefestReducer {
  Reducer<CodefestState> _reducer;

  CodefestReducer() {
    _reducer = combineReducers<CodefestState>([
      TypedReducer<CodefestState, LoadProgramAction>(_onLoadProgram),
    ]);
  }

  CodefestState getState(CodefestState state, Object action) =>
      _reducer(state, action);

  CodefestState _onLoadProgram(CodefestState state, LoadProgramAction action) =>
      state;
}
