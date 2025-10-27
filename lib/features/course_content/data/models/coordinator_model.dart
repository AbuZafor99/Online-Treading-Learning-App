import 'avarter_module.dart';

class Coordinator {
  final String id;
  final String? name;
  final String? email;
  final String? username;
  final String? phone;
  final String? role;
  final Avatar? avatar;

  Coordinator({
    required this.id,
    this.name,
    this.email,
    this.username,
    this.phone,
    this.role,
    this.avatar,
  });

  factory Coordinator.fromJson(Map<String, dynamic> json) {
    return Coordinator(
      id: (json['_id'] ?? json['id'] ?? '') as String,
      name: json['name'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      phone: json['phone'] as String?,
      role: json['role'] as String?,
      avatar: json['avatar'] != null
          ? Avatar.fromJson(json['avatar'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'email': email,
    'username': username,
    'phone': phone,
    'role': role,
    'avatar': avatar?.toJson(),
  };
}
