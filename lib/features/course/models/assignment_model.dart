import 'package:equatable/equatable.dart';

class Assignment extends Equatable {
  final String title;
  final String start;
  final List<dynamic> submission;
  final String id;
  const Assignment({
    required this.title,
    required this.start,
    required this.submission,
    required this.id,
  });
  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
    title: json['title'] ?? '',
    start: json['start'] ?? '',
    submission: (json['submission'] as List? ?? []),
    id: json['_id'] ?? '',
  );
  @override
  List<Object?> get props => [id, title];
}
