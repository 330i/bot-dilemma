import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialchatbotapp/leaderboard.dart';
import 'package:socialchatbotapp/login.dart';

String roomID;

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/Back.png'),
                fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  StreamBuilder(
                    stream: Firestore.instance.collection('users').document(userid).snapshots(),
                    builder: (context, snapshots) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 100),
                            Text('Welcome',
                                style:
                                TextStyle(fontSize: 50, color: Colors.black)),
                            SizedBox(height: 10),
                            Text(
                              snapshots.data['name'],
                              style: TextStyle(fontSize: 30, color: Colors.black),
                            ),
                            SizedBox(height: 100),

                            //Total Post
                            SizedBox(height: 50),
                            Container(
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.orange.withOpacity(0.5),
                                    spreadRadius: 6,
                                    blurRadius: 6,
                                    offset:
                                    Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: RaisedButton(
                                color: Colors.orangeAccent[100],
                                onPressed: () {
                                  bool botChosen = Random().nextBool();
                                  if(botChosen){

                                  }
                                },
                                child: const Text('Start Chatting',
                                    style: TextStyle(fontSize: 26)),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.orange.withOpacity(0.5),
                                    spreadRadius: 6,
                                    blurRadius: 6,
                                    offset:
                                    Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: RaisedButton(
                                color: Colors.orangeAccent[100],
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => (LeaderBoard())),
                                  );
                                },
                                child: const Text('Leaderboard',
                                    style: TextStyle(fontSize: 26)),
                              ),
                            ),
                            SizedBox(height: 10),

                            Container(
                              margin: EdgeInsets.only(
                                left: 30,
                                top: 80,
                                right: 30,
                              ),
                              height: 100,
                              width: 330,
                              decoration: BoxDecoration(
                                color: Colors.white30,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.orange.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset:
                                    Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 10),
                                    Text('Your Total Score',
                                        style: TextStyle(
                                            fontSize: 30, color: Colors.black)),
                                    SizedBox(height: 10),
                                    Text(snapshots.data['points'].toString(),
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black)),
                                  ]),
                            ),
                          ]);
                    },
                  ),
                ])));
  }
}
