import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';

import '../../controller/calender_controller.dart';

class EventCardWidget extends StatelessWidget {
  final CalendarEvent event;

  const EventCardWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBGColor, //0xFFEFF4FB
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(event.avatarUrl),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xff090F12),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  event.time,
                  style: const TextStyle(
                    color: Color(0xff1A3E74),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  event.coach,
                  style: const TextStyle(
                    color: Color(0xff1A3E74),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
