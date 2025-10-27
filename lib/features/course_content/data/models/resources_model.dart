class ResourceItem {
  final String id;
  final String? name;
  final String? url;

  ResourceItem({required this.id, this.name, this.url});

  factory ResourceItem.fromJson(Map<String, dynamic> json) {
    return ResourceItem(
      id: (json['_id'] ?? json['id'] ?? '') as String,
      name: json['name'] as String?,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'_id': id, 'name': name, 'url': url};
}
