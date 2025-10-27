import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/common/widgets/app_scaffold.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/features/course_content/presentation/widgets/tab_bar.dart';
import 'package:get/get.dart';
import '../../data/models/assignment_module.dart';
import '../../data/models/class_module_module.dart';
import '../../data/models/resources_model.dart';
import '../../data/models/video_model.dart';
import '../widgets/module_resource_item.dart';
import '../widgets/module_assignment_item.dart';

class EachModulesDetailsScreen extends StatelessWidget {
  EachModulesDetailsScreen({Key? key}) : super(key: key);

  final RxInt _selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    final arg = Get.arguments;
    Module? module;
    int? moduleIndex;

    if (arg is Map && arg.containsKey('module')) {
      final m = arg['module'];
      final idx = arg['index'];
      try {
        if (m is Module) {
          module = m;
        } else if (m is Map) {
          module = Module.fromJson(Map<String, dynamic>.from(m));
        }
      } catch (_) {
        module = null;
      }
      if (idx is int)
        moduleIndex = idx;
      else if (idx is String)
        moduleIndex = int.tryParse(idx);
    } else if (arg is Module) {
      module = arg;
    } else if (arg is Map<String, dynamic>) {
      try {
        module = Module.fromJson(arg);
      } catch (_) {
        module = null;
      }
    } else if (arg is Map) {
      try {
        module = Module.fromJson(Map<String, dynamic>.from(arg));
      } catch (_) {
        module = null;
      }
    }

    if (module == null) {
      return AppScaffold(
        appBar: AppBar(title: const Text('Module')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'No module data provided. Please open a module from the Modules list.',
            ),
          ),
        ),
      );
    }

    final List<VideoItem> recordings = module.video;
    final List<ResourceItem> resources = module.resources;
    final List<AssignmentItem> assignments = module.assignment;

    final String topTitle = (moduleIndex != null)
        ? 'Module-${moduleIndex + 1}'
        : 'Module';
    final String topDescription = module.name ?? 'No description available';

    return AppScaffold(
      appBar: AppBar(
        title: Text(
          topTitle,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.appBarTitle,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Text(
              topDescription,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Color(0xFF090F12),
              ),
            ),
          ),
          const SizedBox(height: 12),

          Obx(() {
            final idx = _selectedIndex.value;
            String topCountText = '';
            if (idx == 0) {
              topCountText = '${recordings.length} Class Recordings';
            } else if (idx == 1) {
              topCountText = '${resources.length} Resources';
            } else {
              topCountText = '${assignments.length} Assignments';
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/video-recorder.png",
                    width: 18,
                    height: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    topCountText,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff4E4E4E),
                    ),
                  ),
                ],
              ),
            );
          }),

          Obx(
            () => ModuleTabBar(
              selectedIndex: _selectedIndex.value,
              onTabChanged: (index) => _selectedIndex.value = index,
            ),
          ),

          const SizedBox(height: 12),

          Expanded(
            child: Obx(() {
              final idx = _selectedIndex.value;
              if (idx == 0) {
                return ListView.builder(
                  itemCount: recordings.length,
                  itemBuilder: (context, index) {
                    final v = recordings[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 72,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xffF4F4F4),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/images/courses_sample.jpg',
                                width: 72,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  v.name ?? 'Recording ${index + 1}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff090F12),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  v.no != null ? 'No: ${v.no}' : (v.url ?? ''),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff4E4E4E),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (idx == 1) {
                return ListView.builder(
                  itemCount: resources.length,
                  itemBuilder: (context, index) {
                    final r = resources[index];
                    return ModuleResourceItem(
                      backgroundColor: Color(0xffE8ECF1),
                      title: r.name ?? 'Resource ${index + 1}',
                      onTap: () {
                        // TODO: implement resource open later
                      },
                    );
                  },
                );
              } else {
                return ListView.builder(
                  itemCount: assignments.length,
                  itemBuilder: (context, index) {
                    final a = assignments[index];
                    return ModuleAssignmentItem(
                      title: a.title ?? 'Assignment ${index + 1}',
                      dueDate: a.start ?? '',
                      onTap: () {
                        // TODO: implement assignment open later
                      },
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
