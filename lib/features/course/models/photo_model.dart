import 'package:equatable/equatable.dart';

class Photo extends Equatable {
  final String? publicId;
  final String? url;
  const Photo({this.publicId, this.url});
  factory Photo.fromJson(Map<String, dynamic> json) =>
      Photo(publicId: json['public_id'], url: json['url']);
  @override
  List<Object?> get props => [publicId, url];
}
