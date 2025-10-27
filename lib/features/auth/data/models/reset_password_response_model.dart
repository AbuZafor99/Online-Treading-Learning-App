class ResetPasswordResponseModel {
  final bool success;
  final String message;

  ResetPasswordResponseModel({required this.success, required this.message});

  factory ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponseModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
    );
  }
}
