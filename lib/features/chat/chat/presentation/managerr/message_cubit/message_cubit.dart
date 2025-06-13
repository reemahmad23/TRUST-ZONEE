import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trust_zone/features/chat/chat/domain/entities/message_entity.dart';
import 'package:trust_zone/features/chat/chat/domain/usecases/get_messages.dart';
import 'package:trust_zone/features/chat/chat/domain/usecases/send_messages.dart';
import 'package:trust_zone/features/chat/chat/presentation/managerr/message_cubit/message_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GetMessagesUseCase getMessages; // عدل اسم اليوزكيس هنا
  final SendMessageUseCase sendMessage;

  ChatCubit(this.getMessages, this.sendMessage) : super(ChatInitial());

  Timer? _pollingTimer;

  void startPolling(int conversationId) {
    emit(ChatLoading());

    _pollingTimer?.cancel(); // إلغاء أي مؤقت سابق
    fetchMessages(conversationId); // أول تحميل مباشر

    _pollingTimer = Timer.periodic(Duration(seconds: 5), (_) {
      fetchMessages(conversationId);
    });
  }

  void stopPolling() {
    _pollingTimer?.cancel();
  }

 Future<void> fetchMessages(int conversationId) async {
  final result = await getMessages(conversationId);
  print("Fetching messages for conversation: $conversationId");

  result.fold(
    (failure) => emit(ChatError('فشل في تحميل الرسائل')),
    (newMessages) {
      if (state is ChatLoaded) {
        final oldMessages = (state as ChatLoaded).messages;
        if (_areMessagesEqual(oldMessages, newMessages)) {
          return; // ما تعملش emit لو نفس الرسائل
        }
      }
      emit(ChatLoaded(newMessages));
    },
  );
}

bool _areMessagesEqual(List<MessageEntity> oldList, List<MessageEntity> newList) {
  if (oldList.length != newList.length) return false;
  for (int i = 0; i < oldList.length; i++) {
    if (oldList[i].id != newList[i].id) return false;
  }
  return true;
}


  Future<void> sendNewMessage(String content, String user2Id, int conversationId) async {
    try {
      await sendMessage(content, user2Id, conversationId);
    } catch (_) {
      emit(ChatError("فشل في إرسال الرسالة"));
    }
  }

  @override
  Future<void> close() {
    stopPolling();
    return super.close();
  }
}
