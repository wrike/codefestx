import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/containers/lecture_info/lecture_info.dart';
import 'package:codefest/src/components/containers/lecture_talk/lecture_talk.dart';
import 'package:codefest/src/components/containers/stateful_component.dart';
import 'package:codefest/src/components/layout/layout.dart';
import 'package:codefest/src/components/layout/navigation_type.dart';
import 'package:codefest/src/components/loader/loader.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/components/ui/popularity_icon/popularity_icon.dart';
import 'package:codefest/src/components/ui/tabs/tabs.dart';
import 'package:codefest/src/models/_types.dart';
import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/models/talk_post.dart';
import 'package:codefest/src/redux/actions/effects/init_action.dart';
import 'package:codefest/src/redux/actions/effects/update_lecture_favorite_action.dart';
import 'package:codefest/src/redux/actions/load_talks_action.dart';
import 'package:codefest/src/redux/selectors/selectors.dart';
import 'package:codefest/src/redux/services/dispatcher.dart';
import 'package:codefest/src/redux/services/store_factory.dart';
import 'package:codefest/src/redux/state/codefest_state.dart';
import 'package:codefest/src/route_paths.dart';
import 'package:codefest/src/routes.dart';
import 'package:codefest/src/services/dom_service.dart';

@Component(
  selector: 'lecture-container',
  styleUrls: ['lecture_container.css'],
  templateUrl: 'lecture_container.html',
  directives: [
    NgIf,
    NgFor,
    NgClass,
    LayoutComponent,
    LoaderComponent,
    ButtonComponent,
    TabsComponent,
    PopularityIconComponent,
    LectureInfoComponent,
    LectureTalkComponent,
  ],
  exports: [
    NavigationType,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class LectureContainerComponent extends StatefulComponent implements OnInit, OnDeactivate {
  static const WRIKE_EVENT_CLASSNAME = 'event';
  static final route = Routes.lecture;
  final Selectors _selectors;
  final Dispatcher _dispatcher;
  final Router _router;
  final DOMService _dom;

  bool _isActivated = false;
  bool _isTalksLoaded = false;
  bool isInfoMode = true;
  Map<String, String> _parameters = {};

  LectureContainerComponent(
    NgZone zone,
    ChangeDetectorRef cdr,
    StoreFactory storeFactory,
    this._router,
    this._selectors,
    this._dispatcher,
    this._dom,
  ) : super(zone, cdr, storeFactory) {
    zone.runOutsideAngular(() {
      subscriptions.addAll([
        _router.onRouteActivated.listen(_onRouteActivated),
      ]);
    });
  }

  String get title => !lecture.section.isCustom ? 'Talk' : 'Event';

  String getFigure(int number) => '#figure-${number}';

  String get endTime => _selectors.getEndTimeText(lecture);

  bool get isAuthorized => _selectors.isAuthorized(state);

  bool get isFavorite => _selectors.isFavoriteLecture(state, lecture);

  bool get isLectureAvailable => lecture != null;

  bool get isWrikeEvent => isLectureAvailable && lecture.type == LectureType.wrike;

  bool get isLikable => _selectors.isLikableLecture(lecture);

  bool get isLiked => _selectors.isLikedLecture(state, lecture);

  bool get isLoaded => _selectors.isLoaded(state);

  bool get isReady => _selectors.isReady(state) && _isActivated && isLectureAvailable;

  Lecture get lecture => _selectors.getLecture(state, _parameters[idParam]);

  List<TalkPost> get posts => _selectors.getPosts(state);

  @override
  void ngOnInit() {
    _dispatcher.dispatch(InitAction());
  }

  void onFavoriteClick() {
    _dispatcher.dispatch(UpdateLectureFavoriteAction(lectureId: lecture.id, isFavorite: !isFavorite));
  }

  void changeTab(bool newModeIsInfo) {
    isInfoMode = newModeIsInfo;
  }

  @override
  void onStateChange(CodefestState state) {
    _processLectureState();
  }

  void _onRouteActivated(RouterState state) {
    _isActivated = true;
    isInfoMode = true;
    _parameters = state.parameters;
    _processLectureState();
    detectChanges();
  }

  void _processLectureState() {
    if (!isLoaded) {
      return;
    }

    if (!isLectureAvailable) {
      _router.navigateByUrl(RoutePaths.empty.toUrl());
      return;
    }

    if (!_isTalksLoaded) {
      _dispatcher.dispatch(LoadTalksAction(lecture.id));
      _isTalksLoaded = true;
    }

    _dom.toggleDocumentClass(WRIKE_EVENT_CLASSNAME, isWrikeEvent);
  }

  @override
  void onDeactivate(prev, current) {
    if (!current.routes.contains(route)) {
      _dom.toggleDocumentClass(WRIKE_EVENT_CLASSNAME, false);
      _isActivated = false;
    }
  }
}
