import 'package:dio/dio.dart';

class ConversationApiService {
  final Dio dio;

  ConversationApiService(this.dio);

  Future<List<dynamic>> getUserConversations({int page = 1, int pageSize = 20}) async {
    final response = await dio.get(
      'https://trustzone.azurewebsites.net/api/Conversation/user',
      queryParameters: {
        'page': page,
        'pageSize': pageSize,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer your_token_here',
          'accept': 'application/json',
        },
      ),
    );

    return response.data;
  }
}