import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
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
import 'package:codefest/src/services/sockets_service.dart';
import 'package:redux/redux.dart';

@Component(
  selector: 'codefest',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [
    NgIf,
    routerDirectives,
    MaterialSpinnerComponent,
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
  final NgZone _zone;
  final Dispatcher _dispatcher;
  final StoreFactory _storeFactory;
  final StateFactory _stateFactory;
  final Selectors _selectors;
  final SocketService _socketService;

  final List<StreamSubscription> _subscriptions = [];

  Store<CodefestState> _store;

  AppComponent(
    this._socketService,
    this._zone,
    this._storeFactory,
    this._stateFactory,
    this._dispatcher,
    this._selectors,
  ) {
    _zone.runOutsideAngular(() {
      _store = _storeFactory.getStore(_stateFactory.getInitialState());

      _subscriptions.addAll([
        _dispatcher.onAction.listen((action) => _store.dispatch(action)),
      ]);
    });
  }

  bool get isError => _selectors.isError(state);

  bool get isReady => _selectors.isReady(state);

  CodefestState get state => _store.state;

  @override
  void ngOnDestroy() {
    _subscriptions.forEach((subscription) => subscription.cancel());
  }

  @override
  void ngOnInit() {
    _socketService.onEvent.where((event) => event.command == 'reload')
        .listen((data) => window.location.reload());

    _socketService.onEvent.where((event) => event.command == 'change-lectures')
        .listen((data) => 0 /* todo показать нотификцию и загрузить стейт */);
  }
}
