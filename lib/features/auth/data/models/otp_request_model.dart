class OtpVerificationRequestModel {
  final String email;
  final String otp;

  OtpVerificationRequestModel({required this.email, required this.otp});

  Map<String, dynamic> toJson() {
    return {'email': email, 'otp': otp};
  }
}
