// lib/features/courses/screens/course_details_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
// import 'package:flutter_ladydenily/dummy_data.dart';
import 'package:flutter_ladydenily/features/course/presentation/widgets/benefits_grid.dart';
import 'package:flutter_ladydenily/features/course/presentation/widgets/demo_card.dart';
import 'package:flutter_ladydenily/features/course/presentation/widgets/enroll_button.dart';
import 'package:flutter_ladydenily/features/course/presentation/widgets/trainer_card.dart';
import 'package:flutter_ladydenily/features/course/presentation/controllers/course_controller.dart';
import 'package:flutter_ladydenily/features/profile/presentation/controller/profile_controller.dart';
import 'package:flutter_ladydenily/features/marketplace/presentation/screens/invoice_webview_screen.dart';

import 'package:get/get.dart';

import '../../models/course.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Course? course = Get.arguments as Course?;
    if (course == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Course Details')),
        body: const Center(child: Text('No course selected')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(course.name),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: Replace CourseHeader signature to accept ApiCourse later. For now simple placeholder header
            Text(course.description, style: const TextStyle(fontSize: 14)),

            const SizedBox(height: 16),

            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[300],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    //! <--- Demo video placeholder - adapt when API provides video preview --->
                    CourseDemoCard(
                      image: 'assets/images/courses_sample.jpg',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              "Trainer",
              style: TextStyle(
                color: AppColors.textColorBlue,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TrainerCard(
              name: course.coordinator.isNotEmpty
                  ? course.coordinator.first.name
                  : 'Trainer',
              image: 'assets/images/trainer1.png',
              stats: course.coordinator.isNotEmpty
                  ? course.coordinator.first.role
                  : 'Role',
            ),
            const SizedBox(height: 16),
            const Text(
              "You will get",
              style: TextStyle(
                color: AppColors.textColorBlue,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            // Placeholder benefits until API provides mapping
            BenefitsGrid(
              benefitsImages: const [
                'assets/images/appraisal_15210198.png',
                'assets/images/community_12575799.png',
                'assets/images/folder_12533516.png',
              ],
              benefits: const ['Community Support', 'Resources', 'Certificate'],
            ),
          ],
        ),
      ),
      bottomNavigationBar: EnrollButton(
        price: course.offerPrice.toDouble(),
        onTap: () async {
          await _handleEnrollNow(course);
        },
      ),
    );
  }

  Future<void> _handleEnrollNow(Course course) async {
    try {
      // Get course controller
      final courseController = Get.find<CourseController>();

      // Get user ID from profile controller
      String userId = '';
      try {
        final profileController = Get.find<ProfileController>();
        userId = profileController.userInfo.value?.id ?? '';
      } catch (_) {
        userId = '';
      }

      if (userId.isEmpty) {
        Get.snackbar('Error', 'Please login to enroll in courses');
        return;
      }

      // Show loading
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      // Create payment
      final paymentDetails = await courseController.createPaymentForCourse(
        userId: userId,
        price: course.offerPrice > 0 ? course.offerPrice : course.price,
        courseId: course.id,
        type: 'course',
      );

      // Dismiss loading
      Get.back();

      if (paymentDetails != null && paymentDetails['invoiceUrl'] != null) {
        final invoiceUrl = paymentDetails['invoiceUrl']!;
        final transactionId = paymentDetails['transactionId'];

        // Open webview with invoiceUrl and transactionId
        Get.to(
          () => InvoiceWebViewScreen(
            invoiceUrl: invoiceUrl,
            transactionId: transactionId,
          ),
        );
      } else {
        // Show error feedback
        Get.snackbar('Payment Error', 'Unable to create invoice.');
      }
    } catch (e) {
      // Dismiss loading if still showing
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.snackbar('Error', 'Failed to process enrollment: $e');
    }
  }
}
