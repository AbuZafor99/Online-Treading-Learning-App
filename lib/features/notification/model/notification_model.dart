class NotificationModel {
  final String title;
  final String message;
  final String sender;
  final String time;
  final String imagePath;
  final bool isNew;

  NotificationModel({
    required this.title,
    required this.message,
    required this.sender,
    required this.time,
    required this.imagePath,
    required this.isNew,
  });
}
