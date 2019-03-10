import 'package:angular/angular.dart';
import 'package:codefest/src/components/layout/layout.dart';

@Component(
  selector: 'lecture',
  styleUrls: ['lecture.css'],
  templateUrl: 'lecture.html',
  directives: [
    LayoutComponent,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class LectureComponent {}
