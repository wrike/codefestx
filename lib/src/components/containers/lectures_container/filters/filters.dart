import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/models/section.dart';
import 'package:codefest/src/redux/actions/actions.dart';
import 'package:codefest/src/redux/actions/effects/actions.dart';
import 'package:codefest/src/redux/selectors/selectors.dart';
import 'package:codefest/src/redux/services/dispatcher.dart';
import 'package:codefest/src/redux/state/codefest_state.dart';
import 'package:codefest/src/redux/state/user_state.dart';
import 'package:codefest/src/route_paths.dart';
import 'package:codefest/src/services/intl_service.dart';

@Component(
  selector: 'filters',
  styleUrls: ['filters.css'],
  templateUrl: 'filters.html',
  directives: [
    NgIf,
    ButtonComponent,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FiltersComponent implements OnInit {
  final Selectors _selectors;
  final Router _router;
  final Dispatcher _dispatcher;

  @Input()
  CodefestState state;

  @Input()
  bool isCustomFiltersAvailable = false;

  @Input()
  bool isFavoritesFiltersAvailable = true;

  @Input()
  bool isEventsFiltersAvailable = false;

  @Input()
  bool isLiveFiltersAvailable = true;

  FiltersComponent(
    this._selectors,
    this._router,
    this._dispatcher,
  );

  @override
  void ngOnInit() {
    _dartSectionId = state.sections.firstWhere((s) => s.title == 'Dart')?.id;
    _flutterSectionId = state.sections.firstWhere((s) => s.title == 'Flutter')?.id;
  }

  String _dartSectionId = '';

  String _flutterSectionId = '';

  bool get isAllSelected => _selectors.getFilterType(state) == FilterTypeEnum.all;

  bool get isAll => _selectors.getFilterType(state) == FilterTypeEnum.all && _selectors.getIsNoFilters(state);

  bool get isFavoriteSelected => _selectors.getFilterType(state) == FilterTypeEnum.favorite;

  bool get isCustomSelected => _selectors.getFilterType(state) == FilterTypeEnum.custom;

  bool get isNowSelected => _selectors.getFilterType(state) == FilterTypeEnum.now;

  bool get isDartSelected => _selectors.isSectionSelected(state, _dartSectionId);

  bool get isFlutterSelected => _selectors.isSectionSelected(state, _flutterSectionId);

  String get filterTitle {
    if (_filtersCount == 1) {
      return '1 filter';
    } else if (_filtersCount > 1) {
      return '${_filtersCount} filters';
    } else {
      return allTitle;
    }
  }

  Iterable<Section> get sections => _selectors.getSelectedSections(state);

  int get _filtersCount => sections.length + _selectors.getSelectedLanguages(state).length;

  void onFilter() {
    _router.navigateByUrl(RoutePaths.sections.toUrl());
  }

  void onShowAllClick() {
    _dispatcher.dispatch(FilterLecturesAction(filterType: FilterTypeEnum.all));
    _dispatcher.dispatch(ScrollToCurrentTimeAction());
  }

  void onShowFavoriteClick() {
    _dispatcher.dispatch(FilterLecturesAction(filterType: FilterTypeEnum.favorite));
    _dispatcher.dispatch(ScrollToCurrentTimeAction());
  }

  void onShowCustomClick() {
    _dispatcher.dispatch(FilterLecturesAction(filterType: FilterTypeEnum.custom));
    _dispatcher.dispatch(ScrollToCurrentTimeAction());
  }

  void onShowNowClick() {
    _dispatcher.dispatch(FilterLecturesAction(filterType: FilterTypeEnum.now));
  }

  void onAllClick() {
    _dispatcher.dispatch(UpdateSelectedSectionsAction(
      sectionIds: [],
      languages: [],
      isCustomSectionMode: true,
    ));
    _dispatcher.dispatch(FilterLecturesAction(filterType: FilterTypeEnum.all));
    _dispatcher.dispatch(ScrollToCurrentTimeAction());
  }

  void onDartClick() {
    _dispatcher.dispatch(UpdateSelectedSectionsAction(
      sectionIds: [_dartSectionId],
      languages: [],
      isCustomSectionMode: true,
    ));
    _dispatcher.dispatch(FilterLecturesAction(filterType: FilterTypeEnum.all));
    _dispatcher.dispatch(ScrollToCurrentTimeAction());
  }

  void onFlutterClick() {
    _dispatcher.dispatch(UpdateSelectedSectionsAction(
      sectionIds: [_flutterSectionId],
      languages: [],
      isCustomSectionMode: true,
    ));
    _dispatcher.dispatch(FilterLecturesAction(filterType: FilterTypeEnum.all));
    _dispatcher.dispatch(ScrollToCurrentTimeAction());
  }

  /// I18n
  String get allTitle => IntlService.allFilter();

  String get favoritesTitle => IntlService.favoritesFilter();

  String get eventsTitle => IntlService.customEventsFilter();

  String get liveTitle => IntlService.liveFilter();
}
