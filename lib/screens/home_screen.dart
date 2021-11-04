import 'package:flutter/material.dart';
import 'register_user_info.dart';




class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';
  final String userName;
  final String age;
  final String gender;

  HomeScreen(this.userName,this.age,this.gender);


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Text(userName,
            style: TextStyle(
              fontSize: 30,
            ),),
            Text(age, style: TextStyle(
              fontSize: 30
            ),),
            Text(gender,style: TextStyle(
              fontSize: 30
            ),),

            FloatingActionButton(onPressed: () {Navigator.pop(context);}),

          ],
        ),
      ),
    );
  }
}
