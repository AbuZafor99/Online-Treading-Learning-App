import 'package:flutter/material.dart';
import 'package:flutx_core/flutx_core.dart';

import '../theme/app_colors.dart';

extension InputDecorationExtensions on BuildContext {
  InputDecoration get primaryInputDecoration => InputDecoration(
    filled: true,
    suffixIconColor: AppColors.hintText,
    fillColor: Color(0xFFE8ECF1),
    contentPadding: AppSizes.paddingMd.all,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingSm.size),
      borderSide: BorderSide(color: Colors.transparent),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingSm.size),
      borderSide: BorderSide(color: Colors.transparent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingSm.size),
      borderSide: BorderSide(color: Colors.transparent, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingSm.size),
      borderSide: BorderSide(color: Colors.transparent, width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.paddingSm.size),
      borderSide: BorderSide(color: Colors.transparent, width: 1.5),
    ),
    hintStyle: TextStyle(
      color: AppColors.hintText,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    labelStyle: TextStyle(
      color: AppColors.hintText,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    errorStyle: TextStyle(
      color: AppColors.errorRedColor,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  );
}
