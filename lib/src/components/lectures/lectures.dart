import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/layout/layout.dart';
import 'package:codefest/src/components/lectures/actions/actions.dart';
import 'package:codefest/src/components/lectures/layout_actions/layout_actions.dart';
import 'package:codefest/src/components/stateful_component.dart';
import 'package:codefest/src/models/_types.dart';
import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/models/section.dart';
import 'package:codefest/src/redux/actions/search_lectures_action.dart';
import 'package:codefest/src/redux/actions/toggle_section_action.dart';
import 'package:codefest/src/redux/selectors/selectors.dart';
import 'package:codefest/src/redux/services/dispatcher.dart';
import 'package:codefest/src/redux/services/store_factory.dart';
import 'package:codefest/src/route_paths.dart';
import 'package:codefest/src/routes.dart';

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
    LayoutActionsComponent,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class LecturesComponent extends StatefulComponent {
  final Dispatcher _dispatcher;
  final Router _router;

  LecturesComponent(
    NgZone zone,
    ChangeDetectorRef cdr,
    StoreFactory storeFactory,
    this._dispatcher,
    this._router,
  ) : super(zone, cdr, storeFactory);

  Iterable<Lecture> get lectures => getVisibleLectures(state);

  Iterable<Section> get sections => state.sections;

  String getEndTime(Lecture lecture) {
    final endTime = lecture.startTime.add(new Duration(minutes: lecture.duration));
    return _getTime(endTime);
  }

  String getFlag(Lecture lecture) => lecture.language == LanguageType.en ? '🇬🇧󠁧󠁢󠁥󠁮󠁧󠁿' : '🇷🇺';

  String getStartTime(Lecture lecture) => _getTime(lecture.startTime);

  bool isSectionSelected(Section section) => state.user.selectedSectionIds.contains(section.id);

  void onLectureSelect(Lecture lecture) {
    final url = RoutePaths.lecture.toUrl(
      parameters: {idParam: lecture.id},
    );

    _router.navigate(url);
  }

  void onSearch(String searchText) {
    _dispatcher.dispatch(new SearchLecturesAction(searchText: searchText));
  }

  void onSectionClick(Section section) {
    _dispatcher.dispatch(new ToggleSectionAction(sectionId: section.id));
  }

  String _formatHours(String hours) => hours.length == 1 ? '${hours}0' : hours;

  String _getTime(DateTime date) => '${date.hour}:${_formatHours(date.minute.toString())}';
}
