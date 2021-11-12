import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/Components/Rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'register_user_info.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = "registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F9F9),
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


                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Email',fillColor: Colors.white ,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,


                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Password',fillColor: Colors.white ,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),),
              ),
              SizedBox(
                height: 24.0,
              ),
              paddingButton( Color(0xff01937C), 'Register', () async {
                setState(() {
                  showSpinner = true;
                });
                final newUser = await _auth.createUserWithEmailAndPassword(
                    email: email, password: password);
                try {
                  if (newUser != null) {
                    Navigator.pushNamed(context, RegisterUserInfo.id);
                  }
                  setState(() {
                    showSpinner = false;
                  });
                } catch (e) {
                  print(e);
                }
              }),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),),
                  TextButton(onPressed: (){

                    Navigator.push( (context), MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen()));
                  }, child: Text('Login here',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff01937C),
                        fontSize: 15
                    ),))
                ],
              ),



            ],
          ),
        ),
      ),
    );
  }
}
