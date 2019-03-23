enum StatusCode {
  success,
  error,
  unknown,
}

class ApiResponse {
  final StatusCode statusCode;

  ApiResponse({this.statusCode});
}
