import 'package:equatable/equatable.dart';

class Avatar extends Equatable {
  final String publicId;
  final String url;
  const Avatar({required this.publicId, required this.url});
  factory Avatar.fromJson(Map<String, dynamic> json) =>
      Avatar(publicId: json['public_id'] ?? '', url: json['url'] ?? '');
  @override
  List<Object?> get props => [publicId, url];
}
