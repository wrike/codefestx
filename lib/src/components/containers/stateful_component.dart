import 'dart:async';

import 'package:angular/core.dart';
import 'package:angular/di.dart';
import 'package:codefest/src/redux/services/store_factory.dart';
import 'package:codefest/src/redux/state/codefest_state.dart';
import 'package:redux/redux.dart';

abstract class StatefulComponent implements OnDestroy {
  final NgZone _zone;
  final ChangeDetectorRef _cdr;
  final StoreFactory _storeFactory;

  final List<StreamSubscription> _subscriptions = [];

  Store<CodefestState> _store;

  StatefulComponent(
    this._zone,
    this._cdr,
    this._storeFactory,
  ) {
    _zone.runOutsideAngular(() {
      _store = _storeFactory.getStore();

      _subscriptions.addAll([
        _store.onChange.listen((state) {
          onStateChange(state);
        }),
      ]);
    });
  }

  @Input()
  set state(CodefestState val) {
    detectChanges();
  }

  CodefestState get state => _store.state;

  List<StreamSubscription> get subscriptions => _subscriptions;

  void detectChanges() {
    _zone.run(_cdr.markForCheck);
  }

  void onStateChange(CodefestState s) {
    // call when state changed
    state = s;
  }

  @override
  void ngOnDestroy() {
    _subscriptions.forEach((subscription) => subscription.cancel());
  }
}
