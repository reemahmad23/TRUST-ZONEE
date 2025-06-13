import 'package:trust_zone/features/chat/chat/domain/repos/message_repo.dart';

class SendMessageUseCase {
  final MessageRepository repository;

  SendMessageUseCase(this.repository);

Future<void> call(String content, String user2Id, int conversationId) {
  return repository.sendMessage(content, user2Id, conversationId);
}
}


