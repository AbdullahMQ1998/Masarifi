import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/Components/Rounded_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/generated/l10n.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome_screen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = ColorTween(begin: Colors.grey , end: Colors.white).animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {
        
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60,
                  ),
                ),
                TypewriterAnimatedTextKit(text: ['${S.of(context).masarifi}'], textStyle: TextStyle(
                  fontSize: 45.0,
                  fontWeight: FontWeight.w900,
                ),
                speed: Duration(milliseconds: 250),),

              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            paddingButton(Color(0xff16C79A),'${S.of(context).logIn}' , () {
              Navigator.pushNamed(context, LoginScreen.id);
            }),
            paddingButton(Color(0xff01937C), '${S.of(context).register}', (){
              Navigator.pushNamed(context, RegistrationScreen.id);
            }),

          ],
        ),
      ),
    );
  }
}


