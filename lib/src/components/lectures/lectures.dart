import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/actions/init_action.dart';
import 'package:codefest/src/components/route_component.dart';
import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/route_paths.dart';
import 'package:codefest/src/routes.dart';
import 'package:codefest/src/services/dispather.dart';
import 'package:codefest/src/services/store_factory.dart';

@Component(
  selector: 'lectures',
  styleUrls: ['lectures.css'],
  templateUrl: 'lectures.html',
  directives: [
    NgFor,
    routerDirectives,
  ],
  providers: [],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
  exports: [RoutePaths, Routes],
)
class LecturesComponent extends RouteComponent implements OnInit {
  final Router _router;
  final Dispatcher _dispatcher;

  LecturesComponent(
    NgZone zone,
    ChangeDetectorRef cdr,
    StoreFactory storeFactory,
    this._router, this._dispatcher,
  ) : super(zone, cdr, storeFactory);

  Iterable<Lecture> get lectures => state.lectures;

  void handleLectureClick(Lecture lecture) {}

  void onSelectLecture(Lecture lecture) => _gotoDetail(lecture.id);

  String _lectureUrl(String id) => RoutePaths.lecture.toUrl(parameters: {idParam: '$id'});

  Future<NavigationResult> _gotoDetail(String id) => _router.navigate(_lectureUrl(id));

  @override
  void ngOnInit() {
    _dispatcher.dispatch(InitAction());
  }
}
