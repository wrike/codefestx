import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/containers/stateful_component.dart';
import 'package:codefest/src/components/layout/layout.dart';
import 'package:codefest/src/components/ui/tabs/tabs.dart';
import 'package:codefest/src/redux/services/store_factory.dart';

import 'what_routes.dart';

@Component(
  selector: 'what-container',
  styleUrls: ['what_container.css'],
  templateUrl: 'what_container.html',
  directives: [
    LayoutComponent,
    RouterOutlet,
    TabsComponent,
  ],
  exports: [
    Routes,
    RoutePaths,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class WhatContainerComponent extends StatefulComponent {
  final Router _router;

  bool isAboutUsEnable = true;

  WhatContainerComponent(
    NgZone zone,
    ChangeDetectorRef cdr,
    StoreFactory storeFactory,
    this._router,
  ) : super(zone, cdr, storeFactory) {
    zone.runOutsideAngular(() {
      subscriptions.addAll([
        _router.onRouteActivated.listen(_onRouteActivated),
      ]);
    });
  }

  void goto(String name) {
    RouteDefinition path;

    switch (name) {
      case 'about':
        path = Routes.about;
        break;
      case 'release_notes':
        path = Routes.releaseNotes;
        break;
      default:
        throw new Error();
    }

    _router.navigate('${RoutePaths.what.toUrl()}${path.toUrl()}');
  }

  void _onRouteActivated(RouterState event) {
    isAboutUsEnable = !event.path.contains(Routes.releaseNotes.path);
    detectChanges();
  }
}
