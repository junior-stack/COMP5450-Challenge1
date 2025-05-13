import 'dart:convert';
import 'dart:io';

import 'package:challenge1/constant/apiKey.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:challenge1/database/chat_history_db.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.title, required this.session}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final int session;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  ChatUser currUser = ChatUser(id: '1');
  ChatUser chatbot = ChatUser(id: '2', firstName: "ChatBot");

  List<ChatMessage> msg = [];
  List<ChatUser> typingUsers = [];
  final String chatbotAPI = apiUrl;
  final String model = "gpt-4.1";
  final AudioRecorder audioRecorder = AudioRecorder();
  bool isRecording = false;
  String? recordingPath;

  // compile all previous messages into a list and send to the chatbot api to get response
  Future<List<dynamic>> getChatBotAPIResponse(List<ChatMessage> msg) async{
    final headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer $API_key"
    };

    List msgHistory = msg.reversed.map((m){
      if(m.user == currUser){
        return {"role": "user", "content": m.text};
      } else{
        return {"role": "assistant", "content": m.text};
      }
    }).toList();

    final data = {"messages": msgHistory, "model": model};

    final response = await http.post(Uri.parse(apiUrl), headers: headers, body: jsonEncode(data));

    return  jsonDecode(response.body)["choices"];
  }


  Future<void> getChatAIresponse(ChatMessage m) async {
    // display the chatbot is typing
    setState(() {
      typingUsers.add(chatbot);
    });

    // display user's message on screen
    setState(() {
      msg.insert(0, m);
    });


    final response = await getChatBotAPIResponse(msg);

    // display the chatbot's response on screen
    for(var txt in response){
      if(txt["message"] != null){
        ChatMessage reply = ChatMessage(user: chatbot, createdAt: DateTime.now(), text: txt["message"]["content"], isMarkdown: true);
        setState(() {
          msg.insert(0, reply);
        });

        await ChatHistoryDB().insertHistory(m.text, m.createdAt, "user", widget.session);
        await ChatHistoryDB().insertHistory(reply.text, reply.createdAt, "chatbot", widget.session);
      }
    }

    // eliminate the typing status of chatbot
    setState(() {
      typingUsers.remove(chatbot);
    });
  }

  Future<void> recordAudio () async{
    if(isRecording){
      String? filepath = await audioRecorder.stop();

      if(filepath != null){
        setState(() {
          isRecording = false;
          recordingPath = filepath;
        });

        var uri = Uri.parse(transcribeUrl);
        var request = http.MultipartRequest('POST', uri)
          ..headers['Authorization'] = "Bearer $API_key"
          ..fields['model'] = 'whisper-1'
          ..files.add(await http.MultipartFile.fromPath('file', recordingPath!,
              filename: "recording.wav"));


        var response = await request.send();
        if (response.statusCode == 200) {
          var responseData = await response.stream.bytesToString();
          var result = json.decode(responseData);
          ChatMessage chatMsg = ChatMessage(user: currUser, createdAt: DateTime.now(), text: result["text"]);
          getChatAIresponse(chatMsg);
        }
      }
    }
    else{
      if(await audioRecorder.hasPermission()){
        final Directory appDocumentsDir = kIsWeb? Directory.current :await getApplicationDocumentsDirectory();
        final String filepath = p.join(appDocumentsDir.path, "recording.wav");
        await audioRecorder.start(const RecordConfig(encoder: AudioEncoder.wav), path: filepath);
        setState(() {
          isRecording = true;
          recordingPath = null;
        });
      }
    }
  }

  Future<void> loadMessage() async {
    final List<Map<String, dynamic>> data = await ChatHistoryDB().fetchMessage(widget.session);
    setState(() {
      msg = data.reversed.map((item) => ChatMessage(user: item["role"] == "user" ? currUser : chatbot, createdAt: DateTime.parse(item["timestamp"]), text: item["message"], isMarkdown: true)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadMessage();
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
      },  inputOptions: InputOptions(trailing: [IconButton(onPressed: kIsWeb ? null : recordAudio, icon: isRecording ? Icon(Icons.stop) : Icon(Icons.mic))], inputDisabled: isRecording), messages: msg)
    );
  }
}