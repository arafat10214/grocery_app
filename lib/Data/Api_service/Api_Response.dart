class ApiResponse {
  final int statusCode;
  final bool isSuccess;
  final dynamic responseBody;
  final String? message;

  ApiResponse({
    required this.statusCode,
    required this.isSuccess,
    required this.responseBody,
    this.message,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> response) {
    return ApiResponse(
      statusCode: response["statusCode"],
      isSuccess: response["success"],
      responseBody: response["responseBody"],
      message: response["message"] ?? "Something went wrong.!! ",
    );
  }
}
