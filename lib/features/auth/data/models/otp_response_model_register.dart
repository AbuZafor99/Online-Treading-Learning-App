class OtpResponseModel {
  final bool success;
  final String message;
  final dynamic data; // safer for future changes

  OtpResponseModel({required this.success, required this.message, this.data});

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'], // directly assign, can be string, null, or map
    );
  }
}
