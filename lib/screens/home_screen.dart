import 'package:flutter/material.dart';
import 'register_user_info.dart';




class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';
  final String userName;
  final String age;
  final String gender;
  final String matiralStats;
  final String occupation;
  final String monthlyIncome;
  final String nmbOfChild;

  HomeScreen(this.userName,this.age,this.gender,this.matiralStats,this.occupation,this.monthlyIncome,this.nmbOfChild);



  @override
  Widget build(BuildContext context) {

  print(userName);

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
            Text(matiralStats,style: TextStyle(
                fontSize: 30
            ),),
            Text(occupation,style: TextStyle(
                fontSize: 30
            ),),
            Text(monthlyIncome,style: TextStyle(
                fontSize: 30
            ),),
            Text(nmbOfChild,style: TextStyle(
                fontSize: 30
            ),),

            FloatingActionButton(onPressed: () {Navigator.pop(context);}),

          ],
        ),
      ),
    );
  }
}
