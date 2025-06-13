// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:trust_zone/utils/shared_data.dart';

// import '../../../../../core/localization/app_localizations.dart';
// import '../managerr/message_cubit/message_cubit.dart';
// import '../managerr/message_cubit/message_state.dart';

// class ChatScreen extends StatefulWidget {
//   final String conversationId;
//   final String receiverId;

//   const ChatScreen({
//     Key? key,
//     required this.conversationId,
//     required this.receiverId,
//   }) : super(key: key);

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   late TextEditingController _controller;

//   @override
//   void initState() {
//   super.initState();
//   _controller = TextEditingController();
//   context.read<ChatCubit>().loadMessages(widget.conversationId);
// }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _send() {
//     final text = _controller.text.trim();
//     if (text.isNotEmpty) {
//       context.read<ChatCubit>().sendMessage(text, widget.receiverId,widget.conversationId,
// );
//       _controller.clear();
//     }
//   }

//   Widget _buildMessageBubble({required bool isMe, required String message}) {
//     return Align(
//       alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: isMe ? Colors.lightBlue[400] : Colors.grey[200],
//           borderRadius: BorderRadius.only(
//             topLeft: const Radius.circular(16),
//             topRight: const Radius.circular(16),
//             bottomLeft: Radius.circular(isMe ? 16 : 0),
//             bottomRight: Radius.circular(isMe ? 0 : 16),
//           ),
//         ),
//         child: Text(
//           message,
//           style: TextStyle(
//             color: isMe ? Colors.white : Colors.black87,
//             fontSize: 15,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//   final myId = getSelectedUserId() ?? ''; // ✅ استخدام اليوزر الحالي
//     return Scaffold(
//       appBar: AppBar(
//         leading: const BackButton(color: Colors.black),
//         title: Row(
//           children: [
//             const CircleAvatar(radius: 20, backgroundColor: Colors.teal),
//             const SizedBox(width: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children:  [
//                 Text(AppLocalizations.of(context).username, style: TextStyle(color: Colors.black, fontSize: 16)),
//                 Text(AppLocalizations.of(context).activeNow, style: TextStyle(color: Colors.grey, fontSize: 12)),
//               ],
//             ),
//           ],
//         ),
//         backgroundColor: Colors.white,
//         elevation: 1,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: BlocBuilder<ChatCubit, ChatState>(
//               builder: (context, state) {
//                 if (state.isLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (state.error != null) {
//                   return Center(child: Text(state.error!));
//                 }

//                 return ListView.builder(
//                   reverse: true,
//                   padding: const EdgeInsets.only(top: 10),
//                   itemCount: state.messages.length,
//                   itemBuilder: (context, index) {
//                     final msg = state.messages[index];
//                     final isMe = msg.senderId == myId;
//                     return _buildMessageBubble(isMe: isMe, message: msg.content);
//                   },
//                 );
//               },
//             ),
//           ),
//           const Divider(height: 1),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//             color: Colors.grey[100],
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration:  InputDecoration.collapsed(
//                       hintText: AppLocalizations.of(context).sendMessage,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 IconButton(
//                   icon: const Icon(Icons.send, color: Colors.blue),
//                   onPressed: _send,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
