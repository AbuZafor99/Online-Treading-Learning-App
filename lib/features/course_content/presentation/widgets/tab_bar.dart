import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';

class ModuleTabBar extends StatelessWidget {
  final Function(int) onTabChanged;
  final int selectedIndex;

  const ModuleTabBar({
    super.key,
    required this.onTabChanged,
    this.selectedIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Recordings Tab
          Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: selectedIndex == 0
                      ? const Color(0xFFFFB347)
                      : Color(0xffE8ECF1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Recordings',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBarTitle,
                  ),
                ),
              ),
            ),
          ),
          // Resources Tab
          Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(1),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: selectedIndex == 1
                      ? const Color(0xFFFFB347)
                      : Color(0xffE8ECF1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Resources',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBarTitle,
                  ),
                ),
              ),
            ),
          ),
          // Assignment Tab
          Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(2),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: selectedIndex == 2
                      ? const Color(0xFFFFB347)
                      : Color(0xffE8ECF1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Assignment',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.appBarTitle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
