class UserResponse {
  final String id;
  final String name;
  final String email;
  final String username;
  final String phone;
  final String? credit;
  final String role;
  final String stripeAccountId;
  final bool isStripeOnboarded;
  final String passwordResetToken;
  final int fine;
  final String refreshToken;
  final String uniqueId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final bool tredingProfileComplete;
  final String address;
  final String age;
  final String gender;
  final String nationality;
  final Avatar avatar;
  final VerificationInfo verificationInfo;
  final UserRating userRating;
  final TradingProfile tredingProfile;

  UserResponse({
    required this.id,
    required this.name,
    required this.email,
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
    required this.tredingProfileComplete,
    required this.address,
    required this.age,
    required this.gender,
    required this.nationality,
    required this.avatar,
    required this.verificationInfo,
    required this.userRating,
    required this.tredingProfile,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
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
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      v: json["__v"] ?? 0,
      tredingProfileComplete: json["treding_profile_Complete"] ?? false,
      address: json["address"] ?? "",
      age: json["age"] ?? "",
      gender: json["gender"] ?? "",
      nationality: json["nationality"] ?? "",
      avatar: Avatar.fromJson(json["avatar"]),
      verificationInfo: VerificationInfo.fromJson(json["verificationInfo"]),
      userRating: UserRating.fromJson(json["userRating"]),
      tredingProfile: TradingProfile.fromJson(json["treding_profile"]),
    );
  }
}

class Avatar {
  final String publicId;
  final String url;

  Avatar({required this.publicId, required this.url});

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(publicId: json["public_id"] ?? "", url: json["url"] ?? "");
  }
}

class VerificationInfo {
  final bool verified;
  final String token;

  VerificationInfo({required this.verified, required this.token});

  factory VerificationInfo.fromJson(Map<String, dynamic> json) {
    return VerificationInfo(
      verified: json["verified"] ?? false,
      token: json["token"] ?? "",
    );
  }
}

class UserRating {
  final Rating competence;
  final Rating punctuality;
  final Rating behavior;

  UserRating({
    required this.competence,
    required this.punctuality,
    required this.behavior,
  });

  factory UserRating.fromJson(Map<String, dynamic> json) {
    return UserRating(
      competence: Rating.fromJson(json["competence"]),
      punctuality: Rating.fromJson(json["punctuality"]),
      behavior: Rating.fromJson(json["behavior"]),
    );
  }
}

class Rating {
  final int star;
  final String comment;

  Rating({required this.star, required this.comment});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(star: json["star"] ?? 0, comment: json["comment"] ?? "");
  }
}

class TradingProfile {
  final String tradingExperience;
  final String assetsOfInterest;
  final String mainGoal;
  final String riskAppetite;
  final List<String> preferredLearning;

  TradingProfile({
    required this.tradingExperience,
    required this.assetsOfInterest,
    required this.mainGoal,
    required this.riskAppetite,
    required this.preferredLearning,
  });

  factory TradingProfile.fromJson(Map<String, dynamic> json) {
    return TradingProfile(
      tradingExperience: json["trading_exprience"] ?? "",
      assetsOfInterest: json["assets_of_interest"] ?? "",
      mainGoal: json["main_goal"] ?? "",
      riskAppetite: json["risk_appetite"] ?? "",
      preferredLearning: List<String>.from(json["preffered_learning"] ?? []),
    );
  }
}
