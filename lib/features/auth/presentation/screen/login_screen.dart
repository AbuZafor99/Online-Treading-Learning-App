import 'package:flutter/material.dart';

import 'package:flutter_ladydenily/core/common/widgets/app_scaffold.dart';
import 'package:flutter_ladydenily/core/widgets/texts.dart';
import 'package:flutter_ladydenily/features/auth/presentation/screen/signup_screen.dart';
import 'package:get/get.dart';

import '../../../../core/common/images/images.dart';
import '../../../../core/common/widgets/signin_signup_header.dart';
import '../../../../core/widgets/social_button.dart';
import '../widget/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AppScaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80),
                TLoginHeader(
                  image: ImagesString.loginLogo,
                  title: 'Welcome back',
                  subTitle: 'sign in to access your account',
                ),

                ///Form
                TLoginForm(),

                SizedBox(height: 22),

                ///Footer
                TSocialButton(),

                SizedBox(height: 50),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomText('Don’t have an account?'),
                    TextButton(
                      onPressed: () {
                        /// [Navigation to Sigup]
                        // Go.sailTo(
                        //   SignupScreen(),
                        //   transition: TransitionType.slideLeft,
                        // );
                        Get.to(() => SignupScreen());
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFF1A3E74),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
