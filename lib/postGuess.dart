import 'package:flutter/material.dart';



class PostGuess extends StatefulWidget {
  @override
  _PostGuessState createState() => _PostGuessState();
}

class _PostGuessState extends State<PostGuess>  {
  //Sample Data... idk make constructors if you want idk how tf to do that tho
  bool wasCorrect = false;
  int totalMessages = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/Back.png'),
    fit: BoxFit.cover)),
    child: Scaffold(
    backgroundColor: Colors.transparent,
      body: getWidget(wasCorrect, totalMessages),
      //NAV BAR
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[200],
        child: Icon(
          Icons.home,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 9,
        color: Colors.grey[200],
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.grey[200],
                onPressed: () {},
                child: Text('LeaderBoards'),
              ),
              SizedBox(
                width: 60,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.grey[200],
                onPressed: () {},
                child: Text('Sign-Out'),
              )
            ],
          ),
        ),
      ),
              )
    );
  }
}

Widget getWidget(bool youCorrect, int messages) {
    return Align(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  getColorOne(youCorrect),
                  getColorTwo(youCorrect)
                ])),
            child: Column(
                children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Container(
                          width: 250,
                          child: Text(
                            getText(youCorrect,),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 40, color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: [
                            Container(
                              width: 250,
                              child: Text(
                                getNextText(youCorrect),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 26),
                              ),
                            ),
                            SizedBox(height: 100),
                            Container(
                              width: 200,
                                height: 200,
                                child: Image.asset(
                                    getImage(youCorrect),
                                  fit: BoxFit.cover,
                                )
                            ),
                            SizedBox(height: 20),
                            SizedBox(height: 20),
                            Container(
                              width: 300,
                              child: Text(
                                getPointsEarned(youCorrect),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 30, color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 300,
                              child: Text(
                                "If your opponent guesses wrong we will add 50 more points",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ]
            )
        )
    );
}


int getScore (bool Correctness, int messages){
  int score = 0;
}

Color getColorOne (bool Correctness) {
  print(Correctness);
  if(Correctness == true){
    return Colors.transparent;
  }else{
    return Colors.transparent;
  }
}

Color getColorTwo (bool Correctness) {
  if(Correctness == true){
    return Colors.transparent;
  }else{
    return Colors.transparent;
  }
}

String getText (bool Correctness){
  if(Correctness == true){
    return "Congrats!";
  }else{
    return "Uh-Oh!";
  }
}

String getNextText(bool Correctness){
  if(Correctness == true){
    return "You guessed it properly!";
  }else{
    return "You got tricked!";
  }
}

String getImage(bool Correctness){
  if(Correctness == true){
    return 'assets/images/ThumbsUP.png';
  }else{
    return 'assets/images/ThumbsDown.png';
  }
}

String getPointsEarned(bool Correctness){
  if(Correctness == true){
    return "You get 50 points!";
  }else{
    return "You get 0 points...";
  }
}
