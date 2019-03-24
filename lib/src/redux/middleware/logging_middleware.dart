import 'package:redux/redux.dart';

class LoggingMiddleware extends MiddlewareClass {
  @override
  void call(Store store, action, NextDispatcher next) {
    print(action);
    next(action);
  }
}
