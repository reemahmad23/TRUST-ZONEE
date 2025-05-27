

import '../../domain/entities/conversation_entity.dart';
import '../../domain/repos/message_repo.dart';
import '../data_souce/chat_data_souce.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  final ConversationRemoteDataSource remoteDataSource;

  ConversationRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ConversationEntity>> getUserConversations() {
    return remoteDataSource.getUserConversations();
  }

  @override
  Future<void> createConversation(String user2Id) {
    return remoteDataSource.createConversation(user2Id);
  }
}
