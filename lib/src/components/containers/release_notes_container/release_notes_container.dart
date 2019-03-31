import 'package:angular/angular.dart';
import 'package:codefest/src/components/ui/event_card/event_card.dart';
import 'package:codefest/src/components/ui/event_card/event_time/event_time.dart';
import 'package:codefest/src/models/release.dart';
import 'package:codefest/src/models/speaker.dart';
import 'package:codefest/src/services/releases_factory.dart';

@Component(
  selector: 'release-notes-container',
  styleUrls: ['release_notes_container.css'],
  templateUrl: 'release_notes_container.html',
  directives: [
    NgFor,
    EventCardComponent,
    EventTimeComponent,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class ReleaseNotesContainerComponent {
  final Iterable<Release> releases = ReleasesFactory.all;

  List<Speaker> createSpeakers(Release release) => [
    Speaker(
      id: "",
      description: "",
      name: release.author,
      company: release.company,
      avatarPath: release.avatar,
    )
  ];
}
