import 'package:flutter/material.dart';
import 'package:socialchatbotapp/global.dart';
import 'package:socialchatbotapp/ui/widgets/widgets.dart';
import 'package:socialchatbotapp/guess.dart';

String guess;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _showBottom = false;
  TextEditingController textInput = new TextEditingController();

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
                              child: Text('               🤖 AI                 '),
                              onPressed: () {
                                guess = 'ai';
                              },
                            ),
                            Text('or'),
                            FlatButton(
                              child: Text('                    🙎‍ HUMAN️  '),
                              onPressed: () {
                                guess = 'human';
                                Navigator.of(context,)
                              },
                            ),
                          ],
                        )
                      ),

                    ],
                  ),
                ),
                Expanded(
                    child: FutureBuilder(
                      future: MessageSend('chatexample').addMessages(),
                      builder: (context, snapshot){
                        return ListView.builder(
                          padding: const EdgeInsets.all(15),
                          itemCount: messageLength,
                          itemBuilder: (ctx, i) {
                            if (!messages[i]['status']) {
                              return ReceivedMessagesWidget(message: snapshot.data[i]['text']);
                            } else {
                              return SentMessageWidget(i: i);
                            }
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

List<IconData> icons = [
];
