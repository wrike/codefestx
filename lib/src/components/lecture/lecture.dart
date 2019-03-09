import 'package:angular/angular.dart';
import 'package:codefest/src/components/layout/layout.dart';
import 'package:codefest/src/components/layout/menu_item.dart';
import 'package:codefest/src/models/lecture.dart';

@Component(
  selector: 'lecture',
  styleUrls: ['lecture.css'],
  templateUrl: 'lecture.html',
  directives: [
    LayoutComponent,
  ],
  providers: [],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
  exports: [MenuItem]
)
class LectureComponent {}
