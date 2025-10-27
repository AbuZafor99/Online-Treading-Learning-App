import 'package:equatable/equatable.dart';

class VerificationInfo extends Equatable {
  final bool verified;
  final String token;
  const VerificationInfo({required this.verified, required this.token});
  factory VerificationInfo.fromJson(Map<String, dynamic> json) =>
      VerificationInfo(
        verified: json['verified'] ?? false,
        token: json['token'] ?? '',
      );
  @override
  List<Object?> get props => [verified, token];
}
