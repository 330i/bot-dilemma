import 'package:flutter/material.dart';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialchatbotapp/ui/screens/chat.dart';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialchatbotapp/leaderboard.dart';
import 'package:socialchatbotapp/login.dart';



class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  bool active = false;

  Future initParams(context) async{

    String user;
    final FirebaseUser us = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = us.uid;
    });

    String chat;


    await Firestore.instance.collection('chats').getDocuments().then((snapshot) async {
      for (DocumentSnapshot ds in snapshot.documents){
        if (ds.data["uid1"]==user&&ds.data["active1"]==true){
          setState(() {
            active= true;
            chat = ds.documentID.toString();
          });
          break;
        }
        if(ds.data["uid2"]==user&&ds.data["active2"]==true){
          setState(() {
            setState(() {
              active=true;
            });
            chat = ds.documentID.toString();
          });
          break;
        }
      }
      print("ACCTIIIIIIIIVEEEE");
      print(active);
      if(!active){
        var rand = new Random();
        int ind = rand.nextInt(10);
        if (ind>5){
          print("BOOOOOOOT STARTED");
          await Firestore.instance.collection('chats').add({
            'active1':true,
            'active2':true,
            'uid1':user,
            'uid2':"bot",
          });
          print("BOOOOOT FINIISHEED");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatScreen(bot: true,user: user,)),
          );
        }
        else{
          print("USER STARTEEEEED");
          await Firestore.instance.collection("users").getDocuments().then((snp) async {
            bool match = false;
            for (DocumentSnapshot ds in snp.documents){
              String data = ds.data['uid'];
              for (DocumentSnapshot ds in snapshot.documents){
                if (ds.data["uid1"]==user&&ds.data["uid2"]==data){
                  match = true;
                }
                if(ds.data["uid2"]==data&&ds.data["uid1"]==user){
                  setState(() {
                    match = true;
                  });
                }
              }
              if(match){
                print("FOUND EXISTING CHAT");
                break;
              }
              else{
                print("NOOOOO EXISTING CHAT");
                //TODO maybe await needed here?
                await Firestore.instance.collection('chats').add({
                  'active1':true,
                  'active2':true,
                  'uid1':user,
                  'uid2':data,
                });
                print("NEW USER CHAT ADDEEEED");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen(bot: false,user: user,)),
                );
                break;
              }
            }
          });
        }
      };
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatScreen(bot: false,user: user,)),
    );
  }

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
                                  initParams(context);
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
