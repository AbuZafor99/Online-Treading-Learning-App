import 'assignment_module.dart';
import 'resources_model.dart';
import 'video_model.dart';

class Module {
  final String id;
  final String? name;
  final List<VideoItem> video;
  final List<ResourceItem> resources;
  final List<AssignmentItem> assignment;

  Module({
    required this.id,
    this.name,
    this.video = const [],
    this.resources = const [],
    this.assignment = const [],
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: (json['_id'] ?? json['id'] ?? '') as String,
      name: json['name'] as String?,
      video:
          (json['video'] as List<dynamic>?)
              ?.map((e) => VideoItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <VideoItem>[],
      resources:
          (json['resources'] as List<dynamic>?)
              ?.map((e) => ResourceItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <ResourceItem>[],
      assignment:
          (json['assignment'] as List<dynamic>?)
              ?.map((e) => AssignmentItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <AssignmentItem>[],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'video': video.map((v) => v.toJson()).toList(),
    'resources': resources.map((r) => r.toJson()).toList(),
    'assignment': assignment.map((a) => a.toJson()).toList(),
  };
}
