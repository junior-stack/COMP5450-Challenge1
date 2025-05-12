import 'package:flutter/material.dart';

class ChatHistoryWidget extends StatelessWidget {
  final List<Map<String, dynamic>> chatHistory;
  final Function(String title)? onTapItem;

  const ChatHistoryWidget({
    Key? key,
    required this.chatHistory,
    this.onTapItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (chatHistory.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, size: 100, color: Colors.deepPurple),
            SizedBox(height: 20),
            Text(
              'Your chat is empty.\nTap the chat icon below to start a conversation.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: chatHistory.length,
      itemBuilder: (context, index) {
        final chat = chatHistory[index];
        return ListTile(
          leading: const Icon(Icons.chat),
          title: Text(chat['title']),
          subtitle: Text(chat['timestamp'].toString()),
          onTap: () {
            if (onTapItem != null) {
              onTapItem!(chat['title']);
            }
          },
        );
      },
    );
  }
}

