import 'package:codefest/src/redux/state/codefest_state.dart';
import 'package:codefest/src/redux/state/user_state.dart';

class StateFactory {
  CodefestState getInitialState() => CodefestState(
        (b) => b
          ..isReady = false
          ..isLoaded = false
          ..isError = false
          ..user.replace(
            UserState(
              (b) => b
                ..selectedSectionIds.replace([])
                ..isSearchMode = false
                ..filterType = FilterTypeEnum.all
                ..isAuthorized = false,
            ),
          ),
      );
}
