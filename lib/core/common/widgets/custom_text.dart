import 'package:flutter/cupertino.dart';

import '../../theme/app_colors.dart';
import '../../widgets/texts.dart';

class CustomTextForPrivacy extends StatelessWidget {
  const CustomTextForPrivacy({
    super.key,
    this.title,
    required this.description,
  });

  final String? title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          CustomText(
            title!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
            ),
          ),
        SizedBox(height: 8),
        CustomText(
          description,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.text,
          ),
        ),
      ],
    );
  }
}
