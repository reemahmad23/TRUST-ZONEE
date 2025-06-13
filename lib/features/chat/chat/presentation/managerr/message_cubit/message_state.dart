import 'package:trust_zone/features/chat/chat/domain/entities/message_entity.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<MessageEntity> messages;

   ChatLoaded(this.messages);

  @override
  List<Object> get props => [messages];
}



class ChatError extends ChatState {
  final String message;

  ChatError(this.message);

  @override
  List<Object?> get props => [message];
}

class MessageSent extends ChatState {}
