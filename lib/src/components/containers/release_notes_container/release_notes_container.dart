import 'package:angular/angular.dart';
import 'package:codefest/src/components/layout/layout.dart';

@Component(
  selector: 'release-notes-container',
  styleUrls: ['release_notes_container.css'],
  templateUrl: 'release_notes_container.html',
  directives: [
    LayoutComponent,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class ReleaseNotesContainerComponent {

}
