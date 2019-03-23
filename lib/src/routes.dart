import 'package:angular_router/angular_router.dart';

import 'components/containers/empty_container/empty_container.template.dart' as empty_template;
import 'components/containers/feedback_container/feedback_container.template.dart' as feedback_template;
import 'components/containers/lecture_container/lecture_container.template.dart' as lecture_template;
import 'components/containers/lectures_container/lectures_container.template.dart' as lectures_template;
import 'components/containers/login_callback_container/login_callback_container.template.dart'
    as login_callback_template;
import 'components/containers/login_container/login_container.template.dart' as login_template;
import 'components/containers/map_container/map_container.template.dart' as map_template;
import 'components/containers/rating_container/rating_container.template.dart' as rating_template;
import 'components/containers/sections_container/sections_container.template.dart' as sections_template;
import 'components/containers/speakers_container/speakers_container.template.dart' as speakers_template;
import 'components/containers/welcome_container/welcome_container.template.dart' as welcome_template;
import 'route_paths.dart';

class Routes {
  static final lecture = RouteDefinition(
    routePath: RoutePaths.lecture,
    component: lecture_template.LectureContainerComponentNgFactory,
  );

  static final lectures = RouteDefinition(
    routePath: RoutePaths.lectures,
    component: lectures_template.LecturesContainerComponentNgFactory,
    useAsDefault: true,
  );

  static final login = RouteDefinition(
    routePath: RoutePaths.login,
    component: login_template.LoginContainerComponentNgFactory,
  );

  static final loginCallback = RouteDefinition(
    routePath: RoutePaths.loginCallback,
    component: login_callback_template.LoginCallbackContainerComponentNgFactory,
  );

  static final speakers = RouteDefinition(
    routePath: RoutePaths.speakers,
    component: speakers_template.SpeakersContainerComponentNgFactory,
  );

  static final map = RouteDefinition(
    routePath: RoutePaths.map,
    component: map_template.MapContainerComponentNgFactory,
  );

  static final feedback = RouteDefinition(
    routePath: RoutePaths.feedback,
    component: feedback_template.FeedbackContainerComponentNgFactory,
  );

  static final sections = RouteDefinition(
    routePath: RoutePaths.sections,
    component: sections_template.SectionsContainerComponentNgFactory,
  );

  static final rating = RouteDefinition(
    routePath: RoutePaths.rating,
    component: rating_template.RatingContainerComponentNgFactory,
  );

  static final welcome = RouteDefinition(
    routePath: RoutePaths.welcome,
    component: welcome_template.WelcomeContainerComponentNgFactory,
  );

  static final empty = RouteDefinition(
    routePath: RoutePaths.empty,
    component: empty_template.EmptyContainerComponentNgFactory,
  );

  static final redirect = new RouteDefinition.redirect(path: '.+', redirectTo: '404');

  static final all = <RouteDefinition>[
    login,
    loginCallback,
    lecture,
    lectures,
    speakers,
    map,
    feedback,
    sections,
    rating,
    welcome,
    empty,
    redirect,
  ];
}
