import 'package:flash_chat/Components/Rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'home_screen.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterUserInfo extends StatefulWidget {
  static const String id = 'register_user_info';

  @override
  _RegisterUserInfoState createState() => _RegisterUserInfoState();
}

class _RegisterUserInfoState extends State<RegisterUserInfo> {
  String userName;
  String age;
  String gender;
  String matiralStats;
  String occupation;
  String monthlyIncome;
  String nmbOfChild;

  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  User loggedUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    final user = await _auth.currentUser;
    try {
      if (user != null) {
        loggedUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

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
            // we move the loggedUser to the homeScreen so we can retrieve data from it.
            if(checkNullorSpace()) {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  HomeScreen(
                      loggedUser
                  ))
              );
              // add the user information to the database from here
              _fireStore.collection('User_Info').add({
                'userName':userName,
                'email': loggedUser.email,
                'age':age,
                'gender':gender,
                'matiralStats':matiralStats,
                'monthlyIncome':monthlyIncome,
                'nmbOfChild':nmbOfChild,
                'occupation':occupation,
              });
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


