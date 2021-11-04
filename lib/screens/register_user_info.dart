import 'package:flash_chat/Components/Rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'home_screen.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';

class RegisterUserInfo extends StatelessWidget {
  static const String id = 'register_user_info';

  @override
  Widget build(BuildContext context) {
    String userName;
    String age;
    String gender;

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

            DropDown<String>(
              items: ["Male", "Female", "Other"],
              hint: Text("Male"),
              icon: Icon(
                Icons.expand_more,
                color: Colors.blue,
              ),
              onChanged: (value) {
                gender = value;
              },
            ),



            paddingButton(Colors.blue, "Submit", (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(userName, age , gender)));
            })

          ],



        ),
      )

    );
  }
}


