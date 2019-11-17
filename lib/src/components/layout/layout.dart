import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/drawer/drawer.dart';
import 'package:codefest/src/components/layout/navigation_type.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/menu_route_path.dart';
import 'package:codefest/src/redux/actions/effects/on_scroll_action.dart';
import 'package:codefest/src/redux/services/dispatcher.dart';
import 'package:codefest/src/redux/state/codefest_state.dart';
import 'package:codefest/src/route_paths.dart';
import 'package:codefest/src/services/auth_store.dart';
import 'package:gtag_analytics/gtag_analytics.dart';

@Component(
  selector: 'layout',
  styleUrls: [
    'layout.css',
  ],
  templateUrl: 'layout.html',
  directives: [
    ButtonComponent,
    NgIf,
    NgFor,
    routerDirectives,
    DrawerComponent,
  ],
  providers: [],
  preserveWhitespace: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class LayoutComponent implements OnInit, OnDestroy {
  final NgZone _zone;
  final Router _router;
  final AuthStore _authStore;
  final Dispatcher _dispatcher;
  final ChangeDetectorRef _cdr;

  final List<StreamSubscription> _subscriptions = [];

  final ga = GoogleAnalytics();

  @ViewChild('main')
  Element mainElement;

  @HostBinding('class.layout')
  final bool isHostMarked = true;

  @Input()
  String title;

  @Input()
  bool navHidden = false;

  @Input()
  bool titleHidden = false;

  @Input()
  NavigationType navType = NavigationType.menu;

  @Input()
  bool isScroll = false;

  @Input()
  CodefestState state;

  RoutePath currentPath;

  LayoutComponent(
    this._router,
    this._authStore,
    this._dispatcher,
    this._cdr,
    this._zone,
  );

  bool get isBackShown => navHidden != true && navType == NavigationType.back;

  bool get isMenuShown => navHidden != true && navType == NavigationType.menu;

  bool get isSpacerShown => isMenuShown || isBackShown || isTitleShown;

  bool get isTitleShown => !titleHidden;

  List<MenuRoutePath> get menu => RoutePaths.menu;

  void goBack() {
    _router.navigateByUrl(RoutePaths.lectures.toUrl());
    // todo
    // _location.back();
  }

  @override
  void ngOnDestroy() {
    _subscriptions.forEach(((subscription) => subscription.cancel()));
  }

  @override
  void ngOnInit() {
    ga.sendPageView();

    // if (_authStore.isAuth) {
    //   _menu.remove(RoutePaths.login);
    // }

    _subscriptions.add(_router.onRouteActivated.listen(_onRouteActivated));
  }

  void onScroll(Event event) {
    final element = event.target as Element;
    _dispatcher.dispatch(OnScrollAction(scrollTop: element.scrollTop));
  }

  void _onRouteActivated(RouterState state) {
    final path = state.routePath;
    currentPath = path?.parent ?? path;

    if (isScroll) {
      window.requestAnimationFrame((num time) {
        mainElement.scrollTo(0, this.state.scrollTop);
        _detectChanges();
      });
    } else {
      _detectChanges();
    }
  }

  void _detectChanges() {
    _zone.run(_cdr.markForCheck);
  }
}
