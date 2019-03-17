import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/models/auth_type.enum.dart';
import 'package:codefest/src/route_paths.dart';
import 'package:codefest/src/routes.dart';
import 'package:codefest/src/services/auth_service.dart';

@Component(
  selector: 'login-container',
  styleUrls: ['login_container.css'],
  templateUrl: 'login_container.html',
  directives: [],
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
  final AuthService _authService;
  final Router _router;

  LoginContainerComponent(
    this._authService,
    this._router,
  );

  void loginFacebook() => _login(AuthType.Facebook);

  void loginGitHub() => _login(AuthType.GitHub);

  void loginVk() => _login(AuthType.VK);

  @override
  void ngOnInit() {
    _authService.init();
  }

  void onClose() {
    _router.navigateByUrl(RoutePaths.welcome.toUrl());
  }

  void _login(AuthType type) {
    _authService.login(type);
  }
}
