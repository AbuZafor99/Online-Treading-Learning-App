class ResetPasswordRequestModel {
  final String email;

  ResetPasswordRequestModel({required this.email});

  /// Convert class to JSON for API request
  Map<String, dynamic> toJson() {
    return {"email": email};
  }
}
