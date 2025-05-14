import 'package:challenge1/pages/ChatHistoryPage.dart';
import 'package:flutter/material.dart';
import 'package:challenge1/constant/global.dart';
import 'pages/LoginPage.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Chat AI App',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const LoginPage(),
      navigatorObservers: [routeObserver],
    );
  }
}
