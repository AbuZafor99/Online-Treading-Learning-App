class AuthResponseModel {
  final String? accessToken;
  final String? refreshToken;
  final String? role;
  final String? id;
  final User? user;

  AuthResponseModel({
    this.accessToken,
    this.refreshToken,
    this.role,
    this.id,
    this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      return AuthResponseModel(
        accessToken: json['accessToken'] as String?,
        refreshToken: json['refreshToken'] as String?,
        role: json['role'] as String?,
        id: json['_id'] as String?,
        user: json['user'] != null ? User.fromJson(json['user']) : null,
      );
    } catch (e) {
      // Log error if needed
      print("AuthResponseModel parsing error: $e");
      return AuthResponseModel();
    }
  }
}

class User {
  final Avatar? avatar;
  final VerificationInfo? verificationInfo;
  final UserRating? userRating;
  final TradingProfile? tradingProfile;
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? username;
  final String? phone;
  final String? role;
  final String? stripeAccountId;
  final bool? isStripeOnboarded;
  final String? passwordResetToken;
  final int? fine;
  final String? refreshToken;
  final String? uniqueId;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final bool? tradingProfileComplete;
  final String? address;
  final String? age;
  final String? gender;
  final String? nationality;

  User({
    this.avatar,
    this.verificationInfo,
    this.userRating,
    this.tradingProfile,
    this.id,
    this.name,
    this.email,
    this.password,
    this.username,
    this.phone,
    this.role,
    this.stripeAccountId,
    this.isStripeOnboarded,
    this.passwordResetToken,
    this.fine,
    this.refreshToken,
    this.uniqueId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.tradingProfileComplete,
    this.address,
    this.age,
    this.gender,
    this.nationality,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      return User(
        avatar: json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null,
        verificationInfo: json['verificationInfo'] != null
            ? VerificationInfo.fromJson(json['verificationInfo'])
            : null,
        userRating: json['userRating'] != null
            ? UserRating.fromJson(json['userRating'])
            : null,
        tradingProfile: json['treding_profile'] != null
            ? TradingProfile.fromJson(json['treding_profile'])
            : null,
        id: json['_id'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        password: json['password'] as String?,
        username: json['username'] as String?,
        phone: json['phone'] as String?,
        role: json['role'] as String?,
        stripeAccountId: json['stripeAccountId'] as String?,
        isStripeOnboarded: json['isStripeOnboarded'] as bool?,
        passwordResetToken: json['password_reset_token'] as String?,
        fine: json['fine'] is int
            ? json['fine'] as int
            : int.tryParse('${json['fine']}'),
        refreshToken: json['refreshToken'] as String?,
        uniqueId: json['uniqueId'] as String?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        v: json['__v'] as int?,
        tradingProfileComplete: json['treding_profile_Complete'] as bool?,
        address: json['address'] as String?,
        age: json['age']?.toString(),
        gender: json['gender'] as String?,
        nationality: json['nationality'] as String?,
      );
    } catch (e) {
      print("User parsing error: $e");
      return User();
    }
  }
}

class Avatar {
  final String? publicId;
  final String? url;

  Avatar({this.publicId, this.url});

  factory Avatar.fromJson(Map<String, dynamic> json) {
    try {
      return Avatar(
        publicId: json['public_id'] as String?,
        url: json['url'] as String?,
      );
    } catch (e) {
      print("Avatar parsing error: $e");
      return Avatar();
    }
  }

  Map<String, dynamic> toJson() => {"public_id": publicId, "url": url};
}

class VerificationInfo {
  final bool? verified;
  final String? token;

  VerificationInfo({this.verified, this.token});

  factory VerificationInfo.fromJson(Map<String, dynamic> json) {
    try {
      return VerificationInfo(
        verified: json['verified'] as bool?,
        token: json['token'] as String?,
      );
    } catch (e) {
      print("VerificationInfo parsing error: $e");
      return VerificationInfo();
    }
  }

  Map<String, dynamic> toJson() => {"verified": verified, "token": token};
}

class UserRating {
  final Rating? competence;
  final Rating? punctuality;
  final Rating? behavior;

  UserRating({this.competence, this.punctuality, this.behavior});

  factory UserRating.fromJson(Map<String, dynamic> json) {
    try {
      return UserRating(
        competence: json['competence'] != null
            ? Rating.fromJson(json['competence'])
            : null,
        punctuality: json['punctuality'] != null
            ? Rating.fromJson(json['punctuality'])
            : null,
        behavior: json['behavior'] != null
            ? Rating.fromJson(json['behavior'])
            : null,
      );
    } catch (e) {
      print("UserRating parsing error: $e");
      return UserRating();
    }
  }
}

class Rating {
  final int star;
  final String comment;

  Rating({required this.star, required this.comment});

  factory Rating.fromJson(Map<String, dynamic> json) {
    try {
      return Rating(
        star: json['star'] is int
            ? json['star']
            : int.tryParse('${json['star']}') ?? 0,
        comment: json['comment']?.toString() ?? '',
      );
    } catch (e) {
      print("Rating parsing error: $e");
      return Rating(star: 0, comment: '');
    }
  }
}

class TradingProfile {
  final String? tradingExperience;
  final String? assetsOfInterest;
  final String? mainGoal;
  final String? riskAppetite;
  final List<String>? preferredLearning;

  TradingProfile({
    this.tradingExperience,
    this.assetsOfInterest,
    this.mainGoal,
    this.riskAppetite,
    this.preferredLearning,
  });

  factory TradingProfile.fromJson(Map<String, dynamic> json) {
    try {
      return TradingProfile(
        tradingExperience:
            json['trading_exprience'] as String? ??
            json['tradingExperience'] as String?,
        assetsOfInterest: json['assets_of_interest'] as String?,
        mainGoal: json['main_goal'] as String?,
        riskAppetite: json['risk_appetite'] as String?,
        preferredLearning: json['preffered_learning'] != null
            ? List<String>.from(json['preffered_learning'])
            : json['preferred_learning'] != null
            ? List<String>.from(json['preferred_learning'])
            : null,
      );
    } catch (e) {
      print("TradingProfile parsing error: $e");
      return TradingProfile();
    }
  }

  Map<String, dynamic> toJson() => {
    "trading_exprience": tradingExperience,
    "assets_of_interest": assetsOfInterest,
    "main_goal": mainGoal,
    "risk_appetite": riskAppetite,
    "preffered_learning": preferredLearning,
  };
}
