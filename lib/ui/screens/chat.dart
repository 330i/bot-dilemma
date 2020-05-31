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
  final String chatId;
  final String user;

  const ChatScreen({Key key, this.bot, this.chatId, this.user})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _showBottom = false;
  TextEditingController textInput = new TextEditingController();
  String chatId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setInitParams();
  }

  Future setInitParams() async {
    await Firestore.instance
        .collection('chats')
        .getDocuments()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        if (ds.data["uid1"] == widget.user && ds.data["active1"] == true) {
          setState(() {
            chatId = ds.documentID;
          });
        }
        if (ds.data["uid2"] == widget.user && ds.data["active2"] == true) {
          setState(() {
            chatId = ds.documentID;
          });
        }
      }
    });
  }

  Future sendMessage(String message) async {
    print("SENDING MESSAGE");
    textInput.clear();
    await Firestore.instance.collection("messages").add({
      'sender': widget.user,
      'message': message,
      'chatid': chatId,
      'date': DateTime.now().millisecondsSinceEpoch.toString()
    });
    if (widget.bot) {
      print("SENDING BOT MESSAGE");
      await fetchChatBotResult(message).then((response) async {
        print("BOT MESSAGE SENT");
        await Firestore.instance.collection("messages").add({
          'sender': "bot",
          'message': response,
          'chatid': chatId,
          'date': DateTime.now().millisecondsSinceEpoch.toString()
        });
      });
    }
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  ScrollController scrollController = ScrollController();

  Future<void> callback() async {
    print(widget.user);
    if (textInput.text.length > 0) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  bool wasCorrect;


  void isCorrect(bool guess) {
    wasCorrect = guess==widget.bot;
  }

  @override
  Widget build(BuildContext context) {
    int messageLength;
    if (messages != null) {
      messageLength = messages.length;
    } else {
      messageLength = 0;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
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
                        color: Colors.orangeAccent,
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
                          color: Colors.black)
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      FlatButton(
                              onPressed: () async {
                                isCorrect(true);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => (PostGuess(wasCorrect: wasCorrect,))));
                              },
                              child: Text('               🤖 AI                 '),
                            ),
                            Text('or'),
                            FlatButton(
                              onPressed: () {
                                isCorrect(false);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => (PostGuess(wasCorrect: wasCorrect,))));
                              },
                              child: Text('                    🙎‍ HUMAN️  '),
                            ),
                    ],
                  ),
                ),
                Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection("messages")
                      .orderBy("date")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: CircularProgressIndicator(),
                      );

                    List<DocumentSnapshot> docs = snapshot.data.documents;

                    List<Widget> messages = new List<Widget>();

                    for (DocumentSnapshot d in docs) {
                      if (d.data['chatid'] == chatId) {
                        if (d.data['sender'] == widget.user) {
                          messages.add(SentMessageWidget(
                            message: d.data["message"],
                          ));
                        } else {
                          messages.add(ReceivedMessagesWidget(
                              message: d.data["message"]));
                        }
                      }
                    }
                    return ListView(
                      controller: scrollController,
                      children: <Widget>[
                        ...messages,
                      ],
                    );
                  },
                )),
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
                                  icon: Icon(Icons.send),
                                  onPressed: () {
                                    sendMessage(textInput.text);
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
