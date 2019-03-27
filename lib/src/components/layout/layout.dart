import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart' show MaterialTemporaryDrawerComponent;
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/layout/navigation_type.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/menu_route_path.dart';
import 'package:codefest/src/redux/actions/new_version_action.dart';
import 'package:codefest/src/redux/actions/effects/on_scroll_action.dart';
import 'package:codefest/src/redux/selectors/selectors.dart';
import 'package:codefest/src/redux/services/dispatcher.dart';
import 'package:codefest/src/redux/state/codefest_state.dart';
import 'package:codefest/src/route_paths.dart';
import 'package:codefest/src/services/auth_service.dart';
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
    MaterialTemporaryDrawerComponent,
  ],
  providers: [],
  preserveWhitespace: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  exports: [
    RoutePaths,
  ],
)
class LayoutComponent implements OnInit, OnDestroy {
  final Router _router;
  final Selectors _selectors;
  final AuthService _authService;
  final AuthStore _authStore;
  final Dispatcher _dispatcher;
  final ChangeDetectorRef _cdr;

  final List<StreamSubscription> _subscriptions = [];

  final ga = GoogleAnalytics();

  @ViewChild('main')
  Element mainElement;

  @HostBinding('class.layout')
  final bool isHostMarked = true;

  List<MenuRoutePath> _menu = RoutePaths.menu;

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

  @ViewChild('drawer')
  MaterialTemporaryDrawerComponent drawerComponent;

  RoutePath currentPath;

  LayoutComponent(
    this._router,
    this._selectors,
    this._authService,
    this._authStore,
    this._dispatcher,
    this._cdr,
  );

  String get avatarPath => _selectors.getUserAvatarPath(state);

  bool get isAuthorized => _selectors.isAuthorized(state);

  bool get isBackShown => navHidden != true && navType == NavigationType.back;

  bool get isMenuShown => navHidden != true && navType == NavigationType.menu;

  bool get isSpacerShown => isMenuShown || isBackShown || isTitleShown;

  bool get isTitleShown => !titleHidden;

  List<MenuRoutePath> get menu => _menu;

  String get userName => _selectors.getUserName(state);

  void goBack() {
    _router.navigateByUrl(RoutePaths.lectures.toUrl());
    // todo
    // _location.back();
  }

  bool isActive(RoutePath item) => item.path == currentPath?.path;

  @override
  void ngOnDestroy() {
    _subscriptions.forEach(((subscription) => subscription.cancel()));
  }

  @override
  void ngOnInit() {
    ga.sendPageView();

    if (_authStore.isAuth) {
      _menu.remove(RoutePaths.login);
    }

    if (isScroll) {
      Timer(Duration.zero, () {
        mainElement.scrollTo(0, state.scrollTop);
        _cdr
          ..markForCheck()
          ..detectChanges();
      });
    }

    _subscriptions.add(_router.onRouteActivated.listen(_onRouteActivated));
  }

  void onLogout() {
    _authService.logout();
  }

  void onMenuItemClick(MenuRoutePath item) {
    _router.navigate(item.toUrl());
    drawerComponent.visible = false;
  }

  void onScroll(Event event) {
    final element = event.target as Element;
    _dispatcher.dispatch(OnScrollAction(scrollTop: element.scrollTop));
  }

  void _onRouteActivated(RouterState state) {
    final path = state.routePath;
    currentPath = path?.parent ?? path;
    _cdr
      ..markForCheck()
      ..detectChanges();
  }
}
