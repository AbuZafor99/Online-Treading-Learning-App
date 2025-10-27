import 'package:equatable/equatable.dart';
import 'assignment_model.dart';

class Module extends Equatable {
  final String id;
  final String name;
  final List<dynamic> video;
  final List<dynamic> resources;
  final List<Assignment> assignments;
  const Module({
    required this.id,
    required this.name,
    required this.video,
    required this.resources,
    required this.assignments,
  });
  factory Module.fromJson(Map<String, dynamic> json) => Module(
    id: json['_id'] ?? '',
    name: json['name'] ?? '',
    video: (json['video'] as List? ?? []),
    resources: (json['resources'] as List? ?? []),
    assignments: (json['assignment'] as List? ?? [])
        .map((e) => Assignment.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
  @override
  List<Object?> get props => [id, name];
}
