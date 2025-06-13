import 'package:trust_zone/features/chat/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.id,
    required super.conversationId,
    required super.content,
    required super.sentAt,
    required super.isRead,
    required super.senderId,
    required super.senderName,
    super.senderProfilePicture,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'].toString(),
      conversationId: json['conversationId'].toString(),
      content: json['content'],
      sentAt: DateTime.parse(json['sentAt']),
      isRead: json['isRead'],
      senderId: json['sender']['id'].toString(),
      senderName: json['sender']['userName'],
      senderProfilePicture: json['sender']['profilePicture'],
    );
  }

  MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      conversationId: conversationId,
      content: content,
      sentAt: sentAt,
      isRead: isRead,
      senderId: senderId,
      senderName: senderName,
      senderProfilePicture: senderProfilePicture,
    );
  }
}
