import 'package:flash_chat/Components/Rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'home_screen.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegisterUserInfo extends StatefulWidget {
  static const String id = 'register_user_info';
  String userName;
  String age;
  String gender;
  String matiralStats;
  String occupation;
  String monthlyIncome;
  String nmbOfChild;

  bool checkNullorSpace(String name , String age,String monthlyIncome,String nmbofchild){

    if(name != null || name != ' ' && age != null || age != ' ' && monthlyIncome != null || monthlyIncome != ' ' &&  nmbofchild != null || nmbofchild != ' ')
      return true;
    else
      return false;

  }

  @override
  _RegisterUserInfoState createState() => _RegisterUserInfoState();
}

class _RegisterUserInfoState extends State<RegisterUserInfo> {

  @override
  Widget build(BuildContext context) {


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
                setState(() {
                  widget.userName = value;
                });
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your User name'),
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  widget.age = value;
                });

              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Age'),
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  widget.monthlyIncome = value;
                });
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your monthly income'),
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  widget.nmbOfChild = value;
                });
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Enter the number of your children'),
            ),

            DropDown<String>(
              items: ["Single", "Married","divorced"],
              hint: Text("Single"),
              initialValue: widget.matiralStats = "Single",
              icon: Icon(
                Icons.expand_more,
                color: Colors.blue,
              ),
              onChanged: (value) {
                setState(() {
                  widget.matiralStats = value;
                });
              },
            ),
            DropDown<String>(
              items: ["Male", "Female"],
              hint: Text("Male"),
              initialValue: widget.gender = "Male",
              icon: Icon(
                Icons.expand_more,
                color: Colors.blue,
              ),
              onChanged: (value) {
                setState(() {
                  widget.gender = value;
                });
              },
            ),
            DropDown<String>(
              items: ["Employed", "Unemployed"],
              hint: Text("Employed"),
              initialValue: widget.occupation = "Employed",
              icon: Icon(
                Icons.expand_more,
                color: Colors.blue,
              ),
              onChanged: (value) {
                setState(() {
                  widget.occupation = value;
                  print(widget.occupation);
                });

              },
            ),






            paddingButton(Colors.blue, "Submit", (){
              print(widget.checkNullorSpace(widget.userName, widget.age, widget.monthlyIncome, widget.nmbOfChild));
              if(widget.checkNullorSpace(widget.userName, widget.age, widget.monthlyIncome, widget.nmbOfChild)) {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    HomeScreen(
                        widget.userName,
                        widget.age,
                        widget.gender,
                        widget.matiralStats,
                        widget.occupation,
                        widget.monthlyIncome,
                        widget.nmbOfChild
                    ))
                );
              }
              else{
                Alert(context: context, title: "Error", desc: "Make sure you filled the require information").show();
              }
            })
          ],



        ),
      )

    );
  }
}


