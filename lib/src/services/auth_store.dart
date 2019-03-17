class AuthStore {
  String token;
  String userName;
  String init;

  bool get isAuth => token?.isNotEmpty ?? false;
  bool get isNewUser => init?.isEmpty ?? true;
}
