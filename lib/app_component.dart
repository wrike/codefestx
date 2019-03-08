import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:codefest/src/actions/init_action.dart';
import 'package:codefest/src/components/lectures/lectures.dart';
import 'package:codefest/src/models/codefest_state.dart';
import 'package:codefest/src/route_paths.dart';
import 'package:codefest/src/routes.dart';
import 'package:codefest/src/services/auth_service.dart';
import 'package:codefest/src/services/auth_store.dart';
import 'package:codefest/src/services/data_loader.dart';
import 'package:codefest/src/services/dispather.dart';
import 'package:codefest/src/services/effects.dart';
import 'package:codefest/src/services/http_proxy.dart';
import 'package:codefest/src/services/reducer.dart';
import 'package:codefest/src/services/selector.dart';
import 'package:codefest/src/services/state_factory.dart';
import 'package:codefest/src/services/store_factory.dart';
import 'package:redux/redux.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'codefest',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [
    routerDirectives,
    NgIf,
    MaterialSpinnerComponent,
    LecturesComponent,
  ],
  providers: const <Object>[
    const ClassProvider<StoreFactory>(StoreFactory),
    const ClassProvider<StateFactory>(StateFactory),
    const ClassProvider<CodefestReducer>(CodefestReducer),
    const ClassProvider<Effects>(Effects),
    const ClassProvider<Dispatcher>(Dispatcher),
    const ClassProvider<Selector>(Selector),
    const ClassProvider<DataLoader>(DataLoader),
    const ClassProvider<HttpProxy>(HttpProxy),
    const ClassProvider<AuthService>(AuthService),
    const ClassProvider<AuthStore>(AuthStore),
    routerProviders,
  ],
  exports: [
    RoutePaths,
    Routes,
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class AppComponent implements OnDestroy, OnInit {
  final NgZone _zone;
  final ChangeDetectorRef _cd;
  final Dispatcher _dispatcher;
  final StoreFactory _storeFactory;
  final StateFactory _stateFactory;
  final Selector _selector;
  final Router _router;
  final AuthService _authService;
  final List<StreamSubscription> _subscriptions = [];

  Store<CodefestState> _store;

  CodefestState get state => _store.state;

  bool get isReady => _selector.isReady(state);

  bool get isRootPath => _selector.isRootPath(state);

  AppComponent(
      this._zone,
      this._cd,
      this._storeFactory,
      this._stateFactory,
      this._dispatcher,
      this._selector,
      this._router,
      this._authService,
      ) {
    _zone.runOutsideAngular(() {
      _store = _storeFactory.getStore(_stateFactory.getInitialState());

      _subscriptions.addAll([
        _store.onChange.listen((_) {
          _zone.run(() {
            // TODO: verify that `detectChanges` is needed
            _cd
              ..markForCheck()
              ..detectChanges();
          });
        }),
        _dispatcher.onAction.listen((action) => _store.dispatch(action)),
      ]);

      _dispatcher.dispatch(InitAction());
    });
  }

  @override
  void ngOnDestroy() {
    _subscriptions.forEach((s) => s.cancel());
  }

  @override
  void ngOnInit() {
    _router.onRouteActivated.listen((routerState) async {
      if (routerState.queryParameters.containsKey('code')) {
        await _authService.processAuth(routerState.queryParameters);
      }
    });
  }
}
