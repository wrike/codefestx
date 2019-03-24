import 'dart:html';

import 'package:codefest/src/models/auth.response.dart';
import 'package:codefest/src/models/auth_get_url.response.dart';
import 'package:codefest/src/models/auth_type.enum.dart';
import 'package:codefest/src/services/auth_store.dart';
import 'package:codefest/src/services/http_proxy.dart';
import 'package:codefest/src/services/push_service.dart';

class AuthService {
  static const tokenStorageKey = 'token';
  static const userNameStorageKey = 'userName';
  static const userIdStorageKey = 'userId';
  static const initStorageKey = 'init';
  static const initStorageValue = 'yes';
  static const routePathKey = 'routePath';

  final HttpProxy _http;
  final PushService _push;
  final AuthStore _authStore;

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

  AuthService(this._http, this._push, this._authStore);

  void clearRoutePath() {
    window.localStorage.remove(routePathKey);
  }

  void init() {
    window.localStorage[initStorageKey] = initStorageValue;
    if (_authStore.isAuth) {
      _push.init(_authStore.userId);
    }
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
    window.localStorage[userIdStorageKey] = authResponse.userId;
  }

  void setRoutePath(String path) {
    window.localStorage[routePathKey] = path;
  }

  void _clearToken() {
    window.localStorage.remove(tokenStorageKey);
  }
}
