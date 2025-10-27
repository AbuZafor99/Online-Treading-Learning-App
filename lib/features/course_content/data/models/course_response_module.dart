import 'class_module_module.dart';
import 'coordinator_model.dart';

class CourseResponse {
  final String id;
  final String? name;
  final String? description;
  final String? photo;
  final double? price;
  final double? offerPrice;
  final List<Coordinator> coordinator;
  final List<Module> modules;
  final List<dynamic> enrolled;

  CourseResponse({
    required this.id,
    this.name,
    this.description,
    this.photo,
    this.price,
    this.offerPrice,
    this.coordinator = const [],
    this.modules = const [],
    this.enrolled = const [],
  });

  factory CourseResponse.fromJson(Map<String, dynamic> json) {
    return CourseResponse(
      id: (json['_id'] ?? json['id'] ?? '') as String,
      name: json['name'] as String?,
      description: json['description'] as String?,
      photo: json['photo'] as String?,
      price: (json['price'] is num)
          ? (json['price'] as num).toDouble()
          : (json['price'] != null
                ? double.tryParse('${json['price']}')
                : null),
      offerPrice: (json['offerPrice'] is num)
          ? (json['offerPrice'] as num).toDouble()
          : (json['offerPrice'] != null
                ? double.tryParse('${json['offerPrice']}')
                : null),
      coordinator:
          (json['coordinator'] as List<dynamic>?)
              ?.map((e) => Coordinator.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <Coordinator>[],
      modules:
          (json['modules'] as List<dynamic>?)
              ?.map((e) => Module.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <Module>[],
      enrolled: (json['enrolled'] as List<dynamic>?) ?? <dynamic>[],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'description': description,
    'photo': photo,
    'price': price,
    'offerPrice': offerPrice,
    'coordinator': coordinator.map((c) => c.toJson()).toList(),
    'modules': modules.map((m) => m.toJson()).toList(),
    'enrolled': enrolled,
  };
}
