import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialchatbotapp/api_client/api_client.dart';
import 'package:socialchatbotapp/global.dart';
import 'package:socialchatbotapp/login.dart';
import 'package:socialchatbotapp/ui/widgets/widgets.dart';
import 'package:socialchatbotapp/guess.dart';

import '../../postGuess.dart';

class ChatScreen extends StatefulWidget {

  final bool bot;

  const ChatScreen({Key key, this.bot}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _showBottom = false;
  TextEditingController textInput = new TextEditingController();
  String chatId;
  String user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setInitParams();

  }

  Future setInitParams () async{
    final FirebaseUser us = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = us.uid;
    });

    await Firestore.instance.collection('chats').getDocuments().then((snapshot){
      for (DocumentSnapshot ds in snapshot.documents){
        if (ds.data["uid1"]==user&&ds.data["active1"]==true){
          setState(() {
            chatId=ds.documentID;
          });
        }
        if(ds.data["uid2"]==user&&ds.data["active2"]==true){
          setState(() {
            chatId = ds.documentID;
          });
        }
      }
    });
  }

  Future sendMessage(String message)async{
    await Firestore.instance.collection("messages").add({
      'sender':user,
      'message':message,
      'chatid':chatId
    });
    if (widget.bot){
      await fetchChatBotResult(message).then((response) async{
        await Firestore.instance.collection("messages").add({
          'sender':"bot",
          'message':response,
          'chatid':chatId
        });
      });
    }
  }

  void isCorrect(String guess) {
    String uid1;
    String uid2;
    Firestore.instance.document('chatexample').get().then((value) {
      uid1 = value.data['uid1'];
      uid2 = value.data['uid2'];
    });
    if(userid==uid1){
      if(uid2=='bot'&&guess=='bot'){
        wasCorrect = true;
      }
      else if(uid2!='bot'&&guess!='bot'){
        wasCorrect = true;
      }
      else{
        wasCorrect = false;
      }
    }
    else{
      if(uid1=='bot'&&guess=='bot'){
        wasCorrect = true;
      }
      else if(uid1!='bot'&&guess!='bot'){
        wasCorrect = true;
      }
      else{
        wasCorrect = false;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    int messageLength;
    if(messages!=null){
      messageLength = messages.length;
    }
    else{
      messageLength = 0;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black54),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MyCircleAvatar(
              imgUrl: friendsList[0]['imgUrl'],
            ),
            SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Cybdom Tech",
                  style: Theme.of(context).textTheme.subhead,
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "Online",
                  style: Theme.of(context).textTheme.subtitle.apply(
                        color: myGreen,
                      ),
                )
              ],
            )
          ],
        ),

      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35.0),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 5,
                          color: Colors.grey)
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: [
                            FlatButton(
                              onPressed: () async {
                                isCorrect('bot');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => (PostGuess())),
                              },
                              child: Text('               🤖 AI                 '),
                            ),
                            Text('or'),
                            FlatButton(
                              onPressed: () {
                                isCorrect('man');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => (PostGuess())),
                              },
                              child: Text('                    🙎‍ HUMAN️  '),
                            ),
                          ],
                        )
                      ),

                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future:Firestore.instance.collection("messages").getDocuments(),
                    builder: (context, snapshot){
                      return ListView.builder(
                        padding: const EdgeInsets.all(15),
                        itemCount: messageLength,
                        itemBuilder: (ctx, i) {
                          if (snapshot.data[i]['chatid']==chatId) {
                            if(snapshot.data[i]['sender']==user){
                              return SentMessageWidget(message: snapshot.data[i]["text"],);
                            }
                            return ReceivedMessagesWidget(message: snapshot.data[i]["text"]);
                          }
                          return Container();
                        },
                      );
                    },
                  )
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  height: 61,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35.0),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 3),
                                  blurRadius: 5,
                                  color: Colors.grey)
                            ],
                          ),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: textInput,
                                  decoration: InputDecoration(
                                      hintText: "Type Something...",
                                      border: InputBorder.none),
                                ),
                              ),
                              IconButton(
                                  icon: Icon(Icons.send), onPressed: () {
                                    sendMessage(textInput.toString());

                              }),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                    ],
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}