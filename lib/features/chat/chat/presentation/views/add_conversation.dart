// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../../core/localization/app_localizations.dart';
// import '../managerr/conversation_cubit/conversatoin_cubit.dart';

// class AddConversationScreen extends StatefulWidget {
//   const AddConversationScreen({Key? key}) : super(key: key);

//   @override
//   State<AddConversationScreen> createState() => _AddConversationScreenState();
// }

// class _AddConversationScreenState extends State<AddConversationScreen> {
//   final TextEditingController _userNameController = TextEditingController();
//   bool _isLoading = false;

//   void _startConversation() async {
//     final user2Name = _userNameController.text.trim();
//     if (user2Name.isEmpty) return;

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       await context.read<ConversationCubit>().addConversation(user2Name);

//       if (mounted) {
//         Navigator.of(context).pop(); // يرجع للشاشة السابقة بعد الإنشاء
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('${AppLocalizations.of(context).failedToStartConversation} +$e')),
//       );
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _userNameController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:  Text(AppLocalizations.of(context).startNewConversation),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _userNameController,
//               decoration: InputDecoration(
//                 labelText: AppLocalizations.of(context).userName,
//                 hintText: AppLocalizations.of(context).enterUsernameToChat,
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//               ),
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: double.infinity,
//               height: 48,
//               child: ElevatedButton(
//                 onPressed: _isLoading ? null : _startConversation,
//                 child: _isLoading
//                     ? const CircularProgressIndicator(color: Colors.white)
//                     :  Text(AppLocalizations.of(context).startNewConversation),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
