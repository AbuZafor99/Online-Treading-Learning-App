import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../auth/presentation/screen/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to LoginScreen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => const LoginScreen());
    });

    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.png', // path to your logo
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
