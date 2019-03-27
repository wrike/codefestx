import 'dart:async';

import 'package:codefest/src/services/http_proxy.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  final _eventController = StreamController<SocketMessage>.broadcast();

  Stream<SocketMessage> get onEvent => _eventController.stream;

  IO.Socket socket = IO.io(HttpProxy.host);

  SocketService() {
    socket.on('message', (rawData) {
      _eventController.add(SocketMessage(rawData));
    });
  }
}

class SocketMessage {
  final String command;
  final String data;

  SocketMessage._(this.command, this.data);

  factory SocketMessage(List<dynamic> message) => SocketMessage._(message[0], message[1]);
}
