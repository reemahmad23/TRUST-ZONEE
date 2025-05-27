import 'package:dio/dio.dart';

import '../models/conversation.dart';


abstract class ConversationRemoteDataSource {
  Future<List<ConversationModel>> getUserConversations();
  Future<void> createConversation(String user2Id);
}

class ConversationRemoteDataSourceImpl implements ConversationRemoteDataSource {
  final Dio dio;
  final String token;

  ConversationRemoteDataSourceImpl(this.dio, this.token);

  @override
  Future<List<ConversationModel>> getUserConversations() async {
    final response = await dio.get(
      'https://trustzone.azurewebsites.net/api/Conversation/user?page=1&pageSize=20',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
        'accept': 'text/plain',
      }),
    );
    return (response.data as List)
        .map((json) => ConversationModel.fromJson(json))
        .toList();
  }

  @override
  Future<void> createConversation(String user2Id) async {
    await dio.post(
      'https://trustzone.azurewebsites.net/api/Conversation',
      data: {'user2Id': user2Id},
      options: Options(headers: {
        'Authorization': 'Bearer $token',
        'accept': 'text/plain',
      }),
    );
  }
}
