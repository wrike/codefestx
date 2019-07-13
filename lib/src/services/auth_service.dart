import 'dart:html';

import 'package:codefest/src/models/auth.response.dart';
import 'package:codefest/src/models/auth_get_url.response.dart';
import 'package:codefest/src/models/auth_type.enum.dart';
import 'package:codefest/src/redux/actions/authorize_action.dart';
import 'package:codefest/src/redux/actions/set_user_data_action.dart';
import 'package:codefest/src/redux/services/dispatcher.dart';
import 'package:codefest/src/services/http_proxy.dart';
import 'package:codefest/src/services/push_service.dart';

class AuthService {
  static const tokenStorageKey = 'token';
  static const userNameStorageKey = 'userName';
  static const userIdStorageKey = 'userId';
  static const initStorageKey = 'init';
  static const initStorageValue = 'yes';
  static const routePathKey = 'routePath';

  final Dispatcher _dispatcher;
  final HttpProxy _http;
  final PushService _pushService;

  Map<AuthType, String> _authUrls = {
    AuthType.Anonymous: 'auth/register',
    AuthType.VK: 'auth/vk/uri',
    AuthType.Facebook: 'auth/facebook/uri',
    AuthType.GitHub: 'auth/github/uri',
  };

  Map<String, String> _stateToUrl = {
    '{vkstate}': 'auth/vk/callback',
    '{fbstate}': 'auth/facebook/callback',
    '{ghstate}': 'auth/github/callback',
  };

  AuthService(this._http, this._dispatcher, this._pushService);

  void clearRoutePath() {
    window.localStorage.remove(routePathKey);
  }

  void init() {
    window.localStorage[initStorageKey] = initStorageValue;
  }

  void login(AuthType authType) async {
    _clearAuthData();
    final url = _authUrls[authType];
    final auth = await _http.get<AuthGetUrlResponse>(url, decoder: (j) => AuthGetUrlResponse.fromJson(j));
    window.location.href = auth.url;
  }

  void logout() {
    _clearAuthData();
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
    final action = SetUserDataAction(
      displayName: authResponse.userName,
      avatarPath: authResponse.avatar,
      favoriteLectureIds: authResponse.favoriteLecturesIds,
      likedLectureIds: authResponse.likedLecturesIds,
      selectedSectionIds: authResponse.sectionIds,
    );
    _dispatcher.dispatch(action);
    _dispatcher.dispatch(AuthorizeAction());
   _pushService.init(authResponse.userId);
  }

  void setRoutePath(String path) {
    window.localStorage[routePathKey] = path;
  }

  void _clearAuthData() {
    window.localStorage.remove(tokenStorageKey);
    window.localStorage.remove(userIdStorageKey);
    window.localStorage.remove(userNameStorageKey);
  }

  createUser() async {
    final url = _authUrls[AuthType.Anonymous];
    final auth = await _http.get<AuthResponse>(url, decoder: (j) => AuthResponse.fromJson(j));
    window.localStorage[tokenStorageKey] = auth.token;
    window.localStorage[userNameStorageKey] = auth.userName;
    window.localStorage[userIdStorageKey] = auth.userId;

  }
}
