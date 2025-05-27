import 'package:flutter/material.dart';

import '../../../../../../core/localization/app_localizations.dart';

class ChatBubble extends StatelessWidget {
  final bool isUser;
  final String message;

  const ChatBubble({Key? key, required this.isUser, required this.message})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isUser ? Colors.blue[100] : Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isUser)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.grey[500],
                      child: Icon(
                        Icons.smart_toy,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                Flexible(child: Text(message)),
              ],
            ),
          ),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isUser)
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.edit, size: 16),
                  label: Text(AppLocalizations.of(context).edit),
                ),

              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.copy, size: 16),
                label: Text(AppLocalizations.of(context).copy),
              ),
              if (!isUser)
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.refresh, size: 16),
                  label: Text(AppLocalizations.of(context).regenerate),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
