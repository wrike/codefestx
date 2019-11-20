import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/redux/actions/effects/change_locale_action.dart';
import 'package:codefest/src/redux/selectors/selectors.dart';
import 'package:codefest/src/redux/services/dispatcher.dart';
import 'package:codefest/src/redux/state/codefest_state.dart';
import 'package:codefest/src/route_paths.dart';
import 'package:codefest/src/services/auth_service.dart';
import 'package:codefest/src/services/intl_service.dart';

@Component(
  selector: 'drawer',
  styleUrls: [
    'drawer.css',
  ],
  templateUrl: 'drawer.html',
  directives: [
    ButtonComponent,
    NgIf,
    NgFor,
    MaterialTemporaryDrawerComponent,
    routerDirectives,
  ],
  providers: [],
  preserveWhitespace: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  exports: [
    RoutePaths,
  ],
)
class DrawerComponent {
  final NgZone _zone;
  final ChangeDetectorRef _cdr;
  final Dispatcher _dispatcher;
  final Selectors _selectors;
  final AuthService _authService;
  final Router _router;

  @Input()
  RoutePath currentPath;

  @Input()
  CodefestState state;

  @ViewChild('drawer')
  MaterialTemporaryDrawerComponent drawerComponent;

  DrawerComponent(
    this._dispatcher,
    this._authService,
    this._selectors,
    this._zone,
    this._cdr,
    this._router,
  );

  bool isActive(RoutePath item) => item.path == currentPath?.path;

  bool get isAuthorized => _selectors.isAuthorized(state);

  String get language => IntlService.changeLanguageButton();

  String get userName => _selectors.getUserName(state);

  String get avatarPath => _selectors.getUserAvatarPath(state);

  void _detectChanges() {
    _zone.run(_cdr.markForCheck);
  }

  void changeLanguage() {
    _dispatcher.dispatch(ChangeLocaleAction(locale: state.locale == IntlService.ruLang ? IntlService.enLang : IntlService.ruLang));
    window.location.reload();
  }

  void onLogout() {
    _authService.logout();
  }

  void toggle() {
    drawerComponent.toggle();
    _detectChanges();
  }
}
