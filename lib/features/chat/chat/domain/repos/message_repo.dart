
import '../entities/conversation_entity.dart';

abstract class ConversationRepository {
  Future<List<ConversationEntity>> getUserConversations();
  Future<void> createConversation(String user2Id);
}
