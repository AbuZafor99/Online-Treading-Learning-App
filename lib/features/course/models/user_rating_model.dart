import 'package:equatable/equatable.dart';
import 'rating_category_model.dart';

class UserRating extends Equatable {
  final RatingCategory competence;
  final RatingCategory punctuality;
  final RatingCategory behavior;
  const UserRating({
    required this.competence,
    required this.punctuality,
    required this.behavior,
  });
  factory UserRating.fromJson(Map<String, dynamic> json) => UserRating(
    competence: RatingCategory.fromJson(json['competence'] ?? const {}),
    punctuality: RatingCategory.fromJson(json['punctuality'] ?? const {}),
    behavior: RatingCategory.fromJson(json['behavior'] ?? const {}),
  );
  @override
  List<Object?> get props => [competence, punctuality, behavior];
}
