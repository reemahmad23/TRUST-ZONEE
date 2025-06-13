// import 'package:trust_zone/features/chat/chat/data/models/conversation.dart';
// import 'package:trust_zone/features/chat/chat/data/models/message_model.dart';
// import 'package:trust_zone/utils/chat_service.dart';

// class ChatRemoteDataSource {
//   final ChatApiService apiService;
//   ChatRemoteDataSource(this.apiService);

//   Future<ConversationModel> getConversationBetween(String user2Id) async {
//     final response = await apiService.get(
//         '/api/Conversation/between?user2Id=$user2Id');
//     return ConversationModel.fromJson(response);
//   }

//   Future<ConversationModel> createConversation(String user2Id) async {
//     final response = await apiService.post('/api/Conversation', data: {
//       'user2Id': user2Id,
//     });
//     return ConversationModel.fromJson(response);
//   }

//   Future<List<MessageModel>> getMessages(int conversationId, int page) async {
//     final response = await apiService.get(
//         '/api/Message/conversation/$conversationId?page=$page');
//     return (response as List)
//         .map((e) => MessageModel.fromJson(e))
//         .toList();
//   }

//   Future<void> sendMessage(String content, String user2Id) async {
//     await apiService.post('/api/Message', data: {
//       'content': content,
//       'user2Id': user2Id,
//     });
//   }
// }
