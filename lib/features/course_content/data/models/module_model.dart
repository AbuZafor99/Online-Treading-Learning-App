class Module {
  final String id;
  final String name;
  final String? description;

  Module({required this.id, required this.name, this.description});

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
    );
  }
}
