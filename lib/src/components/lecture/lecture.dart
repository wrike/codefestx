import 'package:angular/angular.dart';
import 'package:codefest/src/models/lecture.dart';

@Component(
  selector: 'lecture',
  styleUrls: ['lecture.css'],
  templateUrl: 'lecture.html',
  directives: [],
  providers: [],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class LectureComponent {

  LectureComponent();

  void handleLectureClick(Lecture lecture) {}
}
