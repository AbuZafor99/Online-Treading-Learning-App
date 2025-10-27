import 'package:equatable/equatable.dart';
import 'avatar_model.dart';
import 'verification_info_model.dart';
import 'user_rating_model.dart';
import 'trading_profile_model.dart';

class CoordinatorUser extends Equatable {
  final Avatar avatar;
  final VerificationInfo verificationInfo;
  final UserRating userRating;
  final TradingProfile? tradingProfile;
  final dynamic age;
  final dynamic gender;
  final dynamic nationality;
  final bool tradingProfileComplete;
  final String id;
  final String name;
  final String email;
  final String username;
  final String phone;
  final dynamic credit;
  final String role;
  final String stripeAccountId;
  final bool isStripeOnboarded;
  final String passwordResetToken;
  final int fine;
  final String refreshToken;
  final String uniqueId;
  final String createdAt;
  final String updatedAt;

  const CoordinatorUser({
    required this.avatar,
    required this.verificationInfo,
    required this.userRating,
    required this.tradingProfile,
    required this.age,
    required this.gender,
    required this.nationality,
    required this.tradingProfileComplete,
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
    required this.credit,
    required this.role,
    required this.stripeAccountId,
    required this.isStripeOnboarded,
    required this.passwordResetToken,
    required this.fine,
    required this.refreshToken,
    required this.uniqueId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CoordinatorUser.fromJson(Map<String, dynamic> json) =>
      CoordinatorUser(
        avatar: Avatar.fromJson(json['avatar'] ?? const {}),
        verificationInfo: VerificationInfo.fromJson(
          json['verificationInfo'] ?? const {},
        ),
        userRating: UserRating.fromJson(json['userRating'] ?? const {}),
        tradingProfile: json['treding_profile'] != null
            ? TradingProfile.fromJson(json['treding_profile'])
            : null,
        age: json['age'],
        gender: json['gender'],
        nationality: json['nationality'],
        tradingProfileComplete:
            json['treding_profile_Complete'] ??
            json['treding_profile_complete'] ??
            false,
        id: json['_id'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        username: json['username'] ?? '',
        phone: json['phone'] ?? '',
        credit: json['credit'],
        role: json['role'] ?? '',
        stripeAccountId: json['stripeAccountId'] ?? '',
        isStripeOnboarded: json['isStripeOnboarded'] ?? false,
        passwordResetToken: json['password_reset_token'] ?? '',
        fine: json['fine'] ?? 0,
        refreshToken: json['refreshToken'] ?? '',
        uniqueId: json['uniqueId'] ?? '',
        createdAt: json['createdAt'] ?? '',
        updatedAt: json['updatedAt'] ?? '',
      );

  @override
  List<Object?> get props => [id, email, username];
}
