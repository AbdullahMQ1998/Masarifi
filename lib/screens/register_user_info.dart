import 'package:flash_chat/Components/Rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'home_screen.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';

class RegisterUserInfo extends StatefulWidget {
  static const String id = 'register_user_info';

  @override
  _RegisterUserInfoState createState() => _RegisterUserInfoState();
}

class _RegisterUserInfoState extends State<RegisterUserInfo> {
  @override
  Widget build(BuildContext context) {
    String userName;
    String age;
    String gender;
    String matiralStats;
    String occupation;
    String monthlyIncome;

    return Scaffold(

      body: SafeArea(
        child: Column(

          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                userName = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your User name'),
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                age = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Age'),
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                monthlyIncome = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your monthly income'),
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                monthlyIncome = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Enter the number of your children'),
            ),

            DropDown<String>(
              items: ["Single", "Married","divorced"],
              hint: Text("Single"),
              icon: Icon(
                Icons.expand_more,
                color: Colors.blue,
              ),
              onChanged: (value) {
                setState(() {
                  matiralStats = value;
                });
              },
            ),
            DropDown<String>(
              items: ["Male", "Female"],
              hint: Text("Male"),
              icon: Icon(
                Icons.expand_more,
                color: Colors.blue,
              ),
              onChanged: (value) {
                gender = value;
              },
            ),
            DropDown<String>(
              items: ["Employed", "Unemployed"],
              hint: Text("Employed"),
              icon: Icon(
                Icons.expand_more,
                color: Colors.blue,
              ),
              onChanged: (value) {
                occupation = value;
                print(occupation);
                print(matiralStats);
                print(monthlyIncome);
                print(gender);
                print(age);
                print(userName);
              },
            ),






            paddingButton(Colors.blue, "Submit", (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(userName, age , gender, matiralStats,occupation,monthlyIncome)));
            })

          ],



        ),
      )

    );
  }
}


