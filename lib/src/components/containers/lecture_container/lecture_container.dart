import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/layout/layout.dart';
import 'package:codefest/src/components/containers/stateful_component.dart';
import 'package:codefest/src/components/loader/loader.dart';
import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/redux/actions/init_action.dart';
import 'package:codefest/src/redux/selectors/selectors.dart';
import 'package:codefest/src/redux/services/dispatcher.dart';
import 'package:codefest/src/redux/services/store_factory.dart';
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
        _router.onRouteActivated.listen((data) {
          _isActivated = true;
          _parameters = data.parameters;

          zone.run(cdr.markForCheck);
        }),
      ]);
    });
  }

  bool get isReady => _selectors.isReady(state) && _isActivated;

  bool get isAuthorized => _selectors.isAuthorized(state);

  Lecture get lecture => _parameters.isNotEmpty ? _selectors.getLecture(state, _parameters[idParam]) : null;

  String get startTime => _selectors.getStartTime(lecture);

  @override
  void ngOnInit() {
    _dispatcher.dispatch(InitAction());
  }

  void onLikeClick() {}

  void onStarClick() {}
}
