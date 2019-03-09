import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/layout/layout.dart';
import 'package:codefest/src/components/layout/menu_item.dart';
import 'package:codefest/src/components/lectures/actions/actions.dart';
import 'package:codefest/src/components/stateful_component.dart';
import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/route_paths.dart';
import 'package:codefest/src/routes.dart';
import 'package:codefest/src/services/store_factory.dart';

@Component(
  selector: 'lectures',
  styleUrls: ['lectures.css'],
  templateUrl: 'lectures.html',
  directives: [
    NgIf,
    NgFor,
    MaterialButtonComponent,
    MaterialIconComponent,
    routerDirectives,
    LayoutComponent,
    ActionsComponent,
  ],
  providers: [],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
  exports: [MenuItem],
)
class LecturesComponent extends StatefulComponent {
  final Router _router;

  LecturesComponent(
    NgZone zone,
    ChangeDetectorRef cdr,
    StoreFactory storeFactory,
    this._router,
  ) : super(zone, cdr, storeFactory);

  Iterable<Lecture> get lectures => state.lectures;

  String getEndTime(Lecture lecture) {
    final endTime = lecture.startTime.add(new Duration(minutes: lecture.duration));
    return _getTime(endTime);
  }

  String getStartTime(Lecture lecture) => _getTime(lecture.startTime);

  void onLectureSelect(Lecture lecture) => _gotoDetail(lecture.id);

  String _getTime(DateTime date) => '${date.hour}:${date.minute}';

  Future<NavigationResult> _gotoDetail(String id) => _router.navigate(_lectureUrl(id));

  String _lectureUrl(String id) => RoutePaths.lecture.toUrl(parameters: {idParam: '$id'});
}
