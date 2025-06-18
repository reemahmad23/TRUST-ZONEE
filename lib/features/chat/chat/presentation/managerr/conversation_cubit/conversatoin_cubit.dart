import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trust_zone/features/chat/chat/data/models/conversation.dart';
import 'package:trust_zone/features/chat/chat/domain/entities/conversation_entity.dart';
import 'package:trust_zone/features/chat/chat/domain/usecases/get_conversation_usecase.dart';
import 'package:trust_zone/features/chat/chat/presentation/managerr/conversation_cubit/conversation_state.dart';
import 'package:trust_zone/utils/token_helper.dart';

class ConversationCubit extends Cubit<ConversationState> {
  final GetConversationsUseCase getConversationsUseCase;

  ConversationCubit(this.getConversationsUseCase) : super(ConversationInitial());

  Future<void> fetchConversations(int page, int pageSize) async {
    emit(ConversationLoading());
    try {
      final token = await TokenHelper.getToken();
      final currentUserId = await TokenHelper.getUserId();

      if (token == null || currentUserId == null) {
        emit(ConversationError('Token or User ID not found.'));
        return;
      }

      final result = await getConversationsUseCase(page, pageSize, token);

      final conversations = result
    .map<ConversationModel>((entity) => ConversationModel.fromEntity(entity))
    .toList();


      final conversationEntities = conversations
          .map<ConversationEntity>((model) => model as ConversationEntity)
          .toList();

      emit(ConversationLoaded(conversationEntities));
    } catch (e) {
      emit(ConversationError('Failed to fetch conversations: $e'));
    }
  }
}
