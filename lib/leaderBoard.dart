import 'package:flutter/material.dart';

class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Point Leaderboard"
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent[100],
        child: Icon(
          Icons.home,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 9,
        color: Colors.blueAccent[100],
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
                color: Colors.blueAccent[200],
                onPressed: () {},
                child: Text('Sign-Out'),
              )
            ],
          ),
        ),
      ),
      //ENTRIES
      body: Container(
        child: ListView(
            children: [

                //for each entry use getCard()
            ],
          )
      ),
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