import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:trust_zone/features/chat/chat/presentation/managerr/conversation_cubit/conversation_state.dart';
import 'package:trust_zone/features/chat/chat/presentation/managerr/conversation_cubit/conversatoin_cubit.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ConversationCubit>().fetchConversations(1, 20);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<ConversationCubit, ConversationState>(
              builder: (context, state) {
                if (state is ConversationLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ConversationLoaded) {
                  return ListView.builder(
                    itemCount: state.conversations.length,
                    itemBuilder: (context, index) {
                      final convo = state.conversations[index];

                      final profile = convo.profilePicture?.trim();
                      final isValidImage = profile != null && profile.isNotEmpty;

                      return ListTile(
                        onTap: () {
                          context.push(
                            '/chat-screen',
                            extra: {
                              'conversationId': convo.id,
                              'receiverId': convo.receiverId,
                              'receiverName': convo.userName,
                              'receiverProfilePicture': isValidImage
                                  ? profile
                                  : 'https://placehold.co/100x100',
                            },
                          );
                        },
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey.shade300,
                          child: ClipOval(
                            child: isValidImage
                                ? Image.network(
                                    profile!,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        "assets/images/images.png",
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  )
                                : Image.asset(
                                    "assets/images/images.png",
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        title: Text(
                          convo.userName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          convo.lastMessageContent,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 16),
                        ),
                        trailing: Text(
                          DateFormat.jm().format(convo.lastMessageAt),
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      );
                    },
                  );
                } else if (state is ConversationError) {
                  return Center(child: Text(state.message));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
