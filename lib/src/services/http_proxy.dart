import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:codefest/src/services/auth_store.dart';
import 'package:http/http.dart';

typedef T Decoder<T>(dynamic item);

class HttpProxy {
  static const host = const String.fromEnvironment('apiHost', defaultValue: 'https://api.codefest.wrike.tech');

  final Client _http;
  final AuthStore _authStore;

  HttpProxy(
    this._http,
    this._authStore,
  );

  Future<T> get<T>(String path, {Decoder<T> decoder}) async {
    final response = await _http.get(_fullPath(path), headers: _getHeaders());
    return decoder == null ? _extractData(response) as T : decoder((_extractData(response) as Map));
  }

  Future<Iterable<T>> getList<T>(String path, Decoder<T> decoder) async {
    final response = await _http.get(_fullPath(path), headers: _getHeaders());
    return (_extractData(response) as List).map(decoder).toList();
  }

  Future post(String path, Map<String, String> data) async {
    final token = window.localStorage['token'];
    final headers = {'authorization': 'bearer $token'};
    await _http.post(_fullPath(path), headers: headers, body: data);
  }

  dynamic _extractData(Response resp) => json.decode(resp.body);

  String _fullPath(String path) => '${host}/${path}';

  Map<String, String> _getHeaders() {
    final headers = Map<String, String>();
    if (_authStore.isAuth) {
      headers['authorization'] = 'bearer ${_authStore.token}';
    }
    return headers;
  }
}
