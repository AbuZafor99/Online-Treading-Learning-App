import 'package:flutter_ladydenily/features/auth/presentation/controller/auth_controller.dart';
import 'package:flutter_ladydenily/features/profile/presentation/screens/personal_info_screen.dart';
import 'package:flutter_ladydenily/features/profile/presentation/screens/profile_screen.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../screen/login_screen.dart';

class SplashController extends GetxController {
  late VideoPlayerController videoController;
  final _authController = Get.find<AuthController>();
  var isVideoLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    videoController =
        VideoPlayerController.asset('assets/video/splash_video.mp4')
          ..initialize().then((_) {
            isVideoLoaded.value = true;
            videoController.play();
            videoController.setLooping(false);

            // Play only for 4 seconds, then navigate
            Future.delayed(const Duration(seconds:2), () async {
              final success = await _authController.refreshToken();
              if (Get.isOverlaysOpen) return; // avoid multiple calls
              if (success) {
                Get.offAll(() => HomeScreen());
              } else {
                Get.offAll(() => LoginScreen());
              }
            });
          });
  }

  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }
}
