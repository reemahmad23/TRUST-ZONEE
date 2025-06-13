// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:trust_zone/features/chat/chat/data/models/conversation.dart';
// import 'package:trust_zone/features/chat/chat/domain/usecases/create_conversation_usecase.dart';
// import 'package:trust_zone/features/chat/chat/domain/usecases/get_con_between_usecase.dart';
// import 'package:trust_zone/features/chat/chat/domain/usecases/get_messages.dart';
// import 'package:trust_zone/features/chat/chat/domain/usecases/send_messages.dart';
// import 'package:trust_zone/features/chat/chat/presentation/managerr/conversation_cubit/conversation_state.dart';

// class ChatCubit extends Cubit<ChatState> {
//   final GetConversationBetweenUseCase getConversation;
//   final CreateConversationUseCase createConversation;
//   final GetMessagesUseCase getMessages;
//   final SendMessageUseCase sendMessage;

//   ChatCubit({
//     required this.getConversation,
//     required this.createConversation,
//     required this.getMessages,
//     required this.sendMessage,
//   }) : super(ChatInitial());

//   late ConversationModel conversation;

//   Future<void> loadChat(String receiverId) async {
//     // emit(ChatLoading());
//     try {
//       // try {
//         conversation = await getConversation(receiverId);
//       } catch (e) {
//         conversation = await createConversation(receiverId);
//       }

//       final messages = await getMessages(conversation.id, 1);
//       emit(ChatLoaded(messages, conversation));
//     } catch (e) {
//       emit(ChatError(e.toString()));
//     }
//   }

//   Future<void> send(String content, String receiverId) async {
//     try {
//       await sendMessage(content, receiverId);
//       final messages = await getMessages(conversation.id, 1);
//       emit(ChatLoaded(messages, conversation));
//     } catch (e) {
//       emit(ChatError(e.toString()));
//     }
//   }
// }
