import 'dart:async';
import 'dart:convert';

import 'package:codefest/src/services/auth_store.dart';
import 'package:http/http.dart';

class HttpProxy {
  static const _host = const String.fromEnvironment('apiHost', defaultValue: 'http://localhost:3000');
  final Client _http;
  final AuthStore _authStore;

  HttpProxy(this._http, this._authStore);

  dynamic _extractData(Response resp) => json.decode(resp.body);

  String _fullPath(String path) => '${_host}/${path}';

  Map<String, String> _getHeaders() {
    final headers = Map<String, String>();
    if (_authStore.isAuth) {
      headers['authorization'] = 'bearer ${_authStore.token}';
    }
    return headers;
  }

  Future<Iterable<T>> getList<T>(String path, Function decoder) async {
    final response = await _http.get(_fullPath(path), headers: _getHeaders());
    return (_extractData(response) as List).map(decoder);
  }

  Future<T> get<T>(String path, {Function decoder}) async {
    final response = await _http.get(_fullPath(path), headers: _getHeaders());
    return decoder == null
        ? _extractData(response) as T
        : decoder((_extractData(response) as Map));
  }
}
