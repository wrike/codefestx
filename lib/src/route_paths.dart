import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/menu_route_path.dart';

const idParam = 'id';

class RoutePaths {
  static final lecture = RoutePath(path: 'lecture/:$idParam');
  static final loginCallback = RoutePath(path: 'loginCallback');
  static final sections = RoutePath(path: 'sections');
  static final welcome = RoutePath(path: 'welcome');
  static final empty = RoutePath(path: '404');
  static final release_notes = RoutePath(parent: what, path: 'is_new');
  static final about = RoutePath(parent: what, path: 'is_this');

  // Menu route paths
  static final lectures = MenuRoutePath(title: 'Расписание', path: 'lectures');
  static final rating = MenuRoutePath(title: 'Рейтинг докладов', path: 'rating');
  static final map = MenuRoutePath(title: 'Карта', path: 'map');
  static final what = MenuRoutePath(title: 'Что происходит', path: 'what');
  static final login = MenuRoutePath(title: 'Войти', path: 'login');

  static final logout = MenuRoutePath(title: 'Выйти', path: 'logout');

  static final List<MenuRoutePath> _menu = [
    lectures,
//    rating,
//    map,
    what,
    login,
  ];

  static List<MenuRoutePath> get menu => _menu;
}
