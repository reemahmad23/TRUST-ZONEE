import 'package:trust_zone/features/chat/chat/domain/entities/conversation_entity.dart';
import 'package:trust_zone/features/chat/chat/domain/repos/conversation_repo.dart';

class GetConversationsUseCase {
  final ConversationRepository repository;

  GetConversationsUseCase(this.repository);

  Future<List<ConversationEntity>> call(int page, int pageSize, String token) {
    return repository.getConversations(page, pageSize, token);
  }
}
