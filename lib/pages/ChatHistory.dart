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
  bool isPinned; // 用于标记是否置顶

  ChatItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.date,
    this.isPinned = false, // 默认未置顶
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
      subtitle: 'Assistant: 在 LaTeX 中，\\subsectio...',
      date: '4月2日',
    ),
    ChatItem(
      icon: 'algorithm_icon.png',
      title: 'Algorithm Explanation',
      subtitle: 'ChatGPT-4o Latest: The algor...',
      date: '3月20日',
    ),
    ChatItem(
      icon: 'algorithm_icon.png',
      title: '伪随机数发生成器',
      subtitle: 'ChatGPT-4o Latest:',
      date: '3月19日',
    ),
    ChatItem(
      icon: 'soundex_icon.png',
      title: 'Soundex Algorithm',
      subtitle: 'Deepseek-V3-FW: 望望的，**IPS...',
      date: '3月7日',
    ),
    ChatItem(
      icon: 'claude_icon.png',
      title: 'Soundex Algorithm',
      subtitle: 'Claude-3.5-Sonnet: 让我们仔细...',
      date: '2月28日',
    ),
  ];

  void _pinToTop(int index) {
    setState(() {
      final item = chatItems[index];
      if (!item.isPinned) {
        // 如果未置顶，标记为置顶并移动到置顶区域
        item.isPinned = true;
        chatItems.removeAt(index);
        // 找到第一个未置顶的 item 的位置
        int firstUnpinnedIndex = chatItems.indexWhere((item) => !item.isPinned);
        if (firstUnpinnedIndex == -1) {
          // 如果所有 item 都置顶了，添加到最后
          chatItems.add(item);
        } else {
          // 插入到最后一个置顶 item 之后
          chatItems.insert(firstUnpinnedIndex, item);
        }
      }
    });
  }

  void _unpin(int index) {
    setState(() {
      final item = chatItems[index];
      if (item.isPinned) {
        // 如果已置顶，标记为未置顶并移动到未置顶区域的顶部
        item.isPinned = false;
        chatItems.removeAt(index);
        // 找到第一个未置顶的 item 的位置
        int firstUnpinnedIndex = chatItems.indexWhere((item) => !item.isPinned);
        if (firstUnpinnedIndex == -1) {
          // 如果没有未置顶的 item，添加到最后
          chatItems.add(item);
        } else {
          // 插入到未置顶区域的顶部
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
        title: const Text('聊天记录'),
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
                SnackBar(content: Text('${item.title} 已删除')),
              );
            },
            child: GestureDetector(
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(item.isPinned ? '取消置顶' : '置顶'),
                    content: Text(item.isPinned
                        ? '是否取消此聊天的置顶？'
                        : '是否将此聊天置顶？'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('取消'),
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
                        child: const Text('确定'),
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
                      child: Text(item.icon[0]), // 模拟图标
                    ),
                    if (item.isPinned) // 根据 isPinned 显示置顶图标
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