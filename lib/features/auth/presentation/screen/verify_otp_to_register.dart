// import 'package:flutter/material.dart';
// import 'package:flutter_ladydenily/core/extensions/button_extensions.dart';
// import 'package:flutter_ladydenily/core/theme/app_colors.dart';
// import 'package:flutter_ladydenily/features/auth/presentation/screen/personal_information_screen.dart';
//
// import '../../../../core/widgets/pin_code.dart';
// import '../../../../core/widgets/texts.dart';
//
// class VerifyOtpToRegister extends StatefulWidget{
//   const VerifyOtpToRegister({super.key, required this.email});
//
//   final String email;
//
//   @override
//   State<VerifyOtpToRegister> createState() => _VerifyOtpToRegisterState();
// }
//
// class _VerifyOtpToRegisterState extends State<VerifyOtpToRegister> {
//
//
//
//
//
//   _submit(){
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       appBar: AppBar(title: Text('Enter security code', style: TextStyle(color: AppColors.titleTextColor,
//         fontWeight: FontWeight.w600,
//         fontSize: 24,),)),
//
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
//           child: ConstrainedBox(
//             constraints: BoxConstraints(minHeight: size.height - 32),
//             child: IntrinsicHeight(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Title
//                   // Center(
//                   //   child: CustomText(
//                   //     style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
//                   //     align: TextAlign.center,
//                   //   ),
//                   // ),
//
//                   const SizedBox(height: 12),
//
//                   // Subtitle
//                   CustomText(
//                     'Please check your Email for a message with your code. Your code is 6 numbers long.',
//                     //align: TextAlign.center,
//                     style: theme.textTheme.bodyMedium?.copyWith(color: Color(0xFF4E4E4E), fontSize: 15),
//                   ),
//
//                   const SizedBox(height: 32),
//
//                   // Pin Code Field
//                   PinCode(),
//
//                   const SizedBox(height: 16),
//
//                   // Continue Button
//                   context.primaryButton(
//                     // isLoading: _authController.isLoading,
//                     onPressed: () {PersonalInformationScreen();},
//                     text: "Verify",
//                   ),
//                   const Spacer(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/extensions/button_extensions.dart';
import 'package:get/get.dart';
import '../../../../core/common/widgets/app_scaffold.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/pin_code.dart';
import '../controller/auth_controller.dart';

class OtpVerificationToCompleteRegister extends StatefulWidget {
  const OtpVerificationToCompleteRegister({super.key, required this.email});
  final String email;

  @override
  State<OtpVerificationToCompleteRegister> createState() =>
      _OtpVerificationToCompleteRegisterState();
}

class _OtpVerificationToCompleteRegisterState
    extends State<OtpVerificationToCompleteRegister> {
  final _authController = Get.find<AuthController>();
  final TextEditingController otpController = TextEditingController();

  void _submit() {
    _authController.verifyOTPRegister(widget.email, otpController.text);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 51),

              SizedBox(height: 74),

              Text(
                'Enter OTP',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Enter your receive OTP',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackColor,
                ),
              ),
              SizedBox(height: 32),

              // Obx(() {
              //   final error = _authController.errorMessage.value;
              //   if (error.isNotEmpty) {
              //     return FormErrorMessage(message: error);
              //   }
              //   return const SizedBox.shrink(); // return empty widget
              // }),
              PinCode(otpController: otpController),

              SizedBox(height: 24),

              SizedBox(height: 12),
              Obx(
                () => context.primaryButton(
                  isLoading: _authController.isLoading.value,
                  onPressed: () {
                    _submit();
                  },
                  text: 'Sign up',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
