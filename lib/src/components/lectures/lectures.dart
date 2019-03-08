import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/route_component.dart';
import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/route_paths.dart';
import 'package:codefest/src/routes.dart';
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
class LecturesComponent extends RouteComponent {
  final Router _router;

  LecturesComponent(
    NgZone zone,
    ChangeDetectorRef cdr,
    StoreFactory storeFactory,
    this._router,
  ) : super(zone, cdr, storeFactory);

  Iterable<Lecture> get lectures => state.lectures;

  void handleLectureClick(Lecture lecture) {}

  void onSelectLecture(Lecture lecture) => _gotoDetail(lecture.id);

  String _lectureUrl(String id) => RoutePaths.lecture.toUrl(parameters: {idParam: '$id'});

  Future<NavigationResult> _gotoDetail(String id) => _router.navigate(_lectureUrl(id));
}
