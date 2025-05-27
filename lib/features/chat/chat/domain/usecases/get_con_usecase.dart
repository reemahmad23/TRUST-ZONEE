
import '../entities/conversation_entity.dart';
import '../repos/message_repo.dart';

class GetConversationsUseCase {
  final ConversationRepository repository;

  GetConversationsUseCase(this.repository);

  Future<List<ConversationEntity>> call() {
    return repository.getUserConversations();
  }
}
