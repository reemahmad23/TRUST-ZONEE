// conversation_model.dart
class ConversationModel {
  final int id;
  final String user1Id;
  final String user2Id;

  ConversationModel({
    required this.id,
    required this.user1Id,
    required this.user2Id,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'],
      user1Id: json['user1Id'],
      user2Id: json['user2Id'],
    );
  }
}
