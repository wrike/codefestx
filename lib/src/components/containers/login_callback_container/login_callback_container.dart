import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/route_paths.dart';
import 'package:codefest/src/routes.dart';
import 'package:codefest/src/services/auth_service.dart';

@Component(
  selector: 'login-callback-container',
  styleUrls: [],
  templateUrl: 'login_callback_container.html',
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
class LoginCallbackContainerComponent implements OnInit {
  final AuthService _service;
  final Router _router;

  LoginCallbackContainerComponent(
    this._service,
    this._router,
  );

  @override
  void ngOnInit() {
    _router.onRouteActivated.listen((routerState) async {
      if (routerState.queryParameters.containsKey('code')) {
        await _service.processAuth(routerState.queryParameters);
        await _router.navigateByUrl(RoutePaths.welcome.toUrl());
      }
    });
  }
}
