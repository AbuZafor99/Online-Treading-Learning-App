import 'package:flutter/material.dart';

class ModuleVideoContainer extends StatelessWidget {
  final String title;
  final String durationText;
  final String imagePath;

  const ModuleVideoContainer({
    super.key,
    this.title = 'Course Name',
    this.durationText = '24 May 2025 | 2h 30m 33s',
    this.imagePath = 'assets/images/courses_sample.jpg',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xffF4F4F4),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  height: 50,
                  width: 72,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    maxLines: 1, // Limit to 1 line
                    overflow:
                        TextOverflow.ellipsis, // Add ellipses for overflow
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff090F12),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    durationText,
                    maxLines: 1, // Limit to 1 line
                    overflow:
                        TextOverflow.ellipsis, // Add ellipses for overflow
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff4E4E4E),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
