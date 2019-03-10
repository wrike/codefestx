import 'dart:async';

class Dispatcher {
  final StreamController<Object> _controller =
      StreamController<Object>.broadcast(sync: true);

  Stream<Object> get onAction => _controller.stream;

  void dispatch(Object action) => _controller.add(action);
}
