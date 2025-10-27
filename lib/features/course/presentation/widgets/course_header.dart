// lib/features/courses/widgets/course_header.dart

import 'package:flutter/material.dart';

import '../../models/course.dart';

class CourseHeader extends StatelessWidget {
  final Course course;

  const CourseHeader({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          course.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          course.description,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ],
    );
  }
}
