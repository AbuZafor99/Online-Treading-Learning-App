import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/core/widgets/disclaimer_dialog.dart';

class DisclaimerDialogScreen extends StatelessWidget {
  const DisclaimerDialogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              DisclaimerDialog(
                title:
                    'By enrolling in this course, you acknowledge and agree to the following:',
                showCheckButton: false,
                style: TextStyle(color: AppColors.text),
                onAgree: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
