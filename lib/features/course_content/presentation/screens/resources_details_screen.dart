import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/resource_details_controller.dart';
import '../widgets/module_all_resources.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ResourcesController controller = Get.put(
      ResourcesController(repository: Get.find()),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Resources",
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
            return ModuleAllResources(index: index, module: module);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 12);
          },
        );
      }),
    );
  }
}
