class MessageModel {
  final String id;
  final String content;
  final String senderId;
  final DateTime timestamp;

  MessageModel({
    required this.id,
    required this.content,
    required this.senderId,
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'].toString(),
      content: json['content'],
      senderId: json['senderId'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
