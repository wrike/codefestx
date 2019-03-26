import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/layout/navigation_type.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/menu_route_path.dart';
import 'package:codefest/src/redux/selectors/selectors.dart';
import 'package:codefest/src/redux/state/codefest_state.dart';
import 'package:codefest/src/route_paths.dart';
import 'package:codefest/src/services/auth_service.dart';
import 'package:codefest/src/services/auth_store.dart';
import 'package:gtag_analytics/gtag_analytics.dart';

@Component(
  selector: 'layout',
  styleUrls: [
    'package:angular_components/app_layout/layout.scss.css',
    'layout.css',
  ],
  templateUrl: 'layout.html',
  directives: [
    ButtonComponent,
    NgIf,
    NgFor,
    DeferredContentDirective,
    MaterialTemporaryDrawerComponent,
    MaterialToggleComponent,
    MaterialListComponent,
    MaterialListItemComponent,
    MaterialIconComponent,
  ],
  providers: [],
  preserveWhitespace: false,
  changeDetection: ChangeDetectionStrategy.OnPush,
  exports: [
    RoutePaths,
  ],
)
class LayoutComponent implements OnInit {
  final Router _router;
  final Location _location;
  final Selectors _selectors;
  final AuthService _authService;
  final AuthStore _authStore;

  final ga = GoogleAnalytics();

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
  CodefestState state;

  @ViewChild('drawer')
  MaterialTemporaryDrawerComponent drawerComponent;

  LayoutComponent(
    this._router,
    this._location,
    this._selectors,
    this._authService,
    this._authStore,
  );

  String get avatarPath => _selectors.getUserAvatarPath(state);

  bool get isAuthorized => _selectors.isAuthorized(state);

  bool get isTitleShown => !titleHidden;

  bool get isMenuShown => navHidden != true && navType == NavigationType.menu;

  bool get isBackShown => navHidden != true && navType == NavigationType.back;

  bool get isSpacerShown => isMenuShown || isBackShown || isTitleShown;

  List<MenuRoutePath> get menu => _menu;

  String get userName => _selectors.getUserName(state);

  @override
  void ngOnInit() {
    ga.sendPageView();

    if (_authStore.isAuth) {
      _menu.remove(RoutePaths.login);
    }
  }

  void onLogout() {
    _authService.logout();
  }

  void onMenuItemClick(MenuRoutePath item) {
    _router.navigate(item.toUrl());
    drawerComponent.visible = false;
  }

  void goBack() {
    _router.navigateByUrl(RoutePaths.lectures.toUrl());
    // todo
    // _location.back();
  }
}
