import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/models/auth_type.enum.dart';
import 'package:codefest/src/route_paths.dart';
import 'package:codefest/src/routes.dart';
import 'package:codefest/src/services/auth_service.dart';
import 'package:codefest/src/services/auth_store.dart';

@Component(
  selector: 'login-container',
  styleUrls: ['login_container.css'],
  templateUrl: 'login_container.html',
  directives: [
    ButtonComponent,
  ],
  providers: <Object>[
    AuthService,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
  exports: [
    RoutePaths,
    Routes,
  ],
)
class LoginContainerComponent implements OnInit {
  @HostBinding('class.login')
  final bool isHostMarked = true;

  final AuthService _authService;
  final AuthStore _authStore;
  final Router _router;

  String _routePath;

  LoginContainerComponent(
    this._authService,
    this._router,
    this._authStore,
  ) {
    if (!_authStore.isNewUser) {
      _routePath = _router.current?.path;
    }
  }

  void loginFacebook() => _login(AuthType.Facebook);

  void loginGitHub() => _login(AuthType.GitHub);

  void loginVk() => _login(AuthType.VK);

  @override
  void ngOnInit() {
    if (_routePath != null) {
      _authService.setRoutePath(_routePath);
    }
  }

  void onClose() {
    if (_authStore.hasRoutePath) {
      _router.navigateByUrl(_authStore.routePath);
      _authService.clearRoutePath();
    } else {
      _router.navigateByUrl(RoutePaths.welcome.toUrl());
    }
  }

  void _login(AuthType type) {
    _authService.login(type);
  }
}
