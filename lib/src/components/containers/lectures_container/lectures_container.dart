import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/containers/lectures_container/actions/actions.dart';
import 'package:codefest/src/components/containers/lectures_container/layout_actions/layout_actions.dart';
import 'package:codefest/src/components/layout/layout.dart';
import 'package:codefest/src/components/stateful_component.dart';
import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/models/section.dart';
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

  bool get isFavoriteVisible => _selectors.getFilterType(state) == FilterTypeEnum.favorite;

  bool get isSearchMode => _selectors.isSearchMode(state);

  bool get isShowAllVisible => _selectors.getFilterType(state) == FilterTypeEnum.all;

  Iterable<Lecture> get lectures => _selectors.getVisibleLectures(state);

  String get searchText => _selectors.getSearchText(state);

  Iterable<Section> get sections => _selectors.getSelectedSections(state);

  String endTime(Lecture lecture) => _selectors.getEndTime(lecture);

  String flag(Lecture lecture) => _selectors.getFlag(lecture);

  bool isShowSectionVisible(Section section) => _selectors.getFilterSectionId(state) == section.id;

  @override
  void ngOnInit() {
    _dispatcher.dispatch(InitAction());
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
    _dispatcher.dispatch(new SearchLecturesAction(searchText: searchText));
  }

  void onSearchModeChange(bool isSearchMode) {
    _dispatcher.dispatch(new ChangeSearchModeAction(isSearchMode: isSearchMode));
  }

  void onShowAllClick() {
    _dispatcher.dispatch(new FilterLecturesAction(filterType: FilterTypeEnum.all));
  }

  void onShowFavoriteClick() {
    _dispatcher.dispatch(new FilterLecturesAction(filterType: FilterTypeEnum.favorite));
  }

  void onShowSectionClick(Section section) {
    _dispatcher.dispatch(new FilterLecturesAction(filterType: FilterTypeEnum.section, filterSectionId: section.id));
  }

  String startTime(Lecture lecture) => _selectors.getStartTime(lecture);
}
