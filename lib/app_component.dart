import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/popups/new_version_popup/new_version_popup.dart';
import 'package:codefest/src/redux/actions/authorize_action.dart';
import 'package:codefest/src/redux/actions/load_user_data_action.dart';
import 'package:codefest/src/redux/actions/new_version_action.dart';
import 'package:codefest/src/redux/effects/effects.dart';
import 'package:codefest/src/redux/reducers/reducer.dart';
import 'package:codefest/src/redux/selectors/selectors.dart';
import 'package:codefest/src/redux/services/dispatcher.dart';
import 'package:codefest/src/redux/services/state_factory.dart';
import 'package:codefest/src/redux/services/store_factory.dart';
import 'package:codefest/src/redux/state/codefest_state.dart';
import 'package:codefest/src/route_paths.dart';
import 'package:codefest/src/routes.dart';
import 'package:codefest/src/services/auth_service.dart';
import 'package:codefest/src/services/auth_store.dart';
import 'package:codefest/src/services/data_loader.dart';
import 'package:codefest/src/services/http_proxy.dart';
import 'package:codefest/src/services/push_service.dart';
import 'package:codefest/src/services/sockets_service.dart';
import 'package:redux/redux.dart';

@Component(
  selector: 'codefest',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [
    NgIf,
    routerDirectives,
    NewVersionPopupComponent,
  ],
  providers: const <Object>[
    const ClassProvider<StoreFactory>(StoreFactory),
    const ClassProvider<StateFactory>(StateFactory),
    const ClassProvider<CodefestReducer>(CodefestReducer),
    const ClassProvider<Effects>(Effects),
    const ClassProvider<Dispatcher>(Dispatcher),
    const ClassProvider<Selectors>(Selectors),
    const ClassProvider<DataLoader>(DataLoader),
    const ClassProvider<HttpProxy>(HttpProxy),
    const ClassProvider<AuthService>(AuthService),
    const ClassProvider<AuthStore>(AuthStore),
    const ClassProvider<PushService>(PushService),
    const ClassProvider<SocketService>(SocketService),
  ],
  exports: [
    RoutePaths,
    Routes,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class AppComponent implements OnDestroy, OnInit {
  final ChangeDetectorRef _cdr;
  final NgZone _zone;
  final Dispatcher _dispatcher;
  final StoreFactory _storeFactory;
  final StateFactory _stateFactory;
  final Selectors _selectors;
  final SocketService _socketService;
  final AuthStore _authStore;
  final Router _router;

  final List<StreamSubscription> _subscriptions = [];

  Store<CodefestState> _store;

  AppComponent(
    this._socketService,
    this._cdr,
    this._zone,
    this._storeFactory,
    this._stateFactory,
    this._dispatcher,
    this._selectors,
    this._authStore,
    this._router,
  ) {
    _zone.runOutsideAngular(() {
      _store = _storeFactory.getStore(_stateFactory.getInitialState());

      _subscriptions.addAll([
        _store.onChange.listen((_) {
          _zone.run(_cdr.markForCheck);
        }),
        _dispatcher.onAction.listen((action) => _store.dispatch(action)),
      ]);
    });
  }

  bool get isError => _selectors.isError(state);

  bool get isUpdateAvailable => _selectors.isUpdateAvailable(state);

  CodefestState get state => _store.state;

  @override
  void ngOnDestroy() {
    _subscriptions.forEach((subscription) => subscription.cancel());
  }

  @override
  void ngOnInit() {
    if (_authStore.isAuth) {
      _dispatcher.dispatch(LoadUserDataAction());
      _dispatcher.dispatch(AuthorizeAction());
    } else if (_authStore.isNewUser) {
      _router.onRouteActivated.first.then((state) {
        _router.navigateByUrl(RoutePaths.login.toUrl());
      });
    }

    _socketService.onEvent
        .where((event) => event.command == 'reload')
        .listen((data) => _dispatcher.dispatch(NewVersionAction(isAvailable: true)));

    _socketService.onEvent
        .where((event) => event.command == 'change-lectures')
        .listen((data) => 0 /* todo показать нотификцию и загрузить стейт */);
  }
}
