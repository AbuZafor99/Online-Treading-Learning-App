import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.put(SplashController());

    return Scaffold(
      body: Center(
        child: Obx(() {
          if (controller.isVideoLoaded.value) {
            return AspectRatio(
              aspectRatio: controller.videoController.value.aspectRatio,
              child: VideoPlayer(controller.videoController),
            );
          } else {
            return const CircularProgressIndicator();
          }
        }),
      ),
    );
  }
}
