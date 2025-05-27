class ConversationEntity {
  final int id;
  final String user1Id;
  final String user2Id;
  final DateTime createdAt;
  final String user1Name;
  final String user2Name;

  ConversationEntity({
    required this.id,
    required this.user1Id,
    required this.user2Id,
    required this.createdAt,
    required this.user1Name,
    required this.user2Name,
  });
}
