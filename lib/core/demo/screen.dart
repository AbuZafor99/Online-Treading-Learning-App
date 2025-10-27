import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/extensions/button_extensions.dart';
import 'package:flutter_ladydenily/core/extensions/input_decoration_extensions.dart';
import 'package:flutx_core/flutx_core.dart';

import '../common/widgets/app_scaffold.dart';
import '../theme/app_colors.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email field
            TextFormField(
              controller: _emailController,
              focusNode: _emailFocus,
              keyboardType: TextInputType.emailAddress,
              decoration: context.primaryInputDecoration.copyWith(
                hintText: 'Enter your Email',
                // prefixIcon: AppFormIcon(assetPath: AssetsPath.icons.email),
              ),
              validator: Validators.email,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_passwordFocus),
              autofillHints: const [AutofillHints.email],
            ),

            Gap.h16,

            /// [Text field] Password
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
                    hintText: "Enter your Password",
                    // prefixIcon: AppFormIcon(assetPath: AssetsPath.icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.hintText,
                      ),
                      onPressed: () => _obscurePassword.value = !obscure,
                    ),
                  ),

                  validator: Validators.password,
                  autofillHints: const [AutofillHints.password],
                  // onFieldSubmitted: (_) => _submit(),
                );
              },
            ),
            Gap.h16,

            context.primaryButton(
              // isLoading: _authController.isLoading,
              onPressed: () {},
              text: "Sign In",
            ),

            Gap.h12,

            context.secondaryButton(
              // isLoading: _authController.isLoading,
              onPressed: () {},
              text: "Sign In",
            ),
          ],
        ),
      ),
    );
  }
}
