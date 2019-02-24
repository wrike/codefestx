import 'package:codefest/src/models/codefest_state.dart';
import 'package:codefest/src/services/reducer.dart';
import 'package:redux/redux.dart';

class StoreFactory {
  final CodefestReducer _reducer;

  StoreFactory(
    this._reducer,
  );

  Store<CodefestState> getStore(CodefestState initialState) {
    return Store(
      _reducer.getState,
      initialState: initialState,
      distinct: true,
    );
  }
}
