import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
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
    NgIf,
    NgFor,
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
class LayoutComponent implements OnInit {
  final Selectors _selectors;
  final Router _router;
  final AuthStore _authStore;
  final AuthService _authService;

  final ga = GoogleAnalytics();

  @HostBinding('class.layout')
  final bool isHostMarked = true;

  List<MenuRoutePath> _menu = RoutePaths.menu;

  @Input()
  String title;

  @Input()
  CodefestState state;

  @ViewChild('drawer')
  MaterialTemporaryDrawerComponent drawerComponent;

  LayoutComponent(
    this._router,
    this._selectors,
    this._authService,
    this._authStore,
  );

  String get avatarPath => _selectors.getUserAvatarPath(state);

  bool get isAuthorized => _selectors.isAuthorized(state);

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
}
