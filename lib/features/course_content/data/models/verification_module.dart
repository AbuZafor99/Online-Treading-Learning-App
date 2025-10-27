class VerificationInfo {
  final bool verified;
  final String token;

  VerificationInfo({required this.verified, required this.token});

  factory VerificationInfo.fromJson(Map<String, dynamic> json) =>
      VerificationInfo(verified: json["verified"], token: json["token"]);

  Map<String, dynamic> toJson() => {"verified": verified, "token": token};
}
