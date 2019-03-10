class AuthStore {
  String token;
  String userName;

  bool get isAuth => token?.isNotEmpty ?? false;
}
