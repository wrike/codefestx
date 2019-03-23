import 'dart:html';

import 'package:codefest/src/models/auth.response.dart';
import 'package:codefest/src/models/auth_get_url.response.dart';
import 'package:codefest/src/models/auth_type.enum.dart';
import 'package:codefest/src/services/http_proxy.dart';

class AuthService {
  static const tokenStorageKey = 'token';
  static const userNameStorageKey = 'userName';
  static const initStorageKey = 'init';
  static const initStorageValue = 'yes';
  static const routePathKey = 'routePath';

  final HttpProxy _http;

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

  AuthService(this._http);

  void clearRoutePath() {
    window.localStorage.remove(routePathKey);
  }

  void init() {
    window.localStorage[initStorageKey] = initStorageValue;
  }

  void login(AuthType authType) async {
    _clearToken();
    final url = _authUrls[authType];
    final auth = await _http.get<AuthGetUrlResponse>(url, decoder: (j) => AuthGetUrlResponse.fromJson(j));
    window.location.href = auth.url;
  }

  void logout() {
    _clearToken();
    window.location.href = '/';
  }

  processAuth(Map<String, String> queryParameters) async {
    final code = queryParameters['code'];
    final state = queryParameters['state'];
    final url = '${_stateToUrl[state]}?code=$code';
    final authResponse = await _http.get<AuthResponse>(url, decoder: (j) => AuthResponse.fromJson(j));
    window.localStorage[tokenStorageKey] = authResponse.token;
    window.localStorage[userNameStorageKey] = authResponse.userName;
  }

  void setRoutePath(String path) {
    window.localStorage[routePathKey] = path;
  }

  void _clearToken() {
    window.localStorage.remove(tokenStorageKey);
  }
}
