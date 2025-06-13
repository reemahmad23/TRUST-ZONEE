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
Future<List<MessageModel>> getMessages(int conversationId, int page) async {
  final response = await api.get('/Message/conversation/$conversationId?page=$page');
  return (response.data as List)
      .map((json) => MessageModel.fromJson(json))
      .toList();
}


  // @override
  // Stream<List<MessageModel>> streamMessages(int conversationId) async* {
  //   while (true) {
  //     final response = await api.get('/Message/conversation/$conversationId?page=1');
  //     final messages = (response.data as List)
  //         .map((json) => MessageModel.fromJson(json))
  //         .toList();
  //     yield messages;
  //     await Future.delayed(Duration(seconds: 2)); // زي polling لكن داخل Stream
  //   }
  // }
}
