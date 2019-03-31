import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:codefest/src/components/popups/new_version_popup/new_version_popup.dart';
import 'package:codefest/src/models/talk_post.dart';
import 'package:codefest/src/redux/actions/add_post_action.dart';
import 'package:codefest/src/redux/actions/deleted_post_action.dart';
import 'package:codefest/src/components/ui/button/button.dart';
import 'package:codefest/src/components/ui/empty_state/empty_state.dart';
import 'package:codefest/src/redux/actions/effects/load_user_data_action.dart';
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
import 'package:codefest/src/services/dom_service.dart';
import 'package:codefest/src/services/http_proxy.dart';
import 'package:codefest/src/services/push_service.dart';
import 'package:codefest/src/services/sockets_service.dart';
import 'package:codefest/src/services/storage_service.dart';
import 'package:codefest/src/services/talks_service.dart';
import 'package:redux/redux.dart';

@Component(
  selector: 'codefest',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [
    NgIf,
    routerDirectives,
    EmptyStateComponent,
    NewVersionPopupComponent,
    ButtonComponent,
  ],
  providers: const <Object>[
    const ClassProvider<StoreFactory>(StoreFactory),
    const ClassProvider<StateFactory>(StateFactory),
    const ClassProvider<CodefestReducer>(CodefestReducer),
    const ClassProvider<Effects>(Effects),
    const ClassProvider<Dispatcher>(Dispatcher),
    const ClassProvider<Selectors>(Selectors),
    const ClassProvider<DataLoader>(DataLoader),
    const ClassProvider<TalksService>(TalksService),
    const ClassProvider<HttpProxy>(HttpProxy),
    const ClassProvider<AuthService>(AuthService),
    const ClassProvider<AuthStore>(AuthStore),
    const ClassProvider<PushService>(PushService),
    const ClassProvider<SocketService>(SocketService),
    const ClassProvider<StorageService>(StorageService),
    const ClassProvider<DOMService>(DOMService),
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
  final PushService _pushService;

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
    this._pushService,
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

  String get releaseNote => _selectors.releaseNote(state);

  CodefestState get state => _store.state;

  @override
  void ngOnDestroy() {
    _subscriptions.forEach((subscription) => subscription.cancel());
  }

  void reload() {
    window.location.href = '/';
  }

  @override
  void ngOnInit() {
    _dispatcher.dispatch(LoadUserDataAction());

    if (_authStore.isAuth) {
      Future.delayed(const Duration(seconds: 5)).then((_) => _pushService.init(_authStore.userId));
    } else if (_authStore.isNewUser) {
      _router.onRouteActivated.first.then((state) {
        _router.navigateByUrl(RoutePaths.welcome.toUrl());
      });
    }

    _socketService.onEvent
        .where((event) => event.command == 'reload')
        .listen((event) => _dispatcher.dispatch(NewVersionAction(releaseNote: event.data)));

    _socketService.onEvent
        .where((event) => event.command == 'post-added')
        .listen((event) {
          final data = json.decode(event.data);
          final post = TalkPost.fromJson(data);
          _dispatcher.dispatch(AddPostAction(post));
    });

    _socketService.onEvent
        .where((event) => event.command == 'post-removed')
        .listen((event) => _dispatcher.dispatch(DeletedPostAction(event.data)));

    _socketService.onEvent
        .where((event) => event.command == 'change-lectures')
        .listen((data) => 0 /* todo показать нотификцию и загрузить стейт */);
  }
}
