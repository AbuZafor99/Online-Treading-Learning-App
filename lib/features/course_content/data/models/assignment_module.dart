class AssignmentItem {
  final String id;
  final String? title;
  final String? start;
  final List<dynamic> submission;

  AssignmentItem({
    required this.id,
    this.title,
    this.start,
    this.submission = const [],
  });

  factory AssignmentItem.fromJson(Map<String, dynamic> json) {
    return AssignmentItem(
      id: (json['_id'] ?? json['id'] ?? '') as String,
      title: json['title'] as String?,
      start: json['start'] as String?,
      submission: (json['submission'] as List<dynamic>?) ?? <dynamic>[],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'title': title,
    'start': start,
    'submission': submission,
  };
}
