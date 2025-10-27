import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/core/widgets/disclaimer_dialog.dart';

class TermsAndDisclaimerDialogScreen extends StatelessWidget {
  const TermsAndDisclaimerDialogScreen({super.key, required this.onAgree});
  final VoidCallback onAgree;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            DisclaimerDialog(
              onAgree: onAgree,
              title: ' Terms and Disclaimers',
              subTitle:
                  'By submitting this application, I acknowledge and agree that:',
              showCheckButton: true,
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              bottomText:
                  'By continuing with my application, I confirm that I have read, understood, and voluntarily agree to all the terms above.\n',
            ),
          ],
        ),
      ),
    );
  }
}
