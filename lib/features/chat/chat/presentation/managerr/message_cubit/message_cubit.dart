import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trust_zone/features/chat/chat/presentation/managerr/message_cubit/message_state.dart';
import 'package:trust_zone/utils/chat_service.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatApiService apiService;

  ChatCubit(this.apiService) : super(ChatState.initial());

  Future<void> loadMessages(String conversationId) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final messages = await apiService.getMessages(conversationId: conversationId);
      emit(state.copyWith(isLoading: false, messages: messages));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> sendMessage(String content, String user2Id, String conversationId) async {
    try {
      await apiService.sendMessage(content: content, user2Id: user2Id);
      loadMessages(conversationId);
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
