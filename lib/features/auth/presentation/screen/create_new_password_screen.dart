import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/common/widgets/app_scaffold.dart';
import 'package:flutter_ladydenily/core/common/widgets/appbar.dart';
import 'package:flutter_ladydenily/core/extensions/button_extensions.dart';
import 'package:flutter_ladydenily/core/extensions/input_decoration_extensions.dart';
import 'package:flutter_ladydenily/core/widgets/texts.dart';
import 'package:flutter_ladydenily/features/auth/presentation/controller/auth_controller.dart';
import 'package:flutx_core/core/validation/validators.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/common/texts/texts.dart';
import '../../../../core/theme/app_colors.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  final String email;
  final String otp;

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmNewPasswordFocus = FocusNode();

  final _authController = Get.find<AuthController>();

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  void _submit() {
    _authController.setNewPass(
      widget.email,
      widget.otp,
      _confirmNewPasswordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: CustomAppBar(title: 'Create new password'),
      body: Column(
        children: [
          CustomText(
            'Select which contact details should we use to reset your password',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),

          SizedBox(height: 16),

          ///Password
          ValueListenableBuilder<bool>(
            valueListenable: _obscurePassword,
            builder: (context, obscure, _) {
              return TextFormField(
                controller: _newPasswordController,
                focusNode: _newPasswordFocus,
                obscureText: obscure,
                textInputAction: TextInputAction.done,
                style: TextStyle(color: AppColors.text),
                decoration: context.primaryInputDecoration.copyWith(
                  hintText: TTexts.newPassword,
                ),

                validator: Validators.password,
                autofillHints: const [AutofillHints.password],
              );
            },
          ),

          SizedBox(height: 16),

          ValueListenableBuilder<bool>(
            valueListenable: _obscurePassword,
            builder: (context, obscure, _) {
              return TextFormField(
                controller: _confirmNewPasswordController,
                focusNode: _confirmNewPasswordFocus,
                obscureText: obscure,
                textInputAction: TextInputAction.done,
                style: TextStyle(color: AppColors.text),
                decoration: context.primaryInputDecoration.copyWith(
                  hintText: TTexts.repeatNewPassword,
                ),

                validator: Validators.password,
                autofillHints: const [AutofillHints.password],
              );
            },
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
