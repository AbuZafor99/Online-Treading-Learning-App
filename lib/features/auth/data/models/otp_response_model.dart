class OtpVerificationResponseModel {
  final bool success;
  final String message;

  OtpVerificationResponseModel({required this.success, required this.message});

  factory OtpVerificationResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpVerificationResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
