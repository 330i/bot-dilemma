import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialchatbotapp/leaderboard.dart';
import 'package:socialchatbotapp/login.dart';
import 'login.dart';
import 'placeholder.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  TextEditingController nameInputController;
  TextEditingController emailInputController;
  TextEditingController passwordInputController;

  @override
  void initState() {
    super.initState();
    nameInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    passwordInputController = new TextEditingController();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String passwordValidator(String value) {
    if (value.length < 8) {
      return 'Password length must be longer than 8 characters';
    }
    else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //SizedBox(height: 20.0,),
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15.0, 100.0, 0.0, 0.0),
                        child: Text('Network',
                            style: TextStyle(
                                fontSize: 70.0, fontWeight: FontWeight.w300, color: Colors.black)),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                        child: Text('Sign Up',
                            style: TextStyle(
                                fontSize: 60.0, fontWeight: FontWeight.bold, color: Colors.black)),

                      ),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                    child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            style: TextStyle(
                                color: Colors.black
                            ),
                            controller: nameInputController,
                            decoration: InputDecoration(
                                labelText: 'NAME',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                // hintText: 'EMAIL',
                                // hintStyle: ,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green))),
                            validator: emailValidator,
                          ),
                          TextFormField(
                            style: TextStyle(
                                color: Colors.black
                            ),
                            controller: emailInputController,
                            decoration: InputDecoration(
                                labelText: 'EMAIL',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                // hintText: 'EMAIL',
                                // hintStyle: ,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green))),
                            validator: emailValidator,
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            style: TextStyle(
                                color: Colors.black
                            ),
                            controller: passwordInputController,
                            decoration: InputDecoration(
                                labelText: 'PASSWORD ',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green))),
                            obscureText: true,
                            validator: passwordValidator,
                          ),
                          SizedBox(height: 50.0),
                          GestureDetector(
                              onTap: () {
                                print("pass");
                                FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailInputController.text, password: passwordInputController.text).then(
                                        (currentUser) {
                                      Firestore.instance.collection('users').document(currentUser.user.uid).setData({
                                        "name":nameInputController.text,
                                        "email":emailInputController.text,
                                        "uid":currentUser.user.uid,
                                        "points":0,
                                      });
                                      final userid = currentUser.user.uid;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => LeaderBoard()),
                                      );
                                    });
                              },
                              child: Container(
                                height: 50.0,
                                child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  shadowColor: Colors.greenAccent,
                                  color: Colors.green,
                                  elevation: 7.0,
                                  child: Center(
                                    child: Text(
                                      'SIGNUP',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat'),
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(height: 20.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 30.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                shadowColor: Colors.blueAccent,
                                child: Center(
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ]),
        ));
  }
}
