class Avatar {
  final String publicId;
  final String url;

  Avatar({required this.publicId, required this.url});

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(publicId: json["public_id"] ?? "", url: json["url"] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {"public_id": publicId, "url": url};
  }
}

class Address {
  final String street;
  final String city;
  final String state;
  final String zipCode;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json["street"] ?? "",
      city: json["city"] ?? "",
      state: json["state"] ?? "",
      zipCode: json["zipCode"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {"street": street, "city": city, "state": state, "zipCode": zipCode};
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

  Map<String, dynamic> toJson() {
    return {"verified": verified, "token": token};
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
      competence: RatingDetail.fromJson(json["competence"] ?? {}),
      punctuality: RatingDetail.fromJson(json["punctuality"] ?? {}),
      behavior: RatingDetail.fromJson(json["behavior"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "competence": competence.toJson(),
      "punctuality": punctuality.toJson(),
      "behavior": behavior.toJson(),
    };
  }
}

class RatingDetail {
  final int star;
  final String comment;

  RatingDetail({required this.star, required this.comment});

  factory RatingDetail.fromJson(Map<String, dynamic> json) {
    return RatingDetail(
      star: json["star"] ?? 0,
      comment: json["comment"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {"star": star, "comment": comment};
  }
}
