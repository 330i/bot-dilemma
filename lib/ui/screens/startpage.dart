import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(''), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 100),
                        Text('Welcome',
                            style: TextStyle(
                                fontSize: 50,
                                color: Colors.black)),
                        SizedBox(height: 10),
                        Text(
                          'Prasann',
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ),
                        SizedBox(height: 100),

                        //Total Post
                        SizedBox(height: 100),
                        RaisedButton(
                          child: Text(
                            'Start Game',
                            style: TextStyle(color: Colors.black, fontSize: 24),
                          ),
                          color: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.orange),
                          ),
                        ),
                        SizedBox(height: 60),

                        Container(
                          margin: EdgeInsets.only(left: 30, top: 80, right: 30,),
                          height: 100,
                          width: 330,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10),
                          Text('Your Total Score',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black)),
                                SizedBox(height: 10),
                          Text('506',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black)),
                          ]

                          ),
                          ),
          ]
                        ),
                      ])

                ));
  }
}
