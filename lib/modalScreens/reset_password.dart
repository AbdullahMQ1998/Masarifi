import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';




class ResetPassword extends StatefulWidget {



  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String email;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {



    return Container(
        color: Color(0xff757575),
    child: Container(
    padding: EdgeInsets.all(50),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
    topRight: Radius.circular(20),
    topLeft: Radius.circular(20),
    )),
      child: Column(
        children: [


          Text(
            'Forget your password?',
            style: TextStyle(
                color: Color(0xff01937C),
                fontSize: 25,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),

      SizedBox(
        height: 20,
      ),

      Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.emailAddress,
        autofocus: true,
        onChanged: (text) {
          setState(() {
            email = text;
          });

        },
        decoration:
        kTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
      ),
    ),


          SizedBox(
            height: 20,
          ),

          TextButton(
            onPressed: () {
              if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)){
                Alert(context: context, title: "ERROR", desc: "Please make sure you've entered a valid Email").show();
              }
              else{
                _auth.sendPasswordResetEmail(email: email);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Reset Password',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                ),),
            ),
            style: ButtonStyle(

                backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xff01937C)
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )
                )
            ),
          ),








        ],
      ),
    ),
    );
  }
}