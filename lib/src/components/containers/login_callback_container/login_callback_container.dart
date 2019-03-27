import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/redux/actions/effects/sync_user_data_action.dart';
import 'package:codefest/src/redux/services/dispatcher.dart';
import 'package:codefest/src/route_paths.dart';
import 'package:codefest/src/routes.dart';
import 'package:codefest/src/services/auth_service.dart';
import 'package:codefest/src/services/auth_store.dart';

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
  final AuthService _authService;
  final AuthStore _authStore;
  final Router _router;
  final Dispatcher _dispatcher;

  LoginCallbackContainerComponent(
    this._authService,
    this._router,
    this._authStore, this._dispatcher,
  );

  @override
  void ngOnInit() {
    _router.onRouteActivated.listen((routerState) async {
      if (routerState.queryParameters.containsKey('code')) {
        await _authService.processAuth(routerState.queryParameters);

        if (_authStore.hasRoutePath) {
          await _router.navigateByUrl(_authStore.routePath);
          _authService.clearRoutePath();
        } else {
          await _router.navigateByUrl(RoutePaths.welcome.toUrl());
        }

        _dispatcher.dispatch(SyncUserDataAction());
      } else {
        await _router.navigateByUrl(_authStore.routePath);
        _authService.clearRoutePath();
      } else {
        await _router.navigateByUrl(_authStore.routePath);
        _authService.clearRoutePath();
      }
    });
  }
}
