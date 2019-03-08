import 'dart:html';

import 'package:codefest/src/models/auth.response.dart';
import 'package:codefest/src/models/auth_type.enum.dart';
import 'package:codefest/src/services/auth_store.dart';
import 'package:codefest/src/services/http_proxy.dart';

class AuthService {
  static const _tokenStorageKey = 'token';
  static const _userNameStorageKey = 'userName';

  final HttpProxy _http;
  final AuthStore _authStore;

  AuthService(this._http, this._authStore) {
    _authStore.token = window.localStorage[_tokenStorageKey];
    _authStore.userName = window.localStorage[_userNameStorageKey];
  }

  String _token;
  String _userName;

  void login(AuthType authType) async {
    final url = _authUrls[authType];
    final authUrl = await _http.get<String>(url);
    window.location.href = authUrl;
  }

  Map<AuthType, String> _authUrls = {
    AuthType.VK: 'auth/vk/uri',
    AuthType.Facebook: 'auth/facebook/uri',
    AuthType.GitHub: 'auth/github/uri',
  };

  Map<String, String> _stateToUrl = {
    '{vkstate}': 'auth/vk/callback',
    '{fbstate}': 'auth/facebook/callback',
    '{ghstate}': 'auth/github/callback',
  };

  processAuth(Map<String, String> queryParameters) async {
    final code = queryParameters['code'];
    final state = queryParameters['state'];
    final url = '${_stateToUrl[state]}?code=$code';
    final authResponse = await _http.get<AuthResponse>(url, decoder: (j) => AuthResponse.fromJson(j));
    _token = authResponse.token;
    _userName = authResponse.userName;
    window.localStorage[_tokenStorageKey] = _token;
    window.localStorage[_userNameStorageKey] = _userName;
    print('AUTH SUCCESS!');
  }


}
