import 'package:equatable/equatable.dart';

// Core Course aggregate root
import 'photo_model.dart';
import 'coordinator_user_model.dart';
import 'module_model.dart';

class Course extends Equatable {
  final String id;
  final String name;
  final String description;
  final Photo? photo;
  final num price;
  final num offerPrice;
  final List<CoordinatorUser> coordinator;
  final List<Module> modules;
  final List<dynamic> enrolled;
  final int version;

  const Course({
    required this.id,
    required this.name,
    required this.description,
    required this.photo,
    required this.price,
    required this.offerPrice,
    required this.coordinator,
    required this.modules,
    required this.enrolled,
    required this.version,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json['_id'] ?? '',
    name: json['name'] ?? '',
    description: json['description'] ?? '',
    photo: json['photo'] != null && json['photo'] is Map<String, dynamic>
        ? Photo.fromJson(json['photo'])
        : json['photo'] != null && json['photo'] is String
        ? Photo(publicId: '', url: json['photo'])
        : null,
    price: json['price'] ?? 0,
    offerPrice: json['offerPrice'] ?? 0,
    coordinator: (json['coordinator'] as List? ?? [])
        .map((e) => CoordinatorUser.fromJson(e as Map<String, dynamic>))
        .toList(),
    modules: (json['modules'] as List? ?? [])
        .map((e) => Module.fromJson(e as Map<String, dynamic>))
        .toList(),
    enrolled: (json['enrolled'] as List? ?? []),
    version: json['__v'] ?? 0,
  );

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    offerPrice,
    coordinator,
    modules,
    enrolled,
    version,
  ];
}
