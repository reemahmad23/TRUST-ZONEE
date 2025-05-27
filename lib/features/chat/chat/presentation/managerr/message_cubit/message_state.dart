
import 'package:trust_zone/features/chat/chat/data/models/message_model.dart';

class ChatState {
  final bool isLoading;
  final List<MessageModel> messages;
  final String? error;

  ChatState({
    required this.isLoading,
    required this.messages,
    this.error,
  });

  factory ChatState.initial() {
    return ChatState(isLoading: false, messages: []);
  }

  ChatState copyWith({
    bool? isLoading,
    List<MessageModel>? messages,
    String? error,
  }) {
    return ChatState(
      isLoading: isLoading ?? this.isLoading,
      messages: messages ?? this.messages,
      error: error,
    );
  }
}
