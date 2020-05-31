import 'package:flutter/material.dart';
import 'package:socialchatbotapp/ui/screens/chat.dart';
import 'package:socialchatbotapp/ui/screens/startpage.dart';
import 'leaderBoard.dart';
import 'postGuess.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: StartPage()
    );
  }
}




