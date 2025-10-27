import 'package:flutter/material.dart';
import '../../data/models/class_module_module.dart';
import '../../data/models/module_video_container.dart';

class ModuleAllVideos extends StatelessWidget {
  final int index;
  final Module module; // Accept module data

  const ModuleAllVideos({super.key, required this.index, required this.module});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffE8ECF1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 2, left: 12),
            child: Text("Module ${index + 1}", textAlign: TextAlign.start),
          ),
          Divider(color: Colors.grey[400], thickness: 1),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: ListView.builder(
              itemBuilder: (context, videoIndex) {
                final video = module.video[videoIndex];
                return ModuleVideoContainer(
                  title: video.name ?? 'Video ${videoIndex + 1}',
                  durationText: video.url ?? '',
                  imagePath: 'assets/images/courses_sample.jpg',
                );
              },
              itemCount: module.video.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}
