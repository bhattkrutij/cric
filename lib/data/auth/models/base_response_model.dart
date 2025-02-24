class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;

  ApiResponse({required this.success, required this.message, this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json, ) {
    return ApiResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? 'Something went wrong',
      data: json['data'] != null ?json['data'] : null,
    );
  }

  // Factory method for handling errors
  factory ApiResponse.error(String errorMessage) {
    return ApiResponse(success: false, message: errorMessage, data: null);
  }
}
