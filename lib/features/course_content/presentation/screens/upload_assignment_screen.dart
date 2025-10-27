import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:get/get.dart';

import '../controllers/assignment_controller.dart';

class UploadAssignmentScreen extends StatelessWidget {
  final String assignmentTitle;
  const UploadAssignmentScreen({super.key, required this.assignmentTitle});

  @override
  Widget build(BuildContext context) {
    final AssignmentController controller = Get.put(AssignmentController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(assignmentTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF4FB),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE5EAF2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Lorem ipsum dolor sit amet',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                            Obx(() {
                              final isSubmitted =
                                  controller.status.value == 'Uploaded';
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: isSubmitted
                                      ? const Color(0xFFDFF5E1)
                                      : const Color(0xFFFFF5D9),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  controller.status.value,
                                  style: TextStyle(
                                    color: isSubmitted
                                        ? const Color(0xFF2E7D32)
                                        : Colors.black54,
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam nibh ligula, egestas ac magna vel, porta condimentum orci. Nunc pharetra ante sit amet vehicula finibus.',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => controller.pickAndUpload(),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFE5EAF2),
                          style: BorderStyle.solid,
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.cloud_upload_outlined,
                              color: Colors.blueGrey,
                            ),
                            const SizedBox(height: 8),
                            Obx(
                              () => Text(
                                controller.fileName.value.isEmpty
                                    ? 'Upload Your Work'
                                    : controller.fileName.value,
                                style: const TextStyle(color: Colors.blueGrey),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.buttonColor.withOpacity(0.1),
            ),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    minimumSize: const Size.fromHeight(45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: controller.submit,
                  child: const Text(
                    'Submit Assignment',
                    style: TextStyle(
                      color: Color(0xff1A3E74),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
            
          ),
        ],
      ),
    );
  }
}
