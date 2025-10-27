import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/features/course/presentation/screens/coure_details_screen.dart';
import 'package:flutter_ladydenily/features/course/presentation/controllers/course_controller.dart';
import 'package:flutter_ladydenily/features/profile/presentation/controller/profile_controller.dart';
import 'package:flutter_ladydenily/features/marketplace/presentation/screens/invoice_webview_screen.dart';
import 'package:get/get.dart';
import '../../models/course.dart';

class CourseDetailsCard extends StatelessWidget {
  final Course course;

  const CourseDetailsCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallCard = constraints.maxWidth < 200;
        final horizontalPadding = isSmallCard ? 8.0 : 12.0;

        return InkWell(
          onTap: () {
            Get.to(() => const CourseDetailsScreen(), arguments: course);
          },
          child: Card(
            color: AppColors.cardBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageWithBadge(),
                const SizedBox(height: 8),
                _buildCourseTitle(horizontalPadding),
                const SizedBox(height: 4),
                _buildCourseSubtitle(horizontalPadding),
                const SizedBox(height: 8),
                _buildCourseMetadata(horizontalPadding),
                const SizedBox(height: 8),
                _buildPriceAndButton(horizontalPadding, isSmallCard),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageWithBadge() {
    final imageUrl = course.photo?.url;
    final hasNetworkImage = imageUrl != null && imageUrl.isNotEmpty;

    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: hasNetworkImage
              ? Image.network(
                  imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildFallbackImage(),
                )
              : _buildFallbackImage(),
        ),
        Positioned(top: 12, left: 12, child: _Badge(text: "Freshman")),
      ],
    );
  }

  Widget _buildFallbackImage() {
    return Container(
      height: 180,
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: const Icon(Icons.image, size: 40, color: Colors.grey),
    );
  }

  Widget _buildCourseTitle(double horizontalPadding) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Text(
        course.name,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildCourseSubtitle(double horizontalPadding) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Text(
        course.description,
        style: const TextStyle(
          fontSize: 14,
          color: Color.fromARGB(255, 97, 97, 97),
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildCourseMetadata(double horizontalPadding) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        children: [
          _MetadataItem(
            icon: Icons.folder_open_outlined,
            text: '${course.modules.length} Modules',
          ),
          _MetadataItem(
            icon: Icons.play_circle_outline,
            text:
                '${course.modules.fold(0, (prev, module) => prev + module.video.length)} Videos',
          ),
        ],
      ),
    );
  }

  Widget _buildPriceAndButton(double horizontalPadding, bool isSmallCard) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: isSmallCard
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPrice(),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _handleEnrollNow();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow.shade700,
                      foregroundColor: AppColors.textColorBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: const Text(
                      'Enroll Now',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: _buildPrice()),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    await _handleEnrollNow();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow.shade700,
                    foregroundColor: AppColors.textColorBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Enroll Now'),
                ),
              ],
            ),
    );
  }

  Future<void> _handleEnrollNow() async {
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

  Widget _buildPrice() {
    final hasOffer = course.offerPrice < course.price && course.offerPrice > 0;
    if (hasOffer) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '\$${course.price}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: AppColors.hintText,
              decoration: TextDecoration.lineThrough,
              decorationColor: Colors.red,
              decorationStyle: TextDecorationStyle.solid,
              decorationThickness: 2.0,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '\$${course.offerPrice}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: AppColors.textColorBlue,
            ),
          ),
        ],
      );
    } else {
      return Text(
        '\$${course.price}',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
          color: AppColors.textColorBlue,
        ),
      );
    }
  }
}

class _Badge extends StatelessWidget {
  final String text;

  const _Badge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(color: AppColors.textColorBlue, fontSize: 12),
      ),
    );
  }
}

class _MetadataItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _MetadataItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.grey[700]),
        const SizedBox(width: 3),
        Flexible(
          child: Text(
            text,
            style: TextStyle(color: Colors.grey[700], fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
