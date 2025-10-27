class Avatar {
  final String? publicId;
  final String? url;

  Avatar({this.publicId, this.url});

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      publicId: json['public_id'] as String?,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'public_id': publicId, 'url': url};
}
