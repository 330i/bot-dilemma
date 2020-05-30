import 'package:flutter/material.dart';

import 'package:socialchatbotapp/ui/screens/chat.dart';

void main() {
  runApp(MaterialApp(home: ChatScreen(bot: true,),));
}