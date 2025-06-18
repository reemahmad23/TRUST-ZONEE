import 'package:trust_zone/features/chat/chat/data/data_souce/conversation_remote_data_source.dart';
import 'package:trust_zone/features/chat/chat/domain/entities/conversation_entity.dart';
import 'package:trust_zone/features/chat/chat/domain/repos/conversation_repo.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  final ConversationRemoteDataSource remoteDataSource;

  ConversationRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ConversationEntity>> getConversations(int page, int pageSize, String token) async {
    final models = await remoteDataSource.getConversations(page, pageSize, token);
    return models.map((model) => ConversationEntity(
      id: model.id,
      userName: model.userName,
      lastMessageContent: model.lastMessageContent,
      lastMessageAt: model.lastMessageAt,
      profilePicture: model.profilePicture,
      receiverId: model.receiverId,
    )).toList();
  }
}
