import 'package:flutter/material.dart';

class ModuleAssignmentItem extends StatelessWidget {
  final String title;
  final String dueDate; // e.g. "Due: 30 Sep 2025"
  final VoidCallback onTap;
  final Color? backgroundColor;

  const ModuleAssignmentItem({
    super.key,
    required this.title,
    required this.dueDate,
    required this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: backgroundColor ?? const Color(0xffE8ECF1),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff090F12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
