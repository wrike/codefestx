import 'package:angular/angular.dart';
import 'package:codefest/src/components/layout/layout.dart';

@Component(
  selector: 'feedback-container',
  styleUrls: ['feedback_container.css'],
  templateUrl: 'feedback_container.html',
  directives: [
    LayoutComponent,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class FeedbackContainerComponent {

}
