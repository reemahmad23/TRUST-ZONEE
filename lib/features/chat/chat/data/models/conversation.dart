import '../../domain/entities/conversation_entity.dart';

class ConversationModel extends ConversationEntity {
  ConversationModel({
    required super.id,
    required super.user1Id,
    required super.user2Id,
    required super.createdAt,
    required super.user1Name,
    required super.user2Name,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'],
      user1Id: json['user1Id'],
      user2Id: json['user2Id'],
      createdAt: DateTime.parse(json['createdAt']),
      user1Name: json['user1']['userName'],
      user2Name: json['user2']['userName'],
    );
  }
}
