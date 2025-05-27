import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../managerr/conversation_cubit/conversation_state.dart';
import '../managerr/conversation_cubit/conversatoin_cubit.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context).messages),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).search,
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                // ممكن تضيف فلترة هنا
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ConversationCubit, ConversationState>(
              builder: (context, state) {

                if (state is ConversationLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ConversationLoaded) {
                  if (state.conversations.isEmpty) {
                    return Center(child: Text('No conversations yet'));
                  }

                  return ListView.separated(
                    itemCount: state.conversations.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final conversation = state.conversations[index];
                      return ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 24,
                          ),
                          title: Text(
                            conversation.user2Name ?? 'Unknown',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle:
                              Text('Started at: ${conversation.createdAt}'),
                          onTap: () {
                            final receiverId = conversation.user2Id;
                            final conversationId =
                                conversation.id.toString(); // لو هو int
                            if (receiverId.isNotEmpty &&
                                conversationId.isNotEmpty) {
                              context.push('/chat-screen', extra: {
                                'conversationId': conversationId,
                                'receiverId': receiverId,
                              });
                            }
                          });
                    },
                  );
                } else if (state is ConversationError) {
                  return Center(child: Text('${AppLocalizations.of(context).error} ${state.message}'));
                } else {
                  return const Center(child: Text('No conversations'));
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final controller = TextEditingController();
          final user2Id = await showDialog<String>(
            context: context,
            builder: (_) => AlertDialog(
              title:  Text(AppLocalizations.of(context).enterUserId),
              content: TextField(controller: controller),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, controller.text),
                  child: Text(AppLocalizations.of(context).add),
                ),
              ],
            ),
          );

          if (user2Id != null && user2Id.isNotEmpty) {
            await context.read<ConversationCubit>().addConversation(user2Id);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
