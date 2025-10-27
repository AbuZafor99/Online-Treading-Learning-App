import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class CustomTextForRefundPolicy extends StatelessWidget {
  const CustomTextForRefundPolicy({
    super.key,
    required this.number,
    required this.text,
  });

  final String number;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 7),
        Text(
          number,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.text,
          ),
        ),
        SizedBox(width: 7),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.text,
            ),
          ),
        ),
      ],
    );
  }
}
