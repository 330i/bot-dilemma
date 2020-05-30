import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';

Future<String> fetchChatBotResult(String val) async {

  print(val);
  String url = 'http://192.168.0.59:8080/interact?text='+val;
  Response response = await get(url);
  // sample info available in response
  print(response.body);
  String chatResult = json.decode(response.body)['text'];

  return chatResult;

}
