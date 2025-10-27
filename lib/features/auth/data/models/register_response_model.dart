import 'package:flutter_ladydenily/features/auth/data/models/trading_profile.dart';

import 'different_user_model.dart';

class RegisterResponseModel {
  final String name;
  final String email;
  final String password;
  final String username;
  final String? phone;
  final int? age;
  final String? gender;
  final String? nationality;
  final int? credit;
  final String role;
  final String stripeAccountId;
  final bool isStripeOnboarded;
  final Avatar avatar;
  final String? address;
  final VerificationInfo verificationInfo;
  final String passwordResetToken;
  final int fine;
  final String refreshToken;
  final UserRating userRating;
  final bool tredingProfileComplete;
  final TradingProfile tredingProfile;
  final String id;
  final String uniqueId;
  final String createdAt;
  final String updatedAt;
  final int v;
  final String accessToken;

  RegisterResponseModel({
    required this.name,
    required this.email,
    required this.password,
    required this.username,
    this.phone,
    this.age,
    this.gender,
    this.nationality,
    this.credit,
    required this.role,
    required this.stripeAccountId,
    required this.isStripeOnboarded,
    required this.avatar,
    this.address,
    required this.verificationInfo,
    required this.passwordResetToken,
    required this.fine,
    required this.refreshToken,
    required this.userRating,
    required this.tredingProfileComplete,
    required this.tredingProfile,
    required this.id,
    required this.uniqueId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.accessToken,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      name: json["name"] ?? '',
      email: json["email"] ?? '',
      password: json["password"] ?? '',
      username: json["username"] ?? '',
      phone: json["phone"],
      age: json["age"],
      gender: json["gender"],
      nationality: json["nationality"],
      credit: json["credit"],
      role: json["role"] ?? '',
      stripeAccountId: json["stripeAccountId"] ?? '',
      isStripeOnboarded: json["isStripeOnboarded"] ?? false,
      avatar: Avatar.fromJson(json["avatar"] ?? {}),
      address: json["address"],
      verificationInfo: VerificationInfo.fromJson(
        json["verificationInfo"] ?? {},
      ),
      passwordResetToken: json["password_reset_token"] ?? '',
      fine: json["fine"] ?? 0,
      refreshToken: json["refreshToken"] ?? '',
      userRating: UserRating.fromJson(json["userRating"] ?? {}),
      tredingProfileComplete: json["treding_profile_Complete"] ?? false,
      tredingProfile: TradingProfile.fromJson(json["treding_profile"] ?? {}),
      id: json["_id"] ?? '',
      uniqueId: json["uniqueId"] ?? '',
      createdAt: json["createdAt"] ?? '',
      updatedAt: json["updatedAt"] ?? '',
      v: json["__v"] ?? 0,
      accessToken: json["accessToken"] ?? '',
    );
  }
}
