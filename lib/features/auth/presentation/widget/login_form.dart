import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/common/texts/texts.dart';
import 'package:flutter_ladydenily/core/extensions/button_extensions.dart';
import 'package:flutter_ladydenily/core/extensions/input_decoration_extensions.dart';
import 'package:flutter_ladydenily/features/auth/presentation/screen/forgot_password_screen.dart';
import 'package:flutx_core/core/validation/validators.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../controller/auth_controller.dart';

class TLoginForm extends StatefulWidget {
  const TLoginForm({super.key});

  @override
  State<TLoginForm> createState() => _TLoginFormState();
}

class _TLoginFormState extends State<TLoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _authController = Get.find<AuthController>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  void _submit() {
    // if (!_formKey.currentState!.validate()) return;
    _authController.login(_emailController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            ///Email
            TextFormField(
              controller: _emailController,
              focusNode: _emailFocus,
              keyboardType: TextInputType.emailAddress,
              decoration: context.primaryInputDecoration.copyWith(
                hintText: TTexts.email,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Color(0xFF666666),
                ),
              ),
              validator: Validators.email,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_passwordFocus),
              autofillHints: const [AutofillHints.email],
            ),

            SizedBox(height: 24),

            ///Password
            ValueListenableBuilder<bool>(
              valueListenable: _obscurePassword,
              builder: (context, obscure, _) {
                return TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  obscureText: obscure,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(color: AppColors.text),
                  decoration: context.primaryInputDecoration.copyWith(
                    hintText: TTexts.password,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Color(0xFF666666),
                    ),
                  ),

                  validator: Validators.password,
                  autofillHints: const [AutofillHints.password],
                );
              },
            ),

            SizedBox(height: 8),

            ///forget password
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.to(() => ForgotPasswordScreen());
                  },
                  child: Text(
                    TTexts.forgetPassword,
                    style: TextStyle(color: Color(0xFF1A3E74), fontSize: 14),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            ///Sign in
            context.primaryButton(onPressed: _submit, text: 'Login'),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
