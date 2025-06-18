import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trust_zone/core/localization/app_localizations.dart';
import 'package:trust_zone/features/chat/chat/presentation/managerr/message_cubit/message_cubit.dart';
import 'package:trust_zone/features/chat/chat/presentation/managerr/message_cubit/message_state.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final int conversationId;
  final String receiverId;
  final String receiverName;
  final String receiverProfilePicture;

  const ChatScreen({
    required this.conversationId,
    required this.receiverId,
    required this.receiverName,
    this.receiverProfilePicture = 'https://placehold.co/100x100',
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  late ChatCubit chatCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    chatCubit = context.read<ChatCubit>(); // حفظ المرجع هنا
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ChatCubit>().startPolling(widget.conversationId);
    });
  }

  @override
  void dispose() {
    chatCubit.stopPolling(); // استخدام المرجع بأمان
    super.dispose();
  }

  void _sendMessage() async {
    final content = _controller.text.trim();
    if (content.isNotEmpty) {
      await chatCubit.sendNewMessage(content, widget.receiverId, widget.conversationId);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final myId = widget.receiverId;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: CachedNetworkImageProvider(widget.receiverProfilePicture),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.receiverName, style: const TextStyle(fontSize: 20)),
                const Text("Active Now", style: TextStyle(fontSize: 14, color: Colors.green)),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) return const Center(child: CircularProgressIndicator());
                if (state is ChatLoaded) {
                  if (state.messages.isEmpty) return const Center(child: Text("لا توجد رسائل حتى الآن"));

                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.all(12),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final msg = state.messages[index];
                      final isMe = msg.senderId == myId;
                      final time = DateFormat('h:mm a').format(msg.sentAt);

                      final profileImage = msg.senderProfilePicture?.isNotEmpty == true
                          ? msg.senderProfilePicture!
                          : 'https://placehold.co/100x100';

                      return Align(
                        alignment: isMe ? Alignment.centerLeft : Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (isMe)
                                CircleAvatar(
                                  radius: 18,
                                  backgroundImage: CachedNetworkImageProvider(profileImage),
                                ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: isMe ? Colors.grey[200] : Colors.blue[400],
                                        borderRadius: BorderRadius.only(
                                          topLeft: const Radius.circular(20),
                                          topRight: const Radius.circular(20),
                                          bottomLeft: Radius.circular(isMe ? 0 : 20),
                                          bottomRight: Radius.circular(isMe ? 20 : 0),
                                        ),
                                      ),
                                      child: Text(
                                        msg.content,
                                        style: TextStyle(
                                          color: isMe ? Colors.black : Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      time,
                                      style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 6),
                              if (!isMe)
                                CircleAvatar(
                                  radius: 18,
                                  backgroundImage: CachedNetworkImageProvider(profileImage),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).sendMessage,
                      fillColor: Colors.grey[100],
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
