import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/menu_route_path.dart';
import 'package:codefest/src/redux/actions/init_action.dart';
import 'package:codefest/src/redux/services/dispatcher.dart';
import 'package:codefest/src/routes.dart';

@Component(
  selector: 'layout',
  styleUrls: [
    'package:angular_components/app_layout/layout.scss.css',
    'layout.css',
  ],
  templateUrl: 'layout.html',
  directives: [
    NgFor,
    MaterialSpinnerComponent,
    DeferredContentDirective,
    MaterialButtonComponent,
    MaterialIconComponent,
    MaterialTemporaryDrawerComponent,
    MaterialToggleComponent,
    MaterialListComponent,
    MaterialListItemComponent,
    MaterialButtonComponent,
    MaterialIconComponent,
  ],
  providers: [],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
  exports: [
    RoutePaths,
  ],
)
class LayoutComponent implements OnDestroy, OnInit {
  final NgZone _zone;
  final ChangeDetectorRef _cdr;
  final Router _router;
  final Dispatcher _dispatcher;

  StreamSubscription _subscription;

  String title;

  @ViewChild('drawer')
  MaterialTemporaryDrawerComponent drawerComponent;

  LayoutComponent(
    this._zone,
    this._cdr,
    this._router,
    this._dispatcher,
  ) {
    _zone.runOutsideAngular(() {
      _subscription = _router.onRouteActivated.listen((data) {
        title = RoutePaths.menu
            .firstWhere((RoutePath item) => item.path == data?.routePath?.path, orElse: () => RoutePaths.lectures)
            .title;

        _zone.run(() {
          _cdr.markForCheck();
        });
      });
    });
  }

  @override
  void ngOnDestroy() {
    _subscription.cancel();
  }

  @override
  void ngOnInit() {
    _dispatcher.dispatch(InitAction());
  }

  void onMenuItemClick(MenuRoutePath item) {
    _router.navigate(item.toUrl());
    drawerComponent.visible = false;
  }
}
