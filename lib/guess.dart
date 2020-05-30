import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {

  String userid = 'lol';

  TextEditingController textEntry = new TextEditingController();

  _chatBubble(String _id, int sequence) {
    return new Material(
      child: Column(
        children: [
          StreamBuilder(
              stream: Firestore.instance.collection('chats').document(_id).snapshots(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return new Text('...');
                }
                else{
                  var userDocument = snapshot.data;
                  return Container(
                    color: Colors.blue,
                    child: userDocument['messages'][sequence],
                  );
                }
              }
          ),
        ],
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    String id;
    return Material(
      child: Column(
        children: [
          Container(
            height: 40,
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: Row(
                children: [
                  Container(
                    color: Colors.red,
                    height: 40,
                    width: 40,
                    child: Icon(Icons.close),
                  ),
                  Container(
                    color: Colors.green,
                    height: 40,
                    width: 40,
                    child: Icon(Icons.check),
                  ),
                  Expanded(
                    child: Padding(
                        child: TextField(
                          decoration: InputDecoration.collapsed(hintText: 'Send a message...'),
                          controller: textEntry,
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 5,horizontal: 10
                        )
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    child: GestureDetector(
                      onTap: () async {
                        print('sending '+textEntry.text);
                        int last;
                        await Firestore.instance.document('chatexample').get().then((value) {
                          last = value['messages'].length;
                        });
                        await Firestore.instance.document(id).setData({
                          'messages'[last]:{'person':userid,'text':textEntry}
                        },merge: true);
                      },
                      child: Icon(Icons.send),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
