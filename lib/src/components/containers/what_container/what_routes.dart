import 'package:angular_router/angular_router.dart';
import '../about_container/about_container.template.dart' as about_template;
import '../release_notes_container/release_notes_container.template.dart' as release_notes_template;
import '../../../route_paths.dart';

export '../../../route_paths.dart';

class Routes {
  static final about = RouteDefinition(
    routePath: RoutePaths.about,
    component: about_template.AboutContainerComponentNgFactory,
    useAsDefault: true
  );

  static final releaseNotes = RouteDefinition(
    routePath: RoutePaths.release_notes,
    component: release_notes_template.ReleaseNotesContainerComponentNgFactory,
  );

  static final all = [
    about,
    releaseNotes
  ];
}