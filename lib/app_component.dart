import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:codefest/src/actions/init_action.dart';
import 'package:codefest/src/components/lectures/lectures.dart';
import 'package:codefest/src/models/codefest_state.dart';
import 'package:codefest/src/services/data_loader.dart';
import 'package:codefest/src/services/dispather.dart';
import 'package:codefest/src/services/effects.dart';
import 'package:codefest/src/services/reducer.dart';
import 'package:codefest/src/services/selector.dart';
import 'package:codefest/src/services/state_factory.dart';
import 'package:codefest/src/services/store_factory.dart';
import 'package:redux/redux.dart';

@Component(
  selector: 'codefest',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [
    NgIf,
    MaterialSpinnerComponent,
    LecturesComponent,
  ],
  providers: [
    const ClassProvider(StoreFactory),
    const ClassProvider(StateFactory),
    const ClassProvider(CodefestReducer),
    const ClassProvider(Effects),
    const ClassProvider(Dispatcher),
    const ClassProvider(Selector),
    const ClassProvider(DataLoader),
  ],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class AppComponent implements OnDestroy {
  final NgZone _zone;
  final ChangeDetectorRef _cd;
  final Dispatcher _dispatcher;
  final StoreFactory _storeFactory;
  final StateFactory _stateFactory;
  final Selector _selector;

  final List<StreamSubscription> _subscriptions = List<StreamSubscription>();

  Store<CodefestState> _store;

  CodefestState get state => _store.state;

  bool get isReady => _selector.isReady(state);

  AppComponent(
    this._zone,
    this._cd,
    this._storeFactory,
    this._stateFactory,
    this._dispatcher,
    this._selector,
  ) {
    _zone.runOutsideAngular(() {
      _store = _storeFactory.getStore(_stateFactory.getInitialState());

      _subscriptions.addAll([
        _store.onChange.listen((_) {
          _zone.run(_cd.markForCheck);
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
}
