import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class ResultPoint {
  String _id;
  final CollectionReference dataCollection = Firestore.instance.collection('chat');
  
  ResultPoint(String id) {
    _id = id;
  }
  
  Future<int> getPoint(bool selected) async {
    int point;
    Firestore.instance.collection('chats').document(_id).get().then((value) {
      if(value['isBot']==bool){
        point = 50^((value['messages'].length-50)/-50);
      }
      else{
        point = 0;
      }
    });
    return point;
  }
}
