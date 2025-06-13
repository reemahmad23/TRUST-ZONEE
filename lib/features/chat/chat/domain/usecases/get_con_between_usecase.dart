import 'package:trust_zone/features/chat/chat/data/models/conversation.dart';
import 'package:trust_zone/features/chat/chat/domain/repos/messages_repo.dart';

class GetConversationBetweenUseCase {
  final ChatRepository repo;
  GetConversationBetweenUseCase(this.repo);

  Future<ConversationModel> call(String user2Id) => repo.getConversationBetween(user2Id);
}
