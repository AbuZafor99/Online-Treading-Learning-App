import 'package:flutter/material.dart';

class ProfileOptionTile extends StatelessWidget {
  final String? iconPath;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;
  final Color? arrowColor;

  const ProfileOptionTile({
    super.key,
    this.iconPath,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.textColor,
    this.arrowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.grey.shade100,
      child: ListTile(
        leading: iconPath != null
            ? Image.asset(
                iconPath!,
                width: 24,
                height: 24,
                color: iconColor ?? Colors.grey.shade700,
              )
            : SizedBox(width: 24, height: 24),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, color: textColor ?? Colors.black),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: arrowColor ?? Colors.grey.shade700,
        ),
        onTap: onTap,
      ),
    );
  }
}
