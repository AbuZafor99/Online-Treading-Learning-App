class FetchProfileResponseModel {
  final Avatar avatar;
  final UserRating userRating;
  final TradingProfile trendingProfile;
  final String id;
  final String name;
  final String email;
  final String username;
  final String? phone;
  final String? age;
  final String? gender;
  final String? nationality;
  final int? credit;
  final String role;
  final String stripeAccountId;
  final bool isStripeOnboarded;
  final String? address;
  final int fine;
  final bool trendingProfileComplete;
  final String uniqueId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  FetchProfileResponseModel({
    required this.avatar,
    required this.userRating,
    required this.trendingProfile,
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    this.phone,
    this.age,
    this.gender,
    this.nationality,
    this.credit,
    required this.role,
    required this.stripeAccountId,
    required this.isStripeOnboarded,
    this.address,
    required this.fine,
    required this.trendingProfileComplete,
    required this.uniqueId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory FetchProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return FetchProfileResponseModel(
      avatar: Avatar.fromJson(json['avatar']),
      userRating: UserRating.fromJson(json['userRating']),
      trendingProfile: TradingProfile.fromJson(json['treding_profile']),
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      phone: json['phone'],
      age: json['age'],
      gender: json['gender'],
      nationality: json['nationality'],
      credit: json['credit'],
      role: json['role'] ?? '',
      stripeAccountId: json['stripeAccountId'] ?? '',
      isStripeOnboarded: json['isStripeOnboarded'] ?? false,
      address: json['address'],
      fine: json['fine'] ?? 0,
      trendingProfileComplete: json['treding_profile_Complete'] ?? false,
      uniqueId: json['uniqueId'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avatar': avatar.toJson(),
      'userRating': userRating.toJson(),
      'treding_profile': trendingProfile.toJson(),
      '_id': id,
      'name': name,
      'email': email,
      'username': username,
      'phone': phone,
      'age': age,
      'gender': gender,
      'nationality': nationality,
      'credit': credit,
      'role': role,
      'stripeAccountId': stripeAccountId,
      'isStripeOnboarded': isStripeOnboarded,
      'address': address,
      'fine': fine,
      'treding_profile_Complete': trendingProfileComplete,
      'uniqueId': uniqueId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}

class Avatar {
  final String publicId;
  final String url;

  Avatar({required this.publicId, required this.url});

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(publicId: json['public_id'] ?? '', url: json['url'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'public_id': publicId, 'url': url};
  }
}

class UserRating {
  final RatingDetail competence;
  final RatingDetail punctuality;
  final RatingDetail behavior;

  UserRating({
    required this.competence,
    required this.punctuality,
    required this.behavior,
  });

  factory UserRating.fromJson(Map<String, dynamic> json) {
    return UserRating(
      competence: RatingDetail.fromJson(json['competence']),
      punctuality: RatingDetail.fromJson(json['punctuality']),
      behavior: RatingDetail.fromJson(json['behavior']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'competence': competence.toJson(),
      'punctuality': punctuality.toJson(),
      'behavior': behavior.toJson(),
    };
  }
}

class RatingDetail {
  final int star;
  final String comment;

  RatingDetail({required this.star, required this.comment});

  factory RatingDetail.fromJson(Map<String, dynamic> json) {
    return RatingDetail(
      star: json['star'] ?? 0,
      comment: json['comment'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'star': star, 'comment': comment};
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

  Map<String, dynamic> toJson() {
    return {
      "trading_exprience": tradingExperience,
      "assets_of_interest": assetsOfInterest,
      "main_goal": mainGoal,
      "risk_appetite": riskAppetite,
      "preffered_learning": preferredLearning,
    };
  }
}
