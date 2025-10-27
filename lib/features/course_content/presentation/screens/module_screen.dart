import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/features/course_content/presentation/screens/module_details_screen.dart';
import 'package:flutter_ladydenily/features/course_content/presentation/screens/recording_details_screen.dart';
import 'package:flutter_ladydenily/features/quiz/presentation/screens/quiz_screen.dart';
import 'package:get/get.dart';
import '../widgets/items_widgets.dart';
import '../controllers/module_controller.dart';
import 'assignment_details_screen.dart';
import 'resources_details_screen.dart';

class ModuleScreen extends StatelessWidget {
  final String courseId;
  const ModuleScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    final ModuleController controller = Get.find<ModuleController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      String? targetCourseId = courseId.isNotEmpty
          ? courseId
          : Get.arguments as String?;

      // print('[ModuleScreen] Constructor courseId: $courseId');
      // print('[ModuleScreen] Get.arguments: ${Get.arguments}');
      // print('[ModuleScreen] Target courseId: $targetCourseId');

      if (targetCourseId != null &&
          targetCourseId.isNotEmpty &&
          (controller.rxSelectedCourse.value == null ||
              controller.rxSelectedCourse.value!.id != targetCourseId)) {
        // print('[ModuleScreen] Loading course data for ID: $targetCourseId');
        controller.loadCourseById(targetCourseId);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final name = controller.rxSelectedCourse.value?.name ?? 'Course';
          return Text(
            name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xff1A3E74),
            ),
          );
        }),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Column(
                  children: [
                    ItemWidget(
                      index: 0,
                      title: 'Modules',
                      ImagePath: "assets/images/periodic-table_2183917.png",
                      isSelected: controller.selectedIndex == 0,
                      onTap: () {
                        controller.selectItem(0);

                        // Ensure courseId is valid
                        final courseId = controller.rxSelectedCourse.value?.id;
                        // '68bd11bb31fb45d7d231ff17'; // Default courseId for testing

                        Get.to(
                          () => const ModulesDetailsScreen(),
                          arguments: courseId,
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    ItemWidget(
                      index: 1,
                      title: 'Recordings',
                      ImagePath: "assets/images/folder_12533516.png",
                      isSelected: controller.selectedIndex == 1,
                      onTap: () {
                        controller.selectItem(1);
                        Get.to(
                          () => RecordingDetailsScreen(),
                          arguments: courseId,
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    ItemWidget(
                      index: 2,
                      title: 'Resources',
                      ImagePath: "assets/images/folder_15237642.png",
                      isSelected: controller.selectedIndex == 2,
                      onTap: () {
                        controller.selectItem(2);
                        // module id should be passed here
                        Get.to(() => ResourcesScreen(), arguments: courseId);
                      },
                    ),
                    const SizedBox(height: 12),
                    ItemWidget(
                      index: 3,
                      title: 'Community',
                      ImagePath: "assets/images/community_12575799.png",
                      isSelected: controller.selectedIndex == 3,
                      onTap: () => controller.selectItem(3),
                    ),
                    const SizedBox(height: 12),
                    ItemWidget(
                      index: 4,
                      title: 'Assignment',
                      ImagePath: "assets/images/appraisal_15210198.png",
                      isSelected: controller.selectedIndex == 4,
                      onTap: () {
                        controller.selectItem(4);
                        Get.to(
                          () => AssignmentDetailsScreen(),
                          arguments: courseId,
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    ItemWidget(
                      index: 5,
                      title: 'Quiz',
                      ImagePath: "assets/images/quiz_8586995.png",
                      isSelected: controller.selectedIndex == 5,
                      onTap: () {
                        controller.selectItem(5);
                        Get.to(() => QuizScreen());
                      },
                    ),
                    const SizedBox(height: 12),
                    ItemWidget(
                      index: 6,
                      title: 'Certificate',
                      ImagePath: "assets/images/legal-document_1890467.png",
                      isSelected: controller.selectedIndex == 6,
                      onTap: () => controller.selectItem(6),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
