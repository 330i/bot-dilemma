import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialchatbotapp/global.dart';
import 'login.dart';

class MessageSend{
  String _id;
  MessageSend(String id){
    _id = id;
  }
  Future<bool> isBot() async{
    await Firestore.instance.collection("chats").document(_id).get().then((value) {
      return value['isBot'];
    });
  }
  Future<Map<String,dynamic>> getMessage(int i) async {
    await Firestore.instance.collection("chats").document(_id).get().then((value) {
      return {
        'status':value['message'][i]['person']==userid,
        'message':value['message'][i]['text']
      };
    });
  }

  Future<List<Map<String,dynamic>>> addMessages() async {
    int limit;
    await Firestore.instance.collection('chats').document(_id).get().then((value) {
      limit = value['message'].length;
    });
    for(int i=0;i<limit;i++){
      messages[i] = await getMessage(i);
    }
    return messages;
  }
  Future addMessage(String message, String uid, String chatID) async {
    var document = await Firestore.instance.collection('chats').
    getDocuments().then((snapshot){
      for (DocumentSnapshot ds in snapshot.documents){
        if(ds.data['uid1']==uid||ds.data['uid2']==uid){

        }
      }
    });
  }
}