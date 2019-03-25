class AuthGetUrlResponse {
  final String url;

  AuthGetUrlResponse({
    this.url,
  });

  factory AuthGetUrlResponse.fromJson(Map<String, dynamic> json) => AuthGetUrlResponse(url: json['url'] as String);
}
