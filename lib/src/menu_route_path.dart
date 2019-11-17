import 'package:angular_router/angular_router.dart';

class MenuRoutePath extends RoutePath {
  String get title => titleFunc();

  final Function titleFunc;

  MenuRoutePath({
    this.titleFunc,
    String path,
    RoutePath parent,
    bool useAsDefault = false,
    dynamic additionalData,
  }) : super(
          path: path,
          parent: parent,
          useAsDefault: useAsDefault,
          additionalData: additionalData,
        );
}
