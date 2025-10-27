import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/features/course_content/presentation/screens/upload_assignment_screen.dart';
import 'package:flutter_ladydenily/features/course_content/presentation/widgets/module_assignment_item.dart';
import 'package:get/get.dart';
import '../../data/models/class_module_module.dart';

class ModuleAllAssignment extends StatelessWidget {
  final Module module;
  final int index;

  const ModuleAllAssignment({
    super.key,
    required this.module,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 8.0),
      color: const Color(0xffE8ECF1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 8),
            child: Text(
              'Module ${index + 1}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(color: Colors.grey[400], thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: module.assignment.length,
              itemBuilder: (context, assignmentIndex) {
                final assignment = module.assignment[assignmentIndex];
                return ModuleAssignmentItem(
                  onTap: () => Get.to(
                    () => UploadAssignmentScreen(
                      assignmentTitle:
                          assignment.title ?? 'No assignment available',
                    ),
                  ),
                  backgroundColor: const Color(0xffffffff),
                  title: assignment.title ?? 'No assignment available',
                  dueDate: assignment.start != null
                      ? 'Start: ${assignment.start}'
                      : 'Start: Not specified',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
