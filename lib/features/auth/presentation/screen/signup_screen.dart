import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/common/images/images.dart';
import 'package:flutter_ladydenily/core/common/widgets/app_scaffold.dart';
import 'package:flutter_ladydenily/core/widgets/texts.dart';
import 'package:get/get.dart';

import '../../../../core/common/widgets/signin_signup_header.dart';
import '../../../../core/widgets/social_button.dart';
import '../widget/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              TLoginHeader(
                image: ImagesString.loginLogo,
                title: 'Get Started',
                subTitle: 'by creating a free account.',
              ),

              ///Form
              SignupForm(),

              SizedBox(height: 22),

              ///Footer
              TSocialButton(),

              SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomText('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Sign in',
                      style: TextStyle(color: Color(0xFF1A3E74), fontSize: 15),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
