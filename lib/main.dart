import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/init/app_initializer.dart';
import 'package:flutter_ladydenily/core/theme/app_theme.dart';
import 'package:flutter_ladydenily/features/auth/presentation/screen/splash_screen.dart';
import 'package:get/get.dart';

void main() async {
  await AppInitializer.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.light,
      home: SplashScreen(),
    );
  }
}
