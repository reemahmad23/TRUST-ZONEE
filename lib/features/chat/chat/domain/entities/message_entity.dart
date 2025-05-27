class Message {
  final String id;
  final String conversationId;
  final String content;
  final String senderId;
  final String receiverId;
  final DateTime sentAt;

  Message({
    required this.id,
    required this.conversationId,
    required this.content,
    required this.senderId,
    required this.receiverId,
    required this.sentAt,
  });
}
