import 'package:angular/angular.dart';
import 'package:codefest/src/models/release.dart';
import 'package:codefest/src/services/releases_factory.dart';

@Component(
  selector: 'release-notes-container',
  styleUrls: ['release_notes_container.css'],
  templateUrl: 'release_notes_container.html',
  directives: [
    NgFor,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class ReleaseNotesContainerComponent {
  final Iterable<Release> releases = ReleasesFactory.all;
}
