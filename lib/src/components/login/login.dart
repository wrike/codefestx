import 'package:angular/angular.dart';
import 'package:codefest/src/models/auth_type.enum.dart';
import 'package:codefest/src/routes.dart';
import 'package:codefest/src/services/auth_service.dart';

@Component(
  selector: 'login',
  styleUrls: ['login.css'],
  templateUrl: 'login.html',
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
class LoginComponent {
  AuthService _service;

  LoginComponent(this._service);

  void loginVk() => _login(AuthType.VK);

  void loginFacebook() => _login(AuthType.Facebook);

  void loginGitHub() => _login(AuthType.GitHub);

  void _login(AuthType type) {
    _service.login(type);
  }
}
