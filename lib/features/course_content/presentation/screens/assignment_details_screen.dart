import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/features/course_content/presentation/widgets/module_all_assignment.dart';
import 'package:get/get.dart';
import '../controllers/assignment_details_controller.dart';

class AssignmentDetailsScreen extends StatelessWidget {
  const AssignmentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AssignmentDetailsController controller = Get.put(
      AssignmentDetailsController(repository: Get.find()),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Assignments",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.modules.isEmpty) {
          return const Center(child: Text('No resources found'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.modules.length,
          itemBuilder: (context, index) {
            final module = controller.modules[index];
            return ModuleAllAssignment(index: index, module: module);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 12);
          },
        );
      }),
    );
  }
}
