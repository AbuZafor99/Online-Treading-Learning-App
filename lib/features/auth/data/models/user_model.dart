import 'package:flutter_ladydenily/features/auth/data/models/trading_profile.dart';

import 'different_user_model.dart';

class UserModel {
  final Avatar avatar;
  final Address address;
  final VerificationInfo verificationInfo;
  final UserRating userRating;
  final TradingProfile tradingProfile;
  final String id;
  final String name;
  final String email;
  final String password;
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
  final int v;

  UserModel({
    required this.avatar,
    required this.address,
    required this.verificationInfo,
    required this.userRating,
    required this.tradingProfile,
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.username,
    required this.phone,
    this.credit,
    required this.role,
    required this.stripeAccountId,
    required this.isStripeOnboarded,
    required this.passwordResetToken,
    required this.fine,
    required this.refreshToken,
    required this.uniqueId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      avatar: Avatar.fromJson(json["avatar"] ?? {}),
      address: Address.fromJson(json["address"] ?? {}),
      verificationInfo: VerificationInfo.fromJson(
        json["verificationInfo"] ?? {},
      ),
      userRating: UserRating.fromJson(json["userRating"] ?? {}),
      tradingProfile: TradingProfile.fromJson(json["treding_profile"] ?? {}),
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      password: json["password"] ?? "",
      username: json["username"] ?? "",
      phone: json["phone"] ?? "",
      credit: json["credit"],
      role: json["role"] ?? "",
      stripeAccountId: json["stripeAccountId"] ?? "",
      isStripeOnboarded: json["isStripeOnboarded"] ?? false,
      passwordResetToken: json["password_reset_token"] ?? "",
      fine: json["fine"] ?? 0,
      refreshToken: json["refreshToken"] ?? "",
      uniqueId: json["uniqueId"] ?? "",
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
      v: json["__v"] ?? 0,
    );
  }
}
