import 'dart:async';

import 'package:codefest/src/services/http_proxy.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  final _eventController = new StreamController<String>.broadcast();
  Stream<String> get onEvent => _eventController.stream;

  IO.Socket socket = IO.io(HttpProxy.host);

  SocketService() {
    socket.on('message', _eventController.add);
  }
}
