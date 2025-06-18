class ConversationEntity {
  final int id;
  final String lastMessageContent;
  final DateTime lastMessageAt;
  final String userName;
  final String? profilePicture;
  final String receiverId; // ✅ أضفناه هنا

  ConversationEntity({
    required this.id,
    required this.lastMessageContent,
    required this.lastMessageAt,
    required this.userName,
    this.profilePicture,
    required this.receiverId, // ✅ ضيفي هنا كمان
  });
}
