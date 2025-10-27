class OtpRequestModelRegister {
  final String email;
  final String otp;

  OtpRequestModelRegister({required this.email, required this.otp});

  Map<String, dynamic> toJson() {
    return {'email': email, 'otp': otp};
  }
}
