import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../controllers/ video_controller.dart';
import '../widgets/video_controls.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;
  const VideoPlayerScreen({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VideoPlayerGetxController(videoUrl));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(() => controller.isFullScreen.value
            ? const SizedBox.shrink()
            : AppBar(
          title: const Text("Play Video"),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: () => controller.showSettings(context),
            ),
            IconButton(
              icon: Obx(() => Icon(
                controller.isFullScreen.value
                    ? Icons.fullscreen_exit
                    : Icons.fullscreen,
                color: Colors.white,
              )),
              onPressed: controller.toggleFullScreen,
            ),
          ],
        )),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          // Schedule orientation handling after the current build is complete
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.handleOrientation(orientation);
          });
          return SafeArea(
            child: Obx(() {
              if (!controller.isInitialized.value) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }
              final videoCtrl = controller.videoController;
              return Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: videoCtrl.value.aspectRatio > 0
                          ? videoCtrl.value.aspectRatio
                          : 16 / 9,
                      child: VideoPlayer(videoCtrl),
                    ),
                    // Overlay play/pause icon
                    GestureDetector(
                      onTap: controller.togglePlayPause,
                      child: Obx(() => Icon(
                        controller.isPlaying.value
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_fill,
                        color: Colors.white.withOpacity(0.8),
                        size: 70,
                      )),
                    ),
                    VideoControls(controller: controller),
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
