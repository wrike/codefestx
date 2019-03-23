import 'package:angular/angular.dart';
import 'package:codefest/src/components/layout/layout.dart';

@Component(
  selector: 'speakers-container',
  styleUrls: ['speakers_container.css'],
  templateUrl: 'speakers_container.html',
  directives: [
    LayoutComponent,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class SpeakersContainerComponent {

}
