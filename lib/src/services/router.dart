import 'dart:html';

import 'package:codefest/src/actions/change_location_action.dart';
import 'package:codefest/src/services/dispather.dart';

class Router {
  final Dispatcher _dispatcher;

  Router(this._dispatcher) {
    window.onPopState.listen((event) {
      _dispatcher.dispatch(new ChangeLocationAction(event.state ?? ''));
    });
  }

  void push(String path) {
    window.history.pushState(path, path, path);
    _dispatcher.dispatch(new ChangeLocationAction(path));
  }
}
