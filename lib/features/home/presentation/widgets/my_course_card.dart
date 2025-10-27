import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:get/get.dart';
import '../../../course/models/course.dart';
import '../../../course_content/presentation/screens/module_screen.dart';

class MyCourseCard extends StatelessWidget {
  final Course course;

  const MyCourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 96),
      // padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 2)],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            child: (() {
              final imageUrl = course.photo == null
                  ? ''
                  : course.photo is String
                  ? course.photo as String
                  : (course.photo as dynamic).url ?? '';
              
              // Fallback widget for when image fails to load
              Widget fallbackWidget = SizedBox(
                width: 120,
                height: 96,
                child: Container(
                  color: Colors.grey.shade200,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.school,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
              );

              if (imageUrl.isEmpty) {
                return fallbackWidget;
              }
              
              if (imageUrl.startsWith('http')) {
                return Image.network(
                  imageUrl,
                  width: 120,
                  height: 96,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return fallbackWidget;
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      width: 120,
                      height: 96,
                      child: Container(
                        color: Colors.grey.shade200,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Image.asset(
                  imageUrl,
                  width: 120,
                  height: 96,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return fallbackWidget;
                  },
                );
              }
            }()),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 8.0),
                          child: Text(
                            course.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          width: 80,
                          child: Text(
                            course.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${course.modules.length} Modules',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Spacer(),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 72,
                            maxWidth: 110,
                          ),
                          child: SizedBox(
                            height: 36,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(
                                  () => ModuleScreen(courseId: course.id),
                                  arguments: course.id,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow.shade700,
                                foregroundColor: AppColors.textColorBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 6,
                                ),
                                textStyle: const TextStyle(fontSize: 12),
                              ),
                              child: const FittedBox(child: Text("Resume")),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
