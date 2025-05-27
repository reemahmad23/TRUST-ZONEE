import 'package:trust_zone/features/chat/chat/data/models/message_model.dart';
import 'package:trust_zone/features/chat/chat/domain/repos/messages_repo.dart';
import 'package:trust_zone/utils/chat_service.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatApiService chatApiService;

  ChatRepositoryImpl(this.chatApiService);

  @override
  Future<String> createOrGetConversation(String user2Id) {
    return chatApiService.createOrGetConversation(user2Id);
  }

  @override
  Future<void> sendMessage(String content, String user2Id) {
    return chatApiService.sendMessage(content: content, user2Id: user2Id);
  }

  @override
  Future<List<MessageModel>> getMessages(String conversationId, {int page = 1}) {
    return chatApiService.getMessages(conversationId: conversationId, page: page);
  }
}
