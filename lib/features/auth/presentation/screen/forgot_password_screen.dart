import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/common/widgets/app_scaffold.dart';
import 'package:flutter_ladydenily/core/common/widgets/appbar.dart';
import 'package:flutter_ladydenily/core/extensions/button_extensions.dart';
import 'package:flutter_ladydenily/core/extensions/input_decoration_extensions.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/core/widgets/texts.dart';
import 'package:flutter_ladydenily/features/auth/presentation/controller/auth_controller.dart';
import 'package:flutx_core/core/validation/validators.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../core/common/texts/texts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final FocusNode _emailFocus = FocusNode();

  final _authController = Get.find<AuthController>();

  final TextEditingController _emailController = TextEditingController();

  void _submit() {
    _authController.resetPass(_emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: CustomAppBar(title: 'Forgot Password'),

      body: Column(
        children: [
          CustomText(
            'Select which contact details should we use to reset your password',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),

          SizedBox(height: 16),

          TextFormField(
            controller: _emailController,
            focusNode: _emailFocus,
            keyboardType: TextInputType.emailAddress,
            decoration: context.primaryInputDecoration.copyWith(
              hintText: TTexts.email,
              prefixIcon: Icon(
                Icons.email_outlined,
                color: AppColors.emailIconColor,
              ),
            ),
            validator: Validators.email,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_emailFocus),
            autofillHints: const [AutofillHints.email],
          ),

          SizedBox(height: 20),

          Obx(
            () => context.primaryButton(
              isLoading: _authController.isLoading.value,
              onPressed: () {
                _submit();
              },
              text: 'Continue',
            ),
          ),
        ],
      ),
    );
  }
}
