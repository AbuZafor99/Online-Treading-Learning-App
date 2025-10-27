import 'rating_model.dart';

class UserRating {
  final Rating competence;
  final Rating punctuality;
  final Rating behavior;

  UserRating({
    required this.competence,
    required this.punctuality,
    required this.behavior,
  });

  factory UserRating.fromJson(Map<String, dynamic> json) => UserRating(
    competence: Rating.fromJson(json["competence"]),
    punctuality: Rating.fromJson(json["punctuality"]),
    behavior: Rating.fromJson(json["behavior"]),
  );

  Map<String, dynamic> toJson() => {
    "competence": competence.toJson(),
    "punctuality": punctuality.toJson(),
    "behavior": behavior.toJson(),
  };
}
