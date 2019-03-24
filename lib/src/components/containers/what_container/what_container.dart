import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/layout/layout.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'what_routes.dart';

@Component(
  selector: 'what-container',
  styleUrls: ['what_container.css'],
  templateUrl: 'what_container.html',
  directives: [
    LayoutComponent,
    RouterOutlet,
    ButtonComponent
  ],
  exports: [
    Routes, RoutePaths
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class WhatContainerComponent {
  final Router _router;

  void goto(String name) {
    RouteDefinition path;
    switch(name) {
      case 'about': path = Routes.about; break;
      case 'release_notes': path = Routes.releaseNotes; break;
      default: throw new Error();
    }
    _router.navigate('${RoutePaths.what.toUrl()}${path.toUrl()}');
  }
  
  WhatContainerComponent(this._router);
}
