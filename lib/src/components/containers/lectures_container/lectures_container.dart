import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/containers/lectures_container/actions/actions.dart';
import 'package:codefest/src/components/containers/lectures_container/favorite_empty_state/favorite_empty_state.dart';
import 'package:codefest/src/components/containers/lectures_container/layout_actions/layout_actions.dart';
import 'package:codefest/src/components/containers/stateful_component.dart';
import 'package:codefest/src/components/layout/layout.dart';
import 'package:codefest/src/components/loader/loader.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/models/section.dart';
import 'package:codefest/src/redux/actions/change_lecture_favorite_action.dart';
import 'package:codefest/src/redux/actions/change_search_mode_action.dart';
import 'package:codefest/src/redux/actions/filter_lectures_action.dart';
import 'package:codefest/src/redux/actions/init_action.dart';
import 'package:codefest/src/redux/actions/search_lectures_action.dart';
import 'package:codefest/src/redux/selectors/selectors.dart';
import 'package:codefest/src/redux/services/dispatcher.dart';
import 'package:codefest/src/redux/services/store_factory.dart';
import 'package:codefest/src/redux/state/user_state.dart';
import 'package:codefest/src/route_paths.dart';

@Component(
  selector: 'lectures-container',
  styleUrls: ['lectures_container.css'],
  templateUrl: 'lectures_container.html',
  directives: [
    NgIf,
    NgFor,
    MaterialButtonComponent,
    MaterialIconComponent,
    LayoutComponent,
    ActionsComponent,
    LayoutActionsComponent,
    LoaderComponent,
    ButtonComponent,
    FavoriteEmptyStateComponent,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class LecturesContainerComponent extends StatefulComponent implements OnInit {
  final Dispatcher _dispatcher;
  final Router _router;
  final Selectors _selectors;

  final _now = DateTime.now().toUtc();

  LecturesContainerComponent(
    NgZone zone,
    ChangeDetectorRef cdr,
    StoreFactory storeFactory,
    this._dispatcher,
    this._router,
    this._selectors,
  ) : super(zone, cdr, storeFactory);

  bool get isAllSelected => _selectors.getFilterType(state) == FilterTypeEnum.all;

  bool get isFavoriteSelected => _selectors.getFilterType(state) == FilterTypeEnum.favorite;

  bool get isReady => _selectors.isReady(state);

  bool get isSearchMode => _selectors.isSearchMode(state);

  Iterable<Lecture> get lectures => _selectors.getVisibleLectures(state);

  String get searchText => _selectors.getSearchText(state);

  Iterable<Section> get sections => _selectors.getSelectedFilterSections(state);

  String endTime(Lecture lecture) => _selectors.getEndTimeText(lecture);

  String flag(Lecture lecture) => _selectors.getFlag(lecture);

  String getDay(DateTime date) {
    if (date.day == 30) {
      return '30 Марта';
    } else if (date.day == 31) {
      return '31 Марта';
    }

    return '';
  }

  bool isDayVisible(Lecture next, int index) {
    final prev = index > 0 ? lectures.elementAt(index - 1) : null;
    return prev == null || next.startTime.day != prev.startTime.day;
  }

  bool isFavoriteLecture(Lecture lecture) => _selectors.isFavoriteLecture(state, lecture);

  bool isFinished(Lecture lecture) {
    final endTime = _selectors.getEndTime(lecture);
    return _now.isAfter(endTime);
  }

  bool isRightNow(Lecture lecture) {
    final endTime = _selectors.getEndTime(lecture);
    return _now.isAfter(lecture.startTime) && _now.isBefore(endTime);
  }

  bool isSectionSelected(Section section) => _selectors.getFilterSectionId(state) == section.id;

  bool isTimeVisible(Lecture next, int index) {
    final prev = index > 0 ? lectures.elementAt(index - 1) : null;
    return prev == null || next.startTime != prev.startTime || next.duration != prev.duration;
  }

  @override
  void ngOnInit() {
    _dispatcher.dispatch(InitAction());
  }

  void onFavoriteChange(Lecture lecture, bool value) {
    _dispatcher.dispatch(ChangeLectureFavoriteAction(lectureId: lecture.id, isFavorite: value));
  }

  void onFilter() {
    _router.navigateByUrl(RoutePaths.sections.toUrl());
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
    _dispatcher.dispatch(ChangeSearchModeAction(isSearchMode: isSearchMode));
  }

  void onShowAllClick() {
    _dispatcher.dispatch(FilterLecturesAction(filterType: FilterTypeEnum.all));
  }

  void onShowFavoriteClick() {
    _dispatcher.dispatch(FilterLecturesAction(filterType: FilterTypeEnum.favorite));
  }

  void onShowSectionClick(Section section) {
    _dispatcher.dispatch(FilterLecturesAction(filterType: FilterTypeEnum.section, filterSectionId: section.id));
  }

  String startTime(Lecture lecture) => _selectors.getStartTimeText(lecture);
}
