
import '../repos/message_repo.dart';

class CreateConversationUseCase {
  final ConversationRepository repository;

  CreateConversationUseCase(this.repository);

  Future<void> call(String user2Id) {
    return repository.createConversation(user2Id);
  }
}

