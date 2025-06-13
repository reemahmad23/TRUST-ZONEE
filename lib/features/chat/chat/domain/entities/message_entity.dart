class MessageEntity {
  final String id;
  final String conversationId;
  final String content;
  final DateTime sentAt;
  final bool isRead;
  final String senderId;
  final String senderName;
  final String? senderProfilePicture; // 👈 صورة البروفايل

  MessageEntity({
    required this.id,
    required this.conversationId,
    required this.content,
    required this.sentAt,
    required this.isRead,
    required this.senderId,
    required this.senderName,
    this.senderProfilePicture,
  });
}
