import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/features/community/models/community_item.dart';

class CommunityListItem extends StatelessWidget {
  final CommunityItem item;
  final VoidCallback? onTap;

  const CommunityListItem({super.key, required this.item, this.onTap});

  Widget _buildMessagePreview() {
    switch (item.messageType) {
      case MessageType.photo:
        return Row(
          children: [
            Icon(Icons.photo, size: 16, color: AppColors.buttonColor),
            const SizedBox(width: 4),
            Text(
              item.displayLastMessage,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ],
        );
      case MessageType.document:
        return Row(
          children: [
            Icon(Icons.insert_drive_file, size: 16, color: Colors.brown[400]),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                item.displayLastMessage,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      case MessageType.emoji:
      case MessageType.text:
        return Row(
          children: [
            if (item.messageType == MessageType.text)
              Icon(Icons.check, size: 16, color: AppColors.buttonColor),
            if (item.messageType == MessageType.text) const SizedBox(width: 4),
            Flexible(
              child: Text(
                item.displayLastMessage,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _getAvatarColor(item.displayName),
              ),
              child: Center(
                child: Text(
                  _getInitials(item.displayName),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.displayName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  _buildMessagePreview(),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Timestamp and unread indicator
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.displayTimestamp,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                if (item.hasUnread)
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: AppColors.buttonColor,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final words = name.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return name.substring(0, 1).toUpperCase();
  }

  Color _getAvatarColor(String name) {
    // Generate color based on name for consistency
    final colors = [
      const Color(0xFF1A3E74), // Blue
      const Color(0xFFEF1A26), // Red
      const Color(0xFF00A86B), // Green
      const Color(0xFF4A5568), // Gray
      const Color(0xFF9333EA), // Purple
      const Color(0xFFEA580C), // Orange
    ];

    final index = name.hashCode % colors.length;
    return colors[index.abs()];
  }
}
