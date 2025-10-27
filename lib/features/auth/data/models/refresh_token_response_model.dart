class RefreshTokenResponseModel {
  final String refreshToken;
  final String accessToken;

  RefreshTokenResponseModel({
    required this.refreshToken,
    required this.accessToken,
  });

  factory RefreshTokenResponseModel.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponseModel(
      refreshToken: json['refreshToken'] ?? false,
      accessToken: json['accessToken'] ?? '',
    );
  }
}
