import 'package:flash_chat/Components/Rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'home_screen.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegisterUserInfo extends StatelessWidget {
  static const String id = 'register_user_info';
  String userName;
  String age;
  String gender;
  String matiralStats;
  String occupation;
  String monthlyIncome;
  String nmbOfChild;



  @override


  @override
  Widget build(BuildContext context) {


    bool checkNullorSpace(){

      if(userName != null && userName != '' && age != null && age != '' && monthlyIncome != null && monthlyIncome != '' && nmbOfChild != null && nmbOfChild != ''){
              return true;
      }
            else{
              return false;
            }

    }


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
                nmbOfChild = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Enter the number of your children'),
            ),

            DropDown<String>(
              items: ["Single", "Married","divorced"],
              hint: Text("Single"),
              initialValue:matiralStats = "Single",
              icon: Icon(
                Icons.expand_more,
                color: Colors.blue,
              ),
              onChanged: (value) {
                  matiralStats = value;
                }
            ),


            DropDown<String>(
              items: ["Male", "Female"],
              hint: Text("Male"),
              initialValue: gender = "Male",
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
              initialValue: occupation = "Employed",
              icon: Icon(
                Icons.expand_more,
                color: Colors.blue,
              ),
              onChanged: (value) {
                  occupation = value;
              },
            ),






            paddingButton(Colors.blue, "Submit", (){

            if(checkNullorSpace()) {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  HomeScreen(
                      userName,
                      age,
                      gender,
                      matiralStats,
                      occupation,
                      monthlyIncome,
                      nmbOfChild
                  ))
              );
            }
            else{
              Alert(context: context, title: "ERROR", desc: "Make sure you have filled the required information").show();
            }

            })
          ],



        ),
      )

    );
  }
}


