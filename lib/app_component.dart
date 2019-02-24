import 'dart:async';

import 'package:angular/angular.dart';
import 'package:codefest/src/actions/load_program_action.dart';
import 'package:codefest/src/models/codefest_state.dart';
import 'package:codefest/src/services/dispather.dart';
import 'package:codefest/src/services/state_factory.dart';
import 'package:codefest/src/services/store_factory.dart';
import 'package:redux/redux.dart';

@Component(
  selector: 'codefest',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [],
  preserveWhitespace: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class AppComponent implements OnDestroy {
  final NgZone _zone;
  final ChangeDetectorRef _cd;
  final Dispatcher _dispatcher;
  final StoreFactory _storeFactory;
  final StateFactory _stateFactory;

  final List<StreamSubscription> _subscriptions = List<StreamSubscription>();

  Store<CodefestState> _store;

  AppComponent(
    this._zone,
    this._cd,
    this._storeFactory,
    this._stateFactory,
    this._dispatcher,
  ) {
    _zone.runOutsideAngular(() {
      _store = _storeFactory.getStore(_stateFactory.getInitialState());

      _subscriptions.addAll([
        _store.onChange.listen((_) {
          _zone.run(_cd.markForCheck);
        }),
        _dispatcher.onAction.listen((action) => _store.dispatch(action)),
      ]);

      _dispatcher.dispatch(LoadProgramAction());
    });
  }

  @override
  void ngOnDestroy() {
    _subscriptions.forEach((s) => s.cancel());
  }
}
