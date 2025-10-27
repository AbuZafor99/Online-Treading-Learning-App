import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/class_module_module.dart';
import '../controllers/module_details_controller.dart';
import '../screens/each_modules_details_screen.dart';

class ModuleDetailsCardWidget extends StatelessWidget {
  final int index;
  final Module module;
  final ModulesDetailsController controller;

  const ModuleDetailsCardWidget({
    Key? key,
    required this.index,
    required this.module,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Pass plain json map + index to avoid runtime type mismatch across routes
        Get.to(
          () => EachModulesDetailsScreen(),
          arguments: {'module': module.toJson(), 'index': index},
        );
      },
      child: Card(
        color: Color(0xffE8ECF1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0XFF1A3E74),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Module-${index + 1}',
                      style: const TextStyle(
                        color: Color(0xFFEFC227),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Obx(
                    () => Row(
                      children: [
                        Text(
                          controller.isModuleCompleted(module.id)
                              ? 'Marked as Complete'
                              : 'Mark as Complete',
                          style: TextStyle(
                            fontSize: 12,
                            color: controller.isModuleCompleted(module.id)
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Checkbox(
                          value: controller.isModuleCompleted(module.id),
                          onChanged: (_) =>
                              controller.toggleModuleCompletion(module.id),
                          activeColor: const Color(0XFF1A3E74),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                module.name ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.video_camera_front_outlined,
                    size: 18,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${module.video.length} Class Recordings',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
