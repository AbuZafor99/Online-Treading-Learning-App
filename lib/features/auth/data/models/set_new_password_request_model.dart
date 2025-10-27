class SetNewPasswordRequestModel {
  final String email;
  final String password;
  final String otp;

  SetNewPasswordRequestModel({
    required this.email,
    required this.password,
    required this.otp,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password, 'otp': otp};
  }
}
