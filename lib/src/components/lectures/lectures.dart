import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/actions/init_action.dart';
import 'package:codefest/src/components/layout/layout.dart';
import 'package:codefest/src/components/lectures/actions/actions.dart';
import 'package:codefest/src/components/stateful_component.dart';
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
    NgIf,
    NgFor,
    MaterialButtonComponent,
    MaterialIconComponent,
    LayoutComponent,
    ActionsComponent,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class LecturesComponent extends StatefulComponent implements OnInit {
  final Router _router;
  final Dispatcher _dispatcher;

  LecturesComponent(
    NgZone zone,
    ChangeDetectorRef cdr,
    StoreFactory storeFactory,
    this._router, this._dispatcher,
  ) : super(zone, cdr, storeFactory);

  Iterable<Lecture> get lectures => state.lectures;

  String getEndTime(Lecture lecture) {
    final endTime = lecture.startTime.add(new Duration(minutes: lecture.duration));
    return _getTime(endTime);
  }

  String getStartTime(Lecture lecture) => _getTime(lecture.startTime);

  void onLectureSelect(Lecture lecture) {
    final url = RoutePaths.lecture.toUrl(
      parameters: {idParam: lecture.id},
    );

    _router.navigate(url);
  }

  String _getTime(DateTime date) => '${date.hour}:${_formatHours(date.minute.toString())}';

  @override
  void ngOnInit() {
    _dispatcher.dispatch(InitAction());
  }

  String _formatHours(String hours) => hours.length == 1 ? '${hours}0' : hours;
}
