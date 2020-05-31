import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class LeaderBoardWidget extends StatelessWidget {
  _space(int place, String name, int point) {
    return Row(
      children: [
        if (place == 1)
          Image.asset(
            'assets/1st.png',
            height: 25,
          ),
        if (place == 2)
          Image.asset(
            'assets/2nd.png',
            height: 25,
          ),
        if (place == 3)
          Image.asset(
            ''
                'assets/3rd.png',
            height: 25,
          ),
        if (place > 3)
          Text(
            place.toString(),
            style: TextStyle(fontSize: 25),
          ),
        Container(
          width: 12,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        Spacer(
          flex: 1,
        ),
        Row(
          children: [
            Text(
              'x${point}',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            Container(
              width: 10,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection('users').getDocuments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Scaffold(
              body: Center(
                child: Text('Loading'),
              ),
            );
          } else {
            List<DocumentSnapshot> docs = snapshot.data.documents;
            docs.sort((user1, user2) {
              return user2.data['points'].compareTo(user1.data['points']);
            });
            return Scaffold(
              body: ListView(
                children: [
                  Container(
                    height: 250,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/confetti.gif',
                          width: MediaQuery.of(context).size.width,
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            children: [
                              Spacer(
                                flex: 1,
                              ),
                              Column(children: [
                                Container(
                                  height: 150,
                                  child: Column(
                                    children: [
                                      Spacer(
                                        flex: 1,
                                      ),
                                      Image.asset('assets/2nd.png', height: 50,),
                                      Container(
                                        width: 75,
                                        child: Text(
                                          docs[1].data['name'], style: TextStyle(
                                          fontSize: 20,
                                        ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: Colors.grey,
                                  width: 75,
                                  height: 100,
                                ),
                              ]),
                              Column(
                                children: [
                                  Container(
                                    height: 100,
                                    child: Column(
                                      children: [
                                        Spacer(
                                          flex: 1,
                                        ),
                                        Image.asset('assets/1st.png', height: 50,),
                                        Container(
                                          width: 75,
                                          child: Text(
                                            docs[0].data['name'], style: TextStyle(
                                            fontSize: 20,
                                          ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Colors.yellow,
                                    width: 75,
                                    height: 150,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 200,
                                    child: Column(
                                      children: [
                                        Spacer(
                                          flex: 1,
                                        ),
                                        Image.asset('assets/3rd.png', height: 50,),
                                        Container(
                                          width: 75,
                                          child: Text(
                                            docs[2].data['name'], style: TextStyle(
                                            fontSize: 20,
                                          ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Colors.brown,
                                    width: 75,
                                    height: 50,
                                  ),
                                ],
                              ),
                              Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        for (int i = 0; i < min(docs.length, 10); i++)
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: _space(i + 1, docs[i].data['name'], docs[i].data['points'].round()),
                          ),
                      ],
                    ),
                  )
                ],
                scrollDirection: Axis.vertical,
              ),
            );
          }
        });
  }
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text(
          "Point Leaderboard"
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange[400],
        child: Icon(
          Icons.home,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 9,
        color: Colors.orange[400],
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 200,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.deepOrange[300],
                onPressed: () {},
                child: Text('Sign-Out'),
              )
            ],
          ),
        ),
      ),
      //ENTRIES
      body: LeaderBoardWidget()
    );
  }
}

Widget getCard (String Username, int Points, int rank) {
  return Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const ListTile(
          //leading: Icon(Icons.album, size: 50),
          //title: Text($Username),
          //subtitle: Text("$Points points"),
          //trailing: Text(
              //"# $rank",
              //style: TextStyle(
                  //fontSize: 22
              //)
          //),
        ),
      ],
    ),
  );
}