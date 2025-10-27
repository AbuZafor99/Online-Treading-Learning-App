import 'package:equatable/equatable.dart';
import 'package:flutter_ladydenily/features/course/models/avatar_model.dart';
import 'package:flutter_ladydenily/features/course/models/user_rating_model.dart';
import 'package:flutter_ladydenily/features/course/models/verification_info_model.dart';
import 'package:flutter_ladydenily/features/course/models/trading_profile_model.dart';

class TrainerApiModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String username;
  final String phone;
  final String role;
  final Avatar avatar;
  final VerificationInfo verificationInfo;
  final UserRating userRating;
  final TradingProfile tradingProfile;
  final String? age;
  final String? gender;
  final String? nationality;
  final String? address;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TrainerApiModel({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
    required this.role,
    required this.avatar,
    required this.verificationInfo,
    required this.userRating,
    required this.tradingProfile,
    this.age,
    this.gender,
    this.nationality,
    this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TrainerApiModel.fromJson(Map<String, dynamic> json) {
    return TrainerApiModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? '',
      avatar: Avatar.fromJson(json['avatar'] ?? {}),
      verificationInfo: VerificationInfo.fromJson(
        json['verificationInfo'] ?? {},
      ),
      userRating: UserRating.fromJson(json['userRating'] ?? {}),
      tradingProfile: TradingProfile.fromJson(json['treding_profile'] ?? {}),
      age: json['age']?.toString(),
      gender: json['gender'],
      nationality: json['nationality'],
      address: json['address'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'username': username,
      'phone': phone,
      'role': role,
      'avatar': {'public_id': avatar.publicId, 'url': avatar.url},
      'verificationInfo': {
        'verified': verificationInfo.verified,
        'token': verificationInfo.token,
      },
      'userRating': {
        'competence': {
          'star': userRating.competence.star,
          'comment': userRating.competence.comment,
        },
        'punctuality': {
          'star': userRating.punctuality.star,
          'comment': userRating.punctuality.comment,
        },
        'behavior': {
          'star': userRating.behavior.star,
          'comment': userRating.behavior.comment,
        },
      },
      'age': age,
      'gender': gender,
      'nationality': nationality,
      'address': address,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  //* Average Rating
  double get overallRating {
    final competence = userRating.competence.star.toDouble();
    final punctuality = userRating.punctuality.star.toDouble();
    final behavior = userRating.behavior.star.toDouble();
    return (competence + punctuality + behavior) / 3.0;
  }

  //* Success Rate according to average star rating
  double get successRate {
    final competence = userRating.competence.star.toDouble();
    final punctuality = userRating.punctuality.star.toDouble();
    final behavior = userRating.behavior.star.toDouble();
    return ((competence + punctuality + behavior) / 3.0) / 5.0 * 100;
  }

  String get displayAvatarUrl {
    return avatar.url.isNotEmpty ? avatar.url : ''; //! <--- Update here --->
  }

  String get displayName {
    return name.isNotEmpty ? name : username; //! <--- Update here --->
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    username,
    phone,
    role,
    avatar,
    verificationInfo,
    userRating,
    tradingProfile,
    age,
    gender,
    nationality,
    address,
    createdAt,
    updatedAt,
  ];
}
