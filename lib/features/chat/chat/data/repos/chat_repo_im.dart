// import 'package:trust_zone/features/chat/chat/data/data_souce/chat_data_souce.dart';
// import 'package:trust_zone/features/chat/chat/data/models/conversation.dart';
// import 'package:trust_zone/features/chat/chat/data/models/message_model.dart';
// import 'package:trust_zone/features/chat/chat/domain/repos/messages_repo.dart';

// class ChatRepositoryImpl implements ChatRepository {
//   final ChatRemoteDataSource remote;
//   ChatRepositoryImpl(this.remote);

//   @override
//   Future<ConversationModel> getConversationBetween(String user2Id) =>
//       remote.getConversationBetween(user2Id);

//   @override
//   Future<ConversationModel> createConversation(String user2Id) =>
//       remote.createConversation(user2Id);

//   @override
//   Future<List<MessageModel>> getMessages(int conversationId, int page) =>
//       remote.getMessages(conversationId, page);

//   @override
//   Future<void> sendMessage(String content, String user2Id) =>
//       remote.sendMessage(content, user2Id);
// }
