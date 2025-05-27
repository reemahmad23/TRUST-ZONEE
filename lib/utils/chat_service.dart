import 'package:dio/dio.dart';
import 'package:trust_zone/features/chat/chat/data/models/message_model.dart';

class ChatApiService {
  final Dio _dio;

  ChatApiService(this._dio);

  Future<String> createOrGetConversation(String user2Id) async {
    final response = await _dio.post('/api/Conversation', data: {
      "user2Id": user2Id,
    });

    return response.data['conversationId'].toString();
  }

  Future<void> sendMessage({
    required String content,
    required String user2Id,
  }) async {
    await _dio.post('/api/Message', data: {
      "content": content,
      "user2Id": user2Id,
    });
  }

  Future<List<MessageModel>> getMessages({
    required String conversationId,
    int page = 1,
  }) async {
    final response = await _dio.get('/api/Message/conversation/$conversationId', queryParameters: {
      'page': page,
    });

    return (response.data as List)
        .map((e) => MessageModel.fromJson(e))
        .toList();
  }
}
