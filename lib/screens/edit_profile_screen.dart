import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/screens/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

class EditProfileScreen extends StatefulWidget {
  final QueryDocumentSnapshot userInfo;
  EditProfileScreen(this.userInfo);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  bool editUsername = false;
  String userName;

  bool editMonthlyIncome = false;
  String monthlyIncome;

  bool editGender = false;
  bool editGender2 = true;
  String gender;


  @override
  Widget build(BuildContext context) {


    if(!editGender && editGender2)
      gender = widget.userInfo.get('gender');


    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Color(0xff50c878),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_outlined),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.white,
                      ),
                      Expanded(child: SizedBox()),
                      Center(
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      FlatButton(
                        minWidth: 0,
                        onPressed: () {

                          if(userName == null || userName == "" || userName == " "){
                            userName = widget.userInfo.get('userName');
                          }
                          widget.userInfo.reference.update({'userName': userName});


                          if(monthlyIncome == null || monthlyIncome == "" || monthlyIncome == " "){
                            monthlyIncome = widget.userInfo.get('monthlyIncome');
                          }
                          widget.userInfo.reference.update({'monthlyIncome': monthlyIncome});

                          double totalExpense = double.parse(widget.userInfo.get('totalExpense'));
                          double totalMonthlyBill = double.parse(widget.userInfo.get('totalMonthlyBillCost'));

                          double totalBudget = (double.parse(monthlyIncome) * 0.80) - totalExpense - totalMonthlyBill;
                          widget.userInfo.reference.update({'userBudget': totalBudget.toString() });


                          if(monthlyIncome == null){
                            gender = widget.userInfo.get('gender');
                          }
                          widget.userInfo.reference.update({'gender': gender});



                          
                          Navigator.pop(context);

                        },
                        child: Text(
                          'SAVE',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 50),
                  child: Container(
                    width: 150,
                    height: 150,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                          'images/${widget.userInfo.get('gender')}.png'),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff50c878),
                    ),
                  ),
                ),
              ],
            ),
          ),


          Expanded(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //UserName
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Username',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              editUsername? Expanded(
                                child: TextField(
                                  onSubmitted: (value){
                                    setState(() {
                                      editUsername = false;
                                    });
                                  },

                                  maxLength: 25,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    hintText: userName,
                                    counter: Offstage(),
                                    disabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  onChanged: (text) {
                                    setState(() {
                                      userName = text;
                                    });
                                  },
                                ),
                              ):Text(
                                userName == null ? widget.userInfo.get('userName') : userName,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Container(
                                  height: 25,
                                  child: IconButton(
                                      onPressed: (){
                                        setState(() {
                                          editUsername = true;
                                        });
                                  }, icon: Icon(Icons.edit)),
                                ),
                              )
                            ],
                          ),),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Divider(
                          thickness: 3,
                        ),
                      ),

                      //Email
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Email',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           Padding(
                             padding: const EdgeInsets.only(bottom: 10),
                             child: Text(
                                widget.userInfo.get('email'),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                           ),

                          ],
                        ),),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Divider(
                          thickness: 3,
                        ),
                      ),


                      // MonthlyIncome
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Monthly Income',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            editMonthlyIncome? Expanded(
                              child: TextField(
                                onSubmitted: (value){
                                  setState(() {
                                    editMonthlyIncome = false;
                                  });
                                },
                                keyboardType: TextInputType.numberWithOptions(),
                                maxLength: 6,
                                autofocus: true,
                                decoration: InputDecoration(
                                  hintText: userName,
                                  counter: Offstage(),
                                  disabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                onChanged: (text) {
                                  setState(() {
                                    monthlyIncome = text;
                                  });
                                },
                              ),
                            ):Text(
                              monthlyIncome == null ? '${widget.userInfo.get('monthlyIncome')} SAR' : '$monthlyIncome SAR',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Container(
                                height: 25,
                                child: IconButton(
                                    onPressed: (){
                                      setState(() {
                                        editMonthlyIncome = true;
                                      });
                                    }, icon: Icon(Icons.edit)),
                              ),
                            )
                          ],
                        ),),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Divider(
                          thickness: 3,
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Gender',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            editGender? Expanded(
                              child: DropdownButton(
                          value: gender,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 10,
                          style: const TextStyle(color: Colors.black),
                          underline: Container(
                            height: 1,
                            color: Color(0xff50c878),
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              editGender2 = false;
                              editGender = false;
                              gender = newValue;

                            });
                          },
                          items: <String>[
                            'Male',
                            'Female',
                          ]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )) :Text(
                              editGender2 ? widget.userInfo.get('gender') : gender,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Container(
                                height: 25,
                                child: IconButton(
                                    onPressed: (){
                                      setState(() {
                                        editGender = true;
                                      });
                                    }, icon: Icon(Icons.edit)),
                              ),
                            )
                          ],
                        ),),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Divider(
                          thickness: 3,
                        ),
                      ),




                    ],
                  ),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
