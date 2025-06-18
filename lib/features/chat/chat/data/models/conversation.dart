import 'package:trust_zone/features/chat/chat/domain/entities/conversation_entity.dart';

class ConversationModel extends ConversationEntity {
  ConversationModel({
    required int id,
    required String lastMessageContent,
    required DateTime lastMessageAt,
    required String userName,
    required String receiverId,
    String? profilePicture,
  }) : super(
          id: id,
          lastMessageContent: lastMessageContent,
          lastMessageAt: lastMessageAt,
          userName: userName,
          receiverId: receiverId,
          profilePicture: profilePicture,
        );

  factory ConversationModel.fromJson(Map<String, dynamic> json, String currentUserId) {
    final isUser1 = json["user1Id"] == currentUserId;
    final user = isUser1 ? json["user2"] : json["user1"];

    return ConversationModel(
      id: json["id"],
      lastMessageContent: json["lastMessageContent"] ?? '',
      lastMessageAt: DateTime.parse(json["lastMessageAt"]),
      userName: user["userName"] ?? 'Unknown',
      receiverId: user["id"] ?? '',
      profilePicture: (user["profilePicture"] as String?)?.trim().isEmpty ?? true
          ? null
          : user["profilePicture"],
    );
  }

  factory ConversationModel.fromEntity(ConversationEntity entity) {
    return ConversationModel(
      id: entity.id,
      lastMessageContent: entity.lastMessageContent,
      lastMessageAt: entity.lastMessageAt,
      userName: entity.userName,
      receiverId: entity.receiverId,
      profilePicture: entity.profilePicture,
    );
  }
}
