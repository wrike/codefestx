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
import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/models/talk_post.dart';
import 'package:codefest/src/redux/actions/change_lecture_favorite_action.dart';
import 'package:codefest/src/redux/actions/change_lecture_like_action.dart';
import 'package:codefest/src/redux/actions/init_action.dart';
import 'package:codefest/src/redux/actions/load_talks_action.dart';
import 'package:codefest/src/redux/selectors/selectors.dart';
import 'package:codefest/src/redux/services/dispatcher.dart';
import 'package:codefest/src/redux/services/store_factory.dart';
import 'package:codefest/src/redux/state/codefest_state.dart';
import 'package:codefest/src/route_paths.dart';

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
    NavigationType
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class LectureContainerComponent extends StatefulComponent implements OnInit {
  final Selectors _selectors;
  final Dispatcher _dispatcher;
  final Router _router;

  bool _isActivated = false;
  bool isInfoMode = true;
  Map<String, String> _parameters = {};

  LectureContainerComponent(
    NgZone zone,
    ChangeDetectorRef cdr,
    StoreFactory storeFactory,
    this._router,
    this._selectors,
    this._dispatcher,
  ) : super(zone, cdr, storeFactory) {
    zone.runOutsideAngular(() {
      subscriptions.addAll([
        _router.onRouteActivated.listen(_onRouteActivated),
      ]);
    });
  }

  bool get isAuthorized => _selectors.isAuthorized(state);

  bool get isFavorite => _selectors.isFavoriteLecture(state, lecture);

  bool get isLectureAvailable => lecture != null;

  bool get isLoaded => _selectors.isLoaded(state);

  bool get isReady => _selectors.isReady(state) && _isActivated && isLectureAvailable;

  Lecture get lecture => _selectors.getLecture(state, _parameters[idParam]);

  List<TalkPost> get posts => _selectors.getPosts(state);

  @override
  void ngOnInit() {
    _dispatcher.dispatch(InitAction());
  }

  void onFavoriteClick() {
    _dispatcher.dispatch(ChangeLectureFavoriteAction(lectureId: lecture.id, isFavorite: !isFavorite));
  }

  void changeTab(bool newModeIsInfo) {
    isInfoMode = newModeIsInfo;
  }

  @override
  void onStateChange(CodefestState state) {
    _processAvailability();
  }

  void _onRouteActivated(RouterState state) {
    _isActivated = true;
    isInfoMode = true;
    _parameters = state.parameters;
    _processAvailability();
    _dispatcher.dispatch(LoadTalksAction(lecture.id));
    detectChanges();
  }

  void _processAvailability() {
    if (isLoaded && !isLectureAvailable) {
      _router.navigateByUrl(RoutePaths.empty.toUrl());
    }
  }
}
