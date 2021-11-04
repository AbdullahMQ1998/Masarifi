import 'package:flash_chat/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/register_user_info.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    String userName;
    String age;
    String gender;
    String matiralStats;
    String occupation;
    String monthlyIncome;
    String nmbOfChild;

    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        RegisterUserInfo.id: (context) => RegisterUserInfo(),
        HomeScreen.id: (context) => HomeScreen(userName,age,gender,matiralStats,occupation,monthlyIncome,nmbOfChild),


      },
    );
  }
}
