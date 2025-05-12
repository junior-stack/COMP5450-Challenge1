import 'package:flutter/material.dart';

class ChatHistory extends StatelessWidget {
  const ChatHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ChatRecords(),
    );
  }
}

class ChatItem {
  final String icon;
  final String title;
  final String subtitle;
  final String date;
  bool isPinned; // Indicates whether the item is pinned

  ChatItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.date,
    this.isPinned = false, // Default is not pinned
  });
}

class ChatRecords extends StatefulWidget {
  const ChatRecords({super.key});

  @override
  State<ChatRecords> createState() => _ChatRecords();
}

class _ChatRecords extends State<ChatRecords> {
  List<ChatItem> chatItems = [
    ChatItem(
      icon: 'latex_icon.png',
      title: 'LaTeX Subsections',
      subtitle: 'Assistant: In LaTeX, \\subsectio...',
      date: 'Apr 2',
    ),
    ChatItem(
      icon: 'algorithm_icon.png',
      title: 'Algorithm Explanation',
      subtitle: 'ChatGPT-4o Latest: The algor...',
      date: 'Mar 20',
    ),
    ChatItem(
      icon: 'algorithm_icon.png',
      title: 'Pseudo-Random Number Generator',
      subtitle: 'ChatGPT-4o Latest:',
      date: 'Mar 19',
    ),
    ChatItem(
      icon: 'soundex_icon.png',
      title: 'Soundex Algorithm',
      subtitle: 'Deepseek-V3-FW: Looks like, **IPS...',
      date: 'Mar 7',
    ),
    ChatItem(
      icon: 'claude_icon.png',
      title: 'Soundex Algorithm',
      subtitle: 'Claude-3.5-Sonnet: Let’s take a closer look...',
      date: 'February 28',
    ),
  ];

  void _pinToTop(int index) {
    setState(() {
      final item = chatItems[index];
      if (!item.isPinned) {
        item.isPinned = true;
        chatItems.removeAt(index);
        int firstUnpinnedIndex = chatItems.indexWhere((item) => !item.isPinned);
        if (firstUnpinnedIndex == -1) {
          chatItems.add(item);
        } else {
          chatItems.insert(firstUnpinnedIndex, item);
        }
      }
    });
  }

  void _unpin(int index) {
    setState(() {
      final item = chatItems[index];
      if (item.isPinned) {
        item.isPinned = false;
        chatItems.removeAt(index);
        int firstUnpinnedIndex = chatItems.indexWhere((item) => !item.isPinned);
        if (firstUnpinnedIndex == -1) {
          chatItems.add(item);
        } else {
          chatItems.insert(firstUnpinnedIndex, item);
        }
      }
    });
  }

  void _deleteItem(int index) {
    setState(() {
      chatItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat History'),
      ),
      body: chatItems.isEmpty
          ? const Center(
        child: Text(
          'empty',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: chatItems.length,
        itemBuilder: (context, index) {
          final item = chatItems[index];
          return Dismissible(
            key: Key(item.title + index.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 16),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) {
              _deleteItem(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${item.title} deleted')),
              );
            },
            child: GestureDetector(
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(item.isPinned ? 'Unpin' : 'Pin to Top'),
                    content: Text(item.isPinned
                        ? 'Do you want to unpin this chat?'
                        : 'Do you want to pin this chat to the top?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (item.isPinned) {
                            _unpin(index);
                          } else {
                            _pinToTop(index);
                          }
                          Navigator.pop(context);
                        },
                        child: const Text('Confirm'),
                      ),
                    ],
                  ),
                );
              },
              child: ListTile(
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      child: Text(item.icon[0]), // Simulated icon
                    ),
                    if (item.isPinned)
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.push_pin,
                          size: 20,
                          color: Colors.blue,
                        ),
                      ),
                  ],
                ),
                title: Text(item.title),
                subtitle: Text(item.subtitle),
                trailing: Text(item.date),
              ),
            ),
          );
        },
      ),
    );
  }
}
