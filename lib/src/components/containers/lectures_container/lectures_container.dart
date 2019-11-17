import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/containers/lectures_container/actions/actions.dart';
import 'package:codefest/src/components/containers/lectures_container/favorite_empty_state/favorite_empty_state.dart';
import 'package:codefest/src/components/containers/lectures_container/filters/filters.dart';
import 'package:codefest/src/components/containers/lectures_container/layout_actions/layout_actions.dart';
import 'package:codefest/src/components/containers/lectures_container/now_empty_state/now_empty_state.dart';
import 'package:codefest/src/components/containers/lectures_container/search_empty_state/search_empty_state.dart';
import 'package:codefest/src/components/containers/stateful_component.dart';
import 'package:codefest/src/components/layout/layout.dart';
import 'package:codefest/src/components/loader/loader.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/models/_types.dart';
import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/redux/actions/effects/init_action.dart';
import 'package:codefest/src/redux/actions/effects/scroll_to_current_time_action.dart';
import 'package:codefest/src/redux/actions/effects/update_lecture_favorite_action.dart';
import 'package:codefest/src/redux/actions/search_lectures_action.dart';
import 'package:codefest/src/redux/actions/set_search_mode_action.dart';
import 'package:codefest/src/redux/selectors/selectors.dart';
import 'package:codefest/src/redux/services/dispatcher.dart';
import 'package:codefest/src/redux/services/store_factory.dart';
import 'package:codefest/src/redux/state/user_state.dart';
import 'package:codefest/src/route_paths.dart';
import 'package:codefest/src/services/intl_service.dart';

@Component(
  selector: 'lectures-container',
  styleUrls: ['lectures_container.css'],
  templateUrl: 'lectures_container.html',
  directives: [
    NgIf,
    NgFor,
    LayoutComponent,
    ActionsComponent,
    LayoutActionsComponent,
    LoaderComponent,
    ButtonComponent,
    FavoriteEmptyStateComponent,
    NowEmptyStateComponent,
    SearchEmptyStateComponent,
    FiltersComponent,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class LecturesContainerComponent extends StatefulComponent implements OnInit {
  final Dispatcher _dispatcher;
  final Router _router;
  final Selectors _selectors;

  LecturesContainerComponent(
    NgZone zone,
    ChangeDetectorRef cdr,
    StoreFactory storeFactory,
    this._dispatcher,
    this._router,
    this._selectors,
  ) : super(zone, cdr, storeFactory);

  List<List<List<Lecture>>> get groupedLectures => _selectors.getGroupedVisibleLectures(state);

  bool get isFavoriteEmptyStateVisible => lectures.isEmpty && isFavoriteSelected && !isSearchMode;

  bool get isFavoriteSelected => _selectors.getFilterType(state) == FilterTypeEnum.favorite;

  bool get isFiltersVisible => _selectors.isLoaded(state) && !isSearchMode;

  bool get isNowEmptyStateVisible => lectures.isEmpty && isNowSelected && !isSearchMode;

  bool get isNowSelected => _selectors.getFilterType(state) == FilterTypeEnum.now;

  bool get isReady => _selectors.isReady(state);

  bool get isSearchEmptyStateVisible => lectures.isEmpty && isSearchMode && searchText.isNotEmpty;

  bool get isSearchMode => _selectors.isSearchMode(state);

  Iterable<Lecture> get lectures => _selectors.getVisibleLectures(state);

  String get nearestLectureId => _selectors.getNearestLectureId(state);

  DateTime get now => _selectors.getDateNow();

  String get searchText => _selectors.getSearchText(state);

  int get maxPopularity => state.maxFavorites;

  String get title => IntlService.scheduleRoute();

  String currentTimeId(Lecture lecture) => isNearestLectureGroup(lecture) ? 'currentTime' : null;

  String endTime(Lecture lecture) => _selectors.getEndTimeText(lecture);

  String flag(Lecture lecture) => _selectors.getFlag(lecture);

  String getLang(Lecture lecture) => lecture.language == LanguageType.en ? 'en' : 'ru';

  String getDay(Iterable<Iterable<Lecture>> grouped) {
    final lecture = grouped.isNotEmpty ? grouped.first.isNotEmpty ? grouped.first.first : null : null;

    if (lecture == null) {
      return '';
    }

    return '23 November';
  }

  String getFigure(int number) => '#figure-${number}';

  bool isFavoriteLecture(Lecture lecture) => _selectors.isFavoriteLecture(state, lecture);

  bool isFinished(Lecture lecture) {
    final endTime = _selectors.getEndTime(lecture);
    return now.isAfter(endTime);
  }

  bool isNearestLectureGroup(lecture) => lecture.id == nearestLectureId;

  bool isRightNow(Lecture lecture) {
    final endTime = _selectors.getEndTime(lecture);
    return now.isAfter(lecture.startTime) && now.isBefore(endTime);
  }

  bool isWrikeEvent(Lecture lecture) => lecture.type == LectureType.wrike;

  @override
  void ngOnInit() {
    _dispatcher.dispatch(InitAction());

    if (state.isLoaded && state.scrollTop == 0) {
      _dispatcher.dispatch(ScrollToCurrentTimeAction());
    }
  }

  void onFavoriteChange(Lecture lecture, bool value) {
    _dispatcher.dispatch(UpdateLectureFavoriteAction(lectureId: lecture.id, isFavorite: value));
  }

  void onLectureSelect(Lecture lecture) {
    final url = RoutePaths.lecture.toUrl(
      parameters: {idParam: lecture.id},
    );

    _router.navigate(url);
  }

  void onSearch(String searchText) {
    _dispatcher.dispatch(SearchLecturesAction(searchText: searchText));
  }

  void onSearchModeChange(bool isSearchMode) {
    _dispatcher.dispatch(SetSearchModeAction(isSearchMode: isSearchMode));
  }

  String startTime(Lecture lecture) => _selectors.getStartTimeText(lecture);

  dynamic trackByIdentity(int index, dynamic item) => item;
}
