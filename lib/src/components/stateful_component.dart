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

  final List<StreamSubscription> _subscriptions = List<StreamSubscription>();

  Store<CodefestState> _store;

  StatefulComponent(
    this._zone,
    this._cdr,
    this._storeFactory,
  ) {
    _zone.runOutsideAngular(() {
      _store = _storeFactory.getStore();

      _subscriptions.addAll([
        _store.onChange.listen((_) {
          _zone.run(() {
            _cdr.markForCheck();
          });
        }),
      ]);
    });
  }

  CodefestState get state => _store.state;

  @override
  void ngOnDestroy() {
    _subscriptions.forEach((s) => s.cancel());
  }
}
