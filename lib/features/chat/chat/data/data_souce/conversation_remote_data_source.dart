import 'package:trust_zone/features/chat/chat/data/models/conversation.dart';
import 'package:trust_zone/utils/conversations_api_service.dart';

class ConversationRemoteDataSource {
  final ConversationApiService apiService;
  final String currentUserId;

  ConversationRemoteDataSource(this.apiService, this.currentUserId);

  Future<List<ConversationModel>> getConversations(int page, int pageSize, String token) async {
    final data = await apiService.getConversations(page, pageSize, token);
    return data.map((json) => ConversationModel.fromJson(json, currentUserId)).toList();
  }
}
