
import 'dart:io';

import 'package:flash_chat/Provider/dark_them.dart';
import 'package:flash_chat/chartsData/categoryClass.dart';
import 'package:flash_chat/functions/AlertButtonFunction.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/Components/Rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register_user_info.dart';
import 'package:flash_chat/generated/l10n.dart';

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
  String confirmPass;
  bool isConfirmed = false;
  bool isEmpty = true;
  SharedPreferences preferences;


  void getPref() async{
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themChange = Provider.of<DarkThemProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                onChanged: (value){
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: '${S.of(context).enterYourMail}' ,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide( width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                    fillColor: themChange.getDarkTheme()? Colors.grey.shade800 : Colors.grey.shade300,
                    filled: true),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,

                onChanged: (value){
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: '${S.of(context).enterYourPass}' ,

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide( width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                    fillColor: themChange.getDarkTheme()? Colors.grey.shade800 : Colors.grey.shade300,
                    filled: true),
              ),

              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,

                onChanged: (value){
                  confirmPass = value;
                },
                onSubmitted: (v){
                  setState(() {
                    if(confirmPass == password){
                      isConfirmed = true;
                    }
                    if(confirmPass != password){
                      isConfirmed = false;
                    }
                    isEmpty = false;
                    if(v.isEmpty)
                      isEmpty = true;
                  });

                },
                decoration: kTextFieldDecoration.copyWith(hintText: '${S.of(context)}' ,

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide( width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    fillColor: themChange.getDarkTheme()? Colors.grey.shade800 : Colors.grey.shade300,
                    filled: true),
              ),
              SizedBox(
                height: 24.0,
              ),
              paddingButton( Color(0xff01937C), '${S.of(context).register}', () async {
                if (isEmpty) {
                  Platform.isIOS?
                  showIOSGeneralAlert(context, "${S
                      .of(context)
                      .makeSureyoufilled}") : showGeneralErrorAlertDialog(context, "${S.of(context).error}", '${S
                      .of(context)
                      .makeSureyoufilled}');
                }
                else if (isConfirmed == false) {
                  Platform.isIOS?
                  showIOSGeneralAlert(context, "${S.of(context).passwordNotCorrect}") : showGeneralErrorAlertDialog(context,"${S.of(context).error}", '${S
                      .of(context)
                      .passwordNotCorrect}');
                }

                else {
                  setState(() {
                    showSpinner = true;
                  });
                  if (email == null || password == null) {
                    email = '';
                    password = '';
                  }
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password).catchError((err) {
                    Platform.isIOS
                        ? showIOSGeneralAlert(context, err.message)
                        : showGeneralErrorAlertDialog(context, 'Error',
                        err.message);
                  }
                  );

                  try {
                    if (newUser != null) {
                      if (email != null && password != null) {
                        preferences.setString('Email', email);
                        preferences.setString('Pass', password);
                      }
                      Navigator.pushNamed(context, RegisterUserInfo.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                }
              }),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${S.of(context).alreadyHaveAccount}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),),
                  TextButton(onPressed: (){

                    Navigator.push( (context), MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen()));
                  }, child: Text('${S.of(context).loginHere}',
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
