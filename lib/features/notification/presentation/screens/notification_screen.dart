import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import '../../model/notification_model.dart';
import '../widgets/notification_widget.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final List<NotificationModel> notifications = [
    NotificationModel(
      title: "New Course Available",
      message:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. New course on Technical Analysis has been added.",
      sender: "Admin",
      time: "5 min",
      imagePath: "assets/images/Image.png",
      isNew: true,
    ),
    NotificationModel(
      title: "Live Session Reminder",
      message:
          "Your live session on Stock Market Basics starts in 30 minutes. Don't forget to join!",
      sender: "System",
      time: "15 min",
      imagePath: "assets/images/Image.png",
      isNew: true,
    ),
    NotificationModel(
      title: "Assignment Graded",
      message:
          "Your assignment on Technical Indicators has been graded. Check your results now.",
      sender: "Instructor",
      time: "25 min",
      imagePath: "assets/images/Image.png",
      isNew: true,
    ),
    NotificationModel(
      title: "New Resources Added",
      message:
          "New study materials and resources have been added to Module 3. Check them out!",
      sender: "Admin",
      time: "40 min",
      imagePath: "assets/images/Image.png",
      isNew: true,
    ),
    NotificationModel(
      title: "Community Update",
      message:
          "New discussion started in the community forum. Join the conversation now.",
      sender: "Community",
      time: "55 min",
      imagePath: "assets/images/Image.png",
      isNew: true,
    ),
    NotificationModel(
      title: "Certificate Ready",
      message:
          "Your course certificate is now available for download. Congratulations on completing the course!",
      sender: "System",
      time: "2 hours",
      imagePath: "assets/images/Image.png",
      isNew: false,
    ),
    NotificationModel(
      title: "Quiz Results",
      message:
          "Your quiz results for Module 2 are now available. Check your performance and review the answers.",
      sender: "Instructor",
      time: "1 day",
      imagePath: "assets/images/Image.png",
      isNew: false,
    ),
    NotificationModel(
      title: "Payment Successful",
      message:
          "Your payment for the Advanced Course has been processed successfully. Enjoy learning!",
      sender: "Billing",
      time: "2 days",
      imagePath: "assets/images/Image.png",
      isNew: false,
    ),
    NotificationModel(
      title: "Course Update",
      message:
          "Module 4 has been updated with new content and examples. Please review the updated materials.",
      sender: "Admin",
      time: "3 days",
      imagePath: "assets/images/Image.png",
      isNew: false,
    ),
    NotificationModel(
      title: "Welcome Message",
      message:
          "Welcome to Technical Analysis Mastery! We're excited to have you on board. Start your learning journey now.",
      sender: "Admin",
      time: "1 week",
      imagePath: "assets/images/Image.png",
      isNew: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Separate new and earlier notifications
    final newNotifications = notifications.where((n) => n.isNew).toList();
    final earlierNotifications = notifications.where((n) => !n.isNew).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notification",
          style: TextStyle(
            color: AppColors.appBarTitle,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // New Notifications Section
              if (newNotifications.isNotEmpty) ...[
                Text(
                  "New",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xff090F12),
                  ),
                ),
                const SizedBox(height: 10),
                ...newNotifications
                    .map(
                      (notification) => NotificationWidget(
                        title: notification.title,
                        message: notification.message,
                        sender: notification.sender,
                        time: notification.time,
                        imagePath: notification.imagePath,
                        isNew: notification.isNew,
                      ),
                    )
                    .toList(),
              ],

              // Earlier Notifications Section
              if (earlierNotifications.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text(
                  "Earlier",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xff090F12),
                  ),
                ),
                const SizedBox(height: 10),
                ...earlierNotifications
                    .map(
                      (notification) => NotificationWidget(
                        title: notification.title,
                        message: notification.message,
                        sender: notification.sender,
                        time: notification.time,
                        imagePath: notification.imagePath,
                        isNew: notification.isNew,
                      ),
                    )
                    .toList(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
