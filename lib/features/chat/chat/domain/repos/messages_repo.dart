import 'package:trust_zone/features/chat/chat/data/models/message_model.dart';

abstract class ChatRepository {
  Future<String> createOrGetConversation(String user2Id);
  Future<void> sendMessage(String content, String user2Id);
  Future<List<MessageModel>> getMessages(String conversationId, {int page});
}
