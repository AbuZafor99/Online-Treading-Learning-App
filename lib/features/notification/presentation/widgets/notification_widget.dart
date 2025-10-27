import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  final String title;
  final String message;
  final String sender;
  final String time;
  final String imagePath;
  final bool isNew;

  const NotificationWidget({
    super.key,
    required this.title,
    required this.message,
    required this.sender,
    required this.time,
    required this.imagePath,
    required this.isNew,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 23,
                    backgroundImage: AssetImage(imagePath),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message,
                            style: TextStyle(
                              color: Color(0xFF4E4E4E),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "$sender • $time",
                            style: TextStyle(
                              color: Color(0xFFA8A8A8),
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: Divider(height: 1, color: Color(0xFFE0E0E0), thickness: 1),
        ),
      ],
    );
  }
}
