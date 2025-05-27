import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/create_conversation_usecase.dart';
import '../../../domain/usecases/get_con_usecase.dart';
import 'conversation_state.dart';

class ConversationCubit extends Cubit<ConversationState> {
  final GetConversationsUseCase getConversations;
  final CreateConversationUseCase createConversation;

  ConversationCubit(this.getConversations, this.createConversation)
      : super(ConversationInitial());

  Future<void> fetchConversations() async {
    print("🚀 ConversationCubit: Fetching conversations...");
    emit(ConversationLoading());
    try {
      final conversations = await getConversations();
      print("✅ Fetched ${conversations.length} conversations.");
      for (var convo in conversations) {
        print("📩 Conversation with: ${convo.user2Name}, at: ${convo.createdAt}");
      }
      emit(ConversationLoaded(conversations));
    } catch (e) {
      print("❌ Error fetching conversations: $e");
      emit(ConversationError(e.toString()));
    }
  }

  Future<void> addConversation(String user2Id) async {
    print("➕ Adding conversation with user2Id: $user2Id");
    emit(ConversationLoading());
    try {
      await createConversation(user2Id);
      print("✅ Successfully added conversation with $user2Id");

      final conversations = await getConversations();
      print("🔄 Refreshed conversations list: ${conversations.length} items");
      emit(ConversationLoaded(conversations));
    } catch (e) {
      print("❌ Error adding conversation: $e");
      emit(ConversationError(e.toString()));
    }
  }
}
