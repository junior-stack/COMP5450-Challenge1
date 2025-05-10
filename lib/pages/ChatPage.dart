import 'package:challenge1/constant/apiKey.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart' as gpt;
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int _counter = 0;

  ChatUser currUser = ChatUser(id: '1');
  ChatUser chatbot = ChatUser(id: '2');

  List<ChatMessage> msg = [];
  List<ChatUser> typingUsers = [];

  final openAI = gpt.OpenAI.instance.build(
    token: API_key,
    baseOption: gpt.HttpSetup(
      receiveTimeout: const Duration(seconds: 8)
    ),
    enableLog: true
  );

  Future<void> getChatAIresponse(ChatMessage m) async {
    setState(() {
      typingUsers.add(chatbot);
    });

    // display user's message on screen
    setState(() {
      msg.insert(0, m);
    });

    List<Map<String, dynamic>> msgHistory = msg.reversed.map((m){
      if(m.user == currUser){
        return Map.of({"role": "user", "content": m.text});
      } else{
          return Map.of({"role": "assistant", "content": m.text});
      }
    }).toList();

    final request = gpt.ChatCompleteText(
      model: gpt.Gpt4ChatModel(),
      messages: msgHistory
    );

    print("request: ");
    print(request);
    final response = await openAI.onChatCompletion(request: request);
    print("response: ");
    print(response);

    for(var txt in response!.choices){

      if(txt.message != null){
        print("txt: ");
        print(txt.message);
        setState(() {
          msg.insert(0, ChatMessage(user: chatbot, createdAt: DateTime.now(), text: txt.message!.content));
        });
      }
    }

    setState(() {
      typingUsers.remove(chatbot);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title, style: const TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: DashChat(currentUser: currUser, typingUsers: typingUsers, onSend: (ChatMessage m) async{
        await getChatAIresponse(m);
      }, messages: msg)
    );
  }
}