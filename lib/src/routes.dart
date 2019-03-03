import 'package:angular_router/angular_router.dart';

import 'route_paths.dart';
import 'components/lecture/lecture.template.dart' as lecture_template;
import 'components/lectures/lectures.template.dart' as lectures_template;

export 'route_paths.dart';

class Routes {
  static final lecture = RouteDefinition(
    routePath: RoutePaths.lecture,
    component: lecture_template.LectureComponentNgFactory,
  );

  static final lectures = RouteDefinition(
    routePath: RoutePaths.lectures,
    component: lectures_template.LecturesComponentNgFactory,
    useAsDefault: true,
  );

  static final all = <RouteDefinition>[
    lecture,
    lectures,
  ];
}
