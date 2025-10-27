import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../controllers/ video_controller.dart';


class VideoControls extends StatelessWidget {
  final VideoPlayerGetxController controller;
  const VideoControls({super.key, required this.controller});

  String _formatDuration(Duration position) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(position.inMinutes.remainder(60));
    final seconds = twoDigits(position.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final videoCtrl = controller.videoController;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        color: Colors.black.withOpacity(0.5),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✅ Progress bar
            SizedBox(
              width: double.infinity,
              child: VideoProgressIndicator(
                videoCtrl,
                allowScrubbing: true,
                colors: VideoProgressColors(
                  playedColor: Colors.redAccent,
                  bufferedColor: Colors.white38,
                  backgroundColor: Colors.white10,
                ),
              ),
            ),
            const SizedBox(height: 4),

            // ✅ Bottom control buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Time info - Use ValueListenableBuilder for VideoPlayerController
                  ValueListenableBuilder(
                    valueListenable: videoCtrl,
                    builder: (context, VideoPlayerValue value, child) {
                      return Text(
                        "${_formatDuration(value.position)} / ${_formatDuration(value.duration)}",
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      );
                    },
                  ),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() => IconButton(
                        icon: Icon(
                          controller.isPlaying.value
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: controller.togglePlayPause,
                      )),
                      IconButton(
                        onPressed: controller.toggleFullScreen,
                        icon: Obx(() => Icon(
                          controller.isFullScreen.value
                              ? Icons.fullscreen_exit
                              : Icons.fullscreen,
                          color: Colors.white,
                          size: 24,
                        )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
