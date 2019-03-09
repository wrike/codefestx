import 'package:angular_router/angular_router.dart';

class MenuRoutePath extends RoutePath {
  final String title;

  MenuRoutePath({
    this.title,
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
