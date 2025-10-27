import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgreementController extends GetxController {
  var isChecked = false.obs;
}

class AgreementDialog extends StatelessWidget {
  final AgreementController controller;

  const AgreementDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: const EdgeInsets.only(left: 12),
      content: Stack(
        children: [
          // Main Content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, top: 35, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'By enrolling in this course, you acknowledge and agree to the following:',
                  ),
                  const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      "• This course is for educational purposes only.\n"
                      "• Completion of the course does not guarantee any job placement, or professional qualification unless explicitly stated.\n"
                      "• You are responsible for how you apply the knowledge gained.\n"
                      "• No refunds will be issued once you access course materials (if applicable).\n",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Obx(
                    () => Row(
                      children: [
                        Checkbox(
                          value: controller.isChecked.value,
                          onChanged: (value) {
                            controller.isChecked.value = value ?? false;
                          },
                        ),
                        const Wrap(
                          children: [
                            Text(
                              "I have read and agree to the terms and conditions above.",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Close Button (floating at top-right)
          Positioned(
            top: -15,
            right: -15,
            child: Obx(
              () => Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A3E74),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: IconButton(
                  icon: const Padding(
                    padding: EdgeInsets.only(top: 5, right: 5),
                    child: Icon(Icons.close, color: Colors.white),
                  ),
                  onPressed: controller.isChecked.value
                      ? () => Get.back()
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
