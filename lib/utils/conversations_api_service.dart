import 'package:dio/dio.dart';

class ConversationApiService {
  final Dio dio;

  ConversationApiService(this.dio);

  Future<List<Map<String, dynamic>>> getConversations(int page, int pageSize, String token) async {
    final response = await dio.get(
      'https://trustzone.azurewebsites.net/api/Conversation/user',
      queryParameters: {'page': page, 'pageSize': pageSize},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return List<Map<String, dynamic>>.from(response.data);
  }
}
