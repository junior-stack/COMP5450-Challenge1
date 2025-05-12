import 'package:flutter/material.dart';
import 'package:challenge1/pages/ChatPage.dart';
import 'package:challenge1/pages/ProfilePage.dart';
import 'package:challenge1/widgets/ChatHistoryWidget.dart';
import 'package:challenge1/database/chat_history_db.dart';

class ChatHistoryPage extends StatefulWidget {
  const ChatHistoryPage({Key? key}) : super(key: key);

  @override
  State<ChatHistoryPage> createState() => _ChatHistoryPageState();
}

class _ChatHistoryPageState extends State<ChatHistoryPage> {
  int _selectedIndex = 0;

  List<Map<String, dynamic>> chatHistory = [];
  final List<String> models = ['gpt-3.5-turbo', 'gpt-4', 'gpt-4-turbo'];
  String selectedModel = 'gpt-3.5-turbo';

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  // Fetch history from the SQLite DB
  Future<void> loadHistory() async {
    final data = await ChatHistoryDB().fetchHistory();
    setState(() {
      chatHistory = data;
    });
  }

  // Insert new chat into the DB
  void addChatHistory(String title, DateTime timestamp) async {
    await ChatHistoryDB().insertHistory(title, timestamp);
    loadHistory(); // refresh UI
  }

  void goToProfilePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            title: 'New Chat',
            selectedModel: selectedModel,
            onChatComplete: addChatHistory,
          ),
        ),
      );
    } else if (index == 2) {
      goToProfilePage();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Choose a model and start a conversation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade100,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 3,
                  offset: const Offset(0, 1.5),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: DropdownButtonFormField<String>(
              value: selectedModel,
              decoration: const InputDecoration(
                labelText: 'GPTModel',
                labelStyle: TextStyle(fontWeight: FontWeight.w500),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              items: models.map((model) {
                return DropdownMenuItem(
                  value: model,
                  child: Text(model),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedModel = value;
                  });
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          Divider(
            color: Colors.grey.shade400,
            thickness: 0.6,
          ),
          const SizedBox(height: 12),
          const Text(
            'Recent History',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ChatHistoryWidget(
              chatHistory: chatHistory,
              onTapItem: (title) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Tapped: $title")),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatAI'),
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: goToProfilePage,
              child: const CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: _selectedIndex == 0 ? _buildBody() : const SizedBox.shrink(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'New Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
