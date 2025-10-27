import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.titleColor = AppColors.titleTextColor,
    this.titleSize = 24,
    this.titleWeight = FontWeight.w600,
    this.iconColor = AppColors.titleTextColor,
  });

  final String title;
  final VoidCallback? onBack;
  final Color titleColor;
  final double titleSize;
  final FontWeight titleWeight;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leading: IconButton(
        onPressed: onBack,
        icon: Icon(Icons.arrow_back, color: iconColor, size: 24),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontWeight: titleWeight,
          fontSize: titleSize,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
