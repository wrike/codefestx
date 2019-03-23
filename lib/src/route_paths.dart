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
  static final map = MenuRoutePath(title: 'Карта', path: 'map');
  static final release_notes = MenuRoutePath(title: 'Что нового', path: 'release_notes');
  static final about = MenuRoutePath(title: 'О нас', path: 'about');
  static final login = MenuRoutePath(title: 'Войти', path: 'login');

  static final List<MenuRoutePath> _menu = [
    lectures,
    rating,
    map,
    release_notes,
    about,
    login,
  ];

  static List<MenuRoutePath> get menu => _menu;
}
