import 'dart:async';
import 'dart:convert';

import 'package:codefest/src/models/api_response.dart';
import 'package:codefest/src/services/auth_store.dart';
import 'package:http/http.dart';

typedef T Decoder<T>(dynamic item);

class HttpProxy {
  static const host = String.fromEnvironment('apiHost', defaultValue: 'https://api.kickoff.wrike.tech');

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

  Future<void> delete<T>(String path) async {
    await _http.delete(_fullPath(path), headers: _getHeaders());
  }


  Future<Iterable<T>> getList<T>(String path, Decoder<T> decoder) async {
    final response = await _http.get(_fullPath(path), headers: _getHeaders());
    return (_extractData(response) as List).map(decoder).toList();
  }

  Future<ApiResponse> post(String path, Map<String, dynamic> data) async {
    final response = await _http.post(_fullPath(path), headers: _getHeaders(), body: _encodeData(data));
    return _toApiResponse(response);
  }

  Future<ApiResponse> put(String path, Map<String, dynamic> data) async {
    final response = await _http.put(_fullPath(path), headers: _getHeaders(), body: _encodeData(data));
    return _toApiResponse(response);
  }

  dynamic _encodeData(Map<String, dynamic> data) => jsonEncode(data);

  dynamic _extractData(Response response) => json.decode(response.body);

  String _fullPath(String path) => '${host}/${path}';

  Map<String, String> _getHeaders() {
    final headers = Map<String, String>();
    if (_authStore.isAuth) {
      headers['content-type'] = 'application/json';
      headers['authorization'] = 'bearer ${_authStore.token}';
    }
    return headers;
  }

  ApiResponse _toApiResponse(Response response) {
    final statusCode = response.statusCode == 200 ? StatusCode.success : StatusCode.error;
    return ApiResponse(statusCode: statusCode);
  }
}
