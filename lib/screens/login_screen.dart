import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/Components/Rounded_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';

import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'home_screen.dart';
class LoginScreen extends StatefulWidget {
  static const String id = "login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  User loggedUser;
  QueryDocumentSnapshot userInfo;
  String email;
  String password;
  bool showSpinner = false;


  @override
  void initState() {
    super.initState();
  }

  void getCurrentUser() async {
    final user = await _auth.currentUser;
    try {
      if (user != null) {
        loggedUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void getData() async {
    StreamBuilder<QuerySnapshot>(
      // Here in the stream we get the user info from the database based on his email, we will get all of his information
        stream: FirebaseFirestore.instance
            .collection('User_Info')
            .where('email', isEqualTo: loggedUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator(
              backgroundColor: Colors.blueAccent,
            );
          }

          final user = snapshot.data.docs;
          userInfo = user[0];
          print(userInfo.get('darkMode'));


          return Text('');
        });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Password'),
              ),
              SizedBox(
                height: 24.0,
              ),





              paddingButton(Colors.lightBlueAccent, 'Log in', () async{
                setState(() {
                  showSpinner = true;
                });
                final user = await _auth.signInWithEmailAndPassword(email: email, password: password);

                try{
                if(user != null) {
                  getCurrentUser();
                  getData();
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      HomeScreen(
                          loggedUser,
                      ))
                  );

                }
                setState(() {
                  showSpinner = false;
                });}
                catch(e){
                  print(e);
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
