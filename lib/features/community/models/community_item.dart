class CommunityItem {
  final String id;
  final List<String> participants;
  final String? course;
  final bool signal;
  final bool isGroupChat;
  final String title;
  final String? admin;
  final DateTime createdAt;
  final DateTime updatedAt;
  final LastMessage? lastMessage;

  CommunityItem({
    required this.id,
    required this.participants,
    this.course,
    required this.signal,
    required this.isGroupChat,
    required this.title,
    this.admin,
    required this.createdAt,
    required this.updatedAt,
    this.lastMessage,
  });

  factory CommunityItem.fromJson(Map<String, dynamic> json) {
    return CommunityItem(
      id: json['_id'] ?? '',
      participants:
          (json['participants'] as List?)?.map((e) => e.toString()).toList() ??
          [],
      course: json['course']?.toString(),
      signal: json['signal'] ?? false,
      isGroupChat: json['isGroupChat'] ?? false,
      title: json['title'] ?? 'Chat',
      admin: json['admin']?.toString(),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      lastMessage: json['lastMessage'] != null
          ? LastMessage.fromJson(json['lastMessage'])
          : null,
    );
  }

  // Helper getters for UI
  String get displayName => title;

  String get displayLastMessage {
    if (lastMessage == null) return 'No messages yet';

    switch (lastMessage!.contentType.toLowerCase()) {
      case 'text':
        return lastMessage!.content;
      case 'image':
      case 'photo':
        return '📷 Photo';
      case 'file':
      case 'document':
        return '📄 Document';
      default:
        return lastMessage!.content;
    }
  }

  String get displayTimestamp {
    if (lastMessage == null) return '';

    final now = DateTime.now();
    final messageDate = lastMessage!.createdAt;
    final difference = now.difference(messageDate);

    if (difference.inDays == 0) {
      // Today - show time
      final hour = messageDate.hour;
      final minute = messageDate.minute.toString().padLeft(2, '0');
      final period = hour >= 12 ? 'pm' : 'am';
      final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return '$displayHour:$minute $period';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${messageDate.day}/${messageDate.month}/${messageDate.year}';
    }
  }

  MessageType get messageType {
    if (lastMessage == null) return MessageType.text;

    switch (lastMessage!.contentType.toLowerCase()) {
      case 'image':
      case 'photo':
        return MessageType.photo;
      case 'file':
      case 'document':
        return MessageType.document;
      case 'text':
      default:
        return MessageType.text;
    }
  }

  bool get hasUnread => false; // Can be enhanced with unread count from API
}

class LastMessage {
  final String id;
  final String chatId;
  final String? sender;
  final String content;
  final String contentType;
  final List<String> fileUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  LastMessage({
    required this.id,
    required this.chatId,
    this.sender,
    required this.content,
    required this.contentType,
    required this.fileUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      id: json['_id'] ?? '',
      chatId: json['chatId'] ?? '',
      sender: json['sender']?.toString(),
      content: json['content'] ?? '',
      contentType: json['contentType'] ?? 'text',
      fileUrl:
          (json['fileUrl'] as List?)?.map((e) => e.toString()).toList() ?? [],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }
}

enum MessageType { text, photo, document, emoji }
