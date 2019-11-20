import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/containers/stateful_component.dart';
import 'package:codefest/src/components/layout/navigation_type.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/redux/actions/effects/actions.dart';
import 'package:codefest/src/redux/selectors/selectors.dart';
import 'package:codefest/src/redux/services/dispatcher.dart';
import 'package:codefest/src/redux/services/store_factory.dart';
import 'package:codefest/src/services/intl_service.dart';

@Component(
  selector: 'lecture-info',
  styleUrls: ['lecture_info.css'],
  templateUrl: 'lecture_info.html',
  directives: [
    NgIf,
    NgFor,
    ButtonComponent,
  ],
  exports: [
    NavigationType,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class LectureInfoComponent extends StatefulComponent {
  final Selectors _selectors;
  final Dispatcher _dispatcher;
  final Router _router;

  @Input()
  Lecture lecture;

  @Input()
  bool isShowDate = false;

  LectureInfoComponent(
    NgZone zone,
    ChangeDetectorRef cdr,
    StoreFactory storeFactory,
    this._router,
    this._selectors,
    this._dispatcher,
  ) : super(
          zone,
          cdr,
          storeFactory,
        );

  String get endTime => _selectors.getEndTimeText(lecture);

  bool get isAuthorized => _selectors.isAuthorized(state);

  bool get isLectureStarted => _selectors.isLectureStarted(lecture);

  bool get isLikable => _selectors.isLikableLecture(lecture);

  String get date => _selectors.getDateText(lecture);

  bool get isLiked => _selectors.isLikedLecture(state, lecture);

  String get startTime => _selectors.getStartTimeText(lecture);

  void onLikeClick() {
    if (!isAuthorized) {
      //_router.navigateByUrl(RoutePaths.login.toUrl());
    } else if (isLectureStarted) {
      _dispatcher.dispatch(UpdateLectureLikeAction(lectureId: lecture.id, isLiked: !isLiked));
    }
  }

  /// I18n
  String get votingMainTitle => IntlService.votingMainTitle();
  String get votingMainSubtitle => IntlService.votingMainSubtitle();
  String get voteButton => IntlService.voteButton();
  String get voteDoneButton => IntlService.voteDoneButton();
  String get votingNotice => IntlService.votingNotice();
}
