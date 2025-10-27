import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/common/widgets/appbar.dart';
import 'package:flutter_ladydenily/core/extensions/button_extensions.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/features/auth/presentation/controller/auth_controller.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/pin_code.dart';
import '../../../../core/widgets/texts.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key, required this.email});
  final String email;

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final TextEditingController _otpVerify = TextEditingController();

  final _authController = Get.find<AuthController>();

  _submit() {
    _authController.verifyOTP(widget.email, _otpVerify.text);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(title: 'Enter security code'),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: size.height - 32),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  // Center(
                  //   child: CustomText(
                  //     style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                  //     align: TextAlign.center,
                  //   ),
                  // ),
                  const SizedBox(height: 12),

                  // Subtitle
                  CustomText(
                    'Please check your Email for a message with your code. Your code is 6 numbers long.',
                    //align: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Color(0xFF4E4E4E),
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Pin Code Field
                  PinCode(otpController: _otpVerify),

                  const SizedBox(height: 16),

                  Center(
                    child: Text(
                      'Resend code in 43s',
                      style: TextStyle(
                        color: AppColors.titleTextColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Continue Button
                  Obx(
                    () => context.primaryButton(
                      isLoading: _authController.isLoading.value,
                      onPressed: () {
                        _submit();
                      },
                      text: "Verify",
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
