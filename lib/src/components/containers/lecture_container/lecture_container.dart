import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/containers/lecture_container/popularity_icon/popularity_icon.dart';
import 'package:codefest/src/components/containers/stateful_component.dart';
import 'package:codefest/src/components/layout/layout.dart';
import 'package:codefest/src/components/loader/loader.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/components/ui/tabs/tabs.dart';
import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/redux/actions/change_lecture_favorite_action.dart';
import 'package:codefest/src/redux/actions/change_lecture_like_action.dart';
import 'package:codefest/src/redux/actions/init_action.dart';
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
    LayoutComponent,
    LoaderComponent,
    ButtonComponent,
    TabsComponent,
    PopularityIconComponent,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class LectureContainerComponent extends StatefulComponent implements OnInit {
  final Selectors _selectors;
  final Dispatcher _dispatcher;
  final Router _router;

  bool _isActivated = false;

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

  bool get canLikeLecture => _selectors.canLikeLecture(lecture);

  String get endTime => _selectors.getEndTime(lecture);

  bool get isAuthorized => _selectors.isAuthorized(state);

  bool get isFavorite => _selectors.isFavoriteLecture(state, lecture);

  bool get isLectureAvailable => lecture != null;

  bool get isLiked => _selectors.isLikedLecture(state, lecture);

  bool get isLoaded => _selectors.isLoaded(state);

  bool get isReady => _selectors.isReady(state) && _isActivated && isLectureAvailable;

  Lecture get lecture => _selectors.getLecture(state, _parameters[idParam]);

  String get startTime => _selectors.getStartTime(lecture);

  @override
  void ngOnInit() {
    _dispatcher.dispatch(InitAction());
  }

  void onFavoriteClick() {
    _dispatcher.dispatch(ChangeLectureFavoriteAction(lectureId: lecture.id, isFavorite: !isFavorite));
  }

  void onLikeClick() {
    if (!isAuthorized) {
      _router.navigateByUrl(RoutePaths.login.toUrl());
    } else if (canLikeLecture) {
      _dispatcher.dispatch(ChangeLectureLikeAction(lectureId: lecture.id, isLiked: !isLiked));
    }
  }

  @override
  void onStateChange(CodefestState state) {
    _processAvailability();
  }

  void _onRouteActivated(RouterState state) {
    _isActivated = true;
    _parameters = state.parameters;
    _processAvailability();

    detectChanges();
  }

  void _processAvailability() {
    if (isLoaded && !isLectureAvailable) {
      _router.navigateByUrl(RoutePaths.empty.toUrl());
    }
  }
}
