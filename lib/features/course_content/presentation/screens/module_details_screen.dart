import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/module_details_controller.dart';
import '../controllers/module_controller.dart';
import '../widgets/module_details_card_widget.dart';

class ModulesDetailsScreen extends StatelessWidget {
  const ModulesDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ModulesDetailsController controller =
        Get.find<ModulesDetailsController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arg = Get.arguments as String?;
      if (arg != null && arg.isNotEmpty) {
        controller.getCourseDetails(arg);
        return;
      }

      () async {
        try {
          final moduleController = Get.find<ModuleController>();
          await moduleController.getAllCourses();
          if (moduleController.courses.isNotEmpty) {
            final fallbackId = moduleController.courses.first.id;
            controller.getCourseDetails(fallbackId);
          }
        } catch (e) {
          // error catch will be here
        }
      }();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Modules',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff1A3E74),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.modules.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'No modules available for this course',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Color(0xFF4E4E4E)),
              ),
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.modules.length,
                itemBuilder: (context, index) {
                  final module = controller.modules[index];
                  return ModuleDetailsCardWidget(
                    index: index,
                    module: module,
                    controller: controller,
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
