import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/routes.dart';
import 'package:codefest/src/services/auth_service.dart';

@Component(
  selector: 'login-callback',
  styleUrls: [],
  templateUrl: 'login_callback.html',
  directives: [],
  providers: [
    AuthService,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
  exports: [RoutePaths, Routes],
)
class LoginCallbackComponent implements OnInit {
  AuthService _service;
  final Router _router;
  LoginCallbackComponent(this._service, this._router);

  @override
  void ngOnInit() {
    _router.onRouteActivated.listen((routerState) async {
      if (routerState.queryParameters.containsKey('code')) {
        await _service.processAuth(routerState.queryParameters);
      }
    });
  }
}
