import 'dart:convert';
import 'package:trust_zone/features/chat/chat/data/models/message_model.dart';
import 'package:trust_zone/features/chat/chat/domain/entities/message_entity.dart';
import 'package:trust_zone/features/chat/chat/domain/repos/message_repo.dart';
import 'package:trust_zone/utils/chat_service.dart';

class MessageRepositoryImpl implements MessageRepository {
  final ChatApiService api;

  MessageRepositoryImpl(this.api);

  @override
  Future<void> sendMessage(String content, String user2Id, int conversationId) async {
    await api.post('/Message', data: {
      "content": content,
      "user2Id": user2Id,
      "conversationId": conversationId,
    });
  }

  @override
  @override
Future<List<MessageModel>> getMessages(int conversationId, int page) async {
  final response = await api.get('/Message/conversation/$conversationId?page=$page');

  return (response.data as List<dynamic>)
      .map((json) => MessageModel.fromJson(json))
      .toList();
}

}
