import 'package:flutter/material.dart';
import 'package:socialchatbotapp/ui/screens/screens.dart';
import 'package:socialchatbotapp/ui/screens/startpage.dart';

import 'ui/screens/chat.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartPage(),
      routes: {
        'chat': (ctx) => ChatScreen(),
      },
    );
  }
}
