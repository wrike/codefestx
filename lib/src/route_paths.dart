import 'package:angular_router/angular_router.dart';

const idParam = 'id';

class RoutePaths {
  static final lecture = RoutePath(path: 'lecture/:$idParam');
  static final lectures = RoutePath(path: 'lectures');
}