class VideoItem {
  final String id;
  final String? name;
  final int? no;
  final String? url;

  VideoItem({required this.id, this.name, this.no, this.url});

  factory VideoItem.fromJson(Map<String, dynamic> json) {
    return VideoItem(
      id: (json['_id'] ?? json['id'] ?? '') as String,
      name: json['name'] as String?,
      no: json['no'] is int
          ? json['no'] as int
          : (json['no'] is num ? (json['no'] as num).toInt() : null),
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'no': no,
    'url': url,
  };
}
