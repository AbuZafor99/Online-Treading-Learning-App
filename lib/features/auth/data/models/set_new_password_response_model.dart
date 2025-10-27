class SetNewPasswordResponseModel {
  final bool success;
  final String message;

  SetNewPasswordResponseModel({required this.success, required this.message});

  factory SetNewPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return SetNewPasswordResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
