import 'dart:html';

import 'package:codefest/src/services/auth_service.dart';

class AuthStore {
  String get token => window.localStorage[AuthService.tokenStorageKey];
  String get userName => window.localStorage[AuthService.userNameStorageKey];

  bool get isAuth => token?.isNotEmpty ?? false;
}
