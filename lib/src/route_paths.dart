import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/menu_route_path.dart';

const idParam = 'id';

class RoutePaths {
  static final lecture = RoutePath(path: 'lecture/:$idParam');
  static final loginCallback = RoutePath(path: 'loginCallback');
  static final sections = RoutePath(path: 'sections');
  static final welcome = RoutePath(path: 'welcome');
  static final empty = RoutePath(path: '404');

  // Menu route paths
  static final lectures = MenuRoutePath(title: 'Расписание', path: 'lectures');
  static final rating = MenuRoutePath(title: 'Рейтинг докладов', path: 'rating');
  static final speakers = MenuRoutePath(title: 'Спикеры', path: 'speakers');
  static final map = MenuRoutePath(title: 'Карта', path: 'map');
  static final feedback = MenuRoutePath(title: 'Отправить feedback', path: 'feedback');
  static final login = MenuRoutePath(title: 'Войти', path: 'login');

  static final List<MenuRoutePath> _menu = [
    lectures,
    rating,
    speakers,
    map,
    login,
    feedback,
  ];

  static List<MenuRoutePath> get menu => _menu;
}
