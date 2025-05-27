// import 'package:flutter/material.dart';
// import 'package:trust_zone/utils/app_images.dart';
// import 'package:trust_zone/utils/app_styles.dart';
//
// import 'chat_bubble.dart';
//
// class ChatBotViewBody extends StatelessWidget {
//   const ChatBotViewBody({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 1,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {},
//         ),
//         title: Row(
//           children: [
//             CircleAvatar(backgroundImage: NetworkImage(Assets.bot), radius: 18),
//             SizedBox(width: 10),
//             Text('Chat Bot AI', style: AppStyles.styleRegular24),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           // Chat messages
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.all(12),
//               children: [
//                 ChatBubble(
//                   isUser: true,
//                   message: "Hello chatGPT , how are you today?",
//                 ),
//                 ChatBubble(
//                   isUser: false,
//                   message: "Hello, I’m fine, how can I help you?",
//                 ),
//                 ChatBubble(
//                   isUser: true,
//                   message: "What is the best programming language?",
//                 ),
//                 ChatBubble(
//                   isUser: false,
//                   message:
//                       "There are many programming languages in the market that are used in designing and building websites, various applications and other tasks...",
//                 ),
//                 ChatBubble(isUser: true, message: "So explain to me more"),
//               ],
//             ),
//           ),
//
//           // Message input
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Write your message',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () {
//                     // handle sending message
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
