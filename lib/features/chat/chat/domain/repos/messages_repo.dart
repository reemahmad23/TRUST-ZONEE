import 'package:trust_zone/features/chat/chat/data/models/conversation.dart';
import 'package:trust_zone/features/chat/chat/domain/entities/message_entity.dart';

abstract class ChatRepository {
  Future<ConversationModel> getConversationBetween(String user2Id);
  Future<ConversationModel> createConversation(String user2Id);
  Future<List<MessageEntity>> getMessages(int conversationId, int page);
  Future<void> sendMessage(String content, String user2Id, int conversationId);
}
