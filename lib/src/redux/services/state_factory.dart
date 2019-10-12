import 'package:codefest/src/redux/state/codefest_state.dart';
import 'package:codefest/src/redux/state/user_state.dart';
import 'package:codefest/src/services/intl_service.dart';

class StateFactory {
  CodefestState getInitialState() => CodefestState(
        (b) => b
          ..isReady = false
          ..isLoaded = false
          ..isError = false
          ..releaseNote = ''
          ..scrollTop = 0
          ..maxFavorites = 10
          ..locale = IntlService.ruLang
          ..user.replace(
            UserState(
              (b) => b
                ..selectedSectionIds.replace([])
                ..likedLectureIds.replace([])
                ..favoriteLectureIds.replace([])
                ..isSearchMode = false
                ..searchText = ''
                ..filterType = FilterTypeEnum.all
                ..isAuthorized = false
                ..isCustomSectionMode = true,
            ),
          ),
      );
}
