import 'package:angular/angular.dart';
import 'package:codefest/src/models/lecture.dart';

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
  @Input()
  Iterable<Lecture> lectures;

  LecturesComponent();
}
