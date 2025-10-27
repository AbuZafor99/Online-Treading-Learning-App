import 'package:equatable/equatable.dart';

class RatingCategory extends Equatable {
  final int star;
  final String comment;
  const RatingCategory({required this.star, required this.comment});
  factory RatingCategory.fromJson(Map<String, dynamic> json) =>
      RatingCategory(star: json['star'] ?? 0, comment: json['comment'] ?? '');
  @override
  List<Object?> get props => [star, comment];
}
