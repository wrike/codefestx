import 'package:angular/angular.dart';
import 'package:codefest/src/models/lecture.dart';
import 'package:codefest/src/services/router.dart';

@Component(
  selector: 'lectures',
  styleUrls: ['lectures.css'],
  templateUrl: 'lectures.html',
  directives: [
    NgFor,
  ],
  providers: [],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class LecturesComponent {
  Router _router;

  @Input()
  Iterable<Lecture> lectures;

  LecturesComponent(this._router);

  void handleLectureClick(Lecture lecture) {
    _router.push('lecture');
  }
}
