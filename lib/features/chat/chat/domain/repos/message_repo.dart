import 'package:trust_zone/features/chat/chat/data/models/message_model.dart';

abstract class MessageRepository {
  Future<List<MessageModel>> getMessages(int conversationId, int page);
  Future<void> sendMessage(String content, String user2Id, int conversationId);
  //Stream<List<MessageModel>> streamMessages(int conversationId);

}
