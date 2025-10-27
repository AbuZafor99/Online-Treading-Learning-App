import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/recording_details_controller.dart';
import '../widgets/module_all_videos.dart';

class RecordingDetailsScreen extends StatelessWidget {
  const RecordingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RecordingDetailsController controller = Get.put(
      RecordingDetailsController(repository: Get.find()),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Recordings",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(() {
        debugPrint('Modules: ${controller.modules}');
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.modules.isEmpty) {
          return const Center(child: Text('No recordings found'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.modules.length,
          itemBuilder: (context, index) {
            final module = controller.modules[index];
            return ModuleAllVideos(index: index, module: module);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 12);
          },
        );
      }),
    );
  }
}
