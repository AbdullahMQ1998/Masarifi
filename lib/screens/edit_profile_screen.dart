import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/chartsData/categoryClass.dart';
import 'package:flash_chat/functions/AlertButtonFunction.dart';
import 'package:flash_chat/screens/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/generated/l10n.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  SharedPreferences preferences;



  String currentLang = "ar";

  void getCurrenLanguage() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      currentLang = preferences.getString('language');
    });
  }


  Map<String,String> genderTransaltorEArb = {

    'Male' : 'ذكر',
    'Female' : 'انثى'

  };

  Map<String,String> genderTransaltorENG = {

     'ذكر' :'Male' ,
  'انثى'  :'Female' ,

  };

  @override
  void initState() {
    // TODO: implement initState
    getCurrenLanguage();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    if (!editGender && editGender2) {
      gender = widget.userInfo.get('gender');
      if(currentLang == "ar"){
        gender =  genderTransaltorEArb[widget.userInfo.get('gender')];
      }
    }




    return Scaffold(

      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor:Color(0xFF01937C) ,
       flexibleSpace: SafeArea(
         child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [

             Expanded(child: SizedBox()),
             Text(
               '${S.of(context).editProfile}',
               style: TextStyle(
                   fontSize: 20,
                   fontWeight: FontWeight.bold,
                   color: Colors.white),
             ),

             Expanded(
               child: FlatButton(
                 minWidth: 0,
                 onPressed: () {
                   if (userName == null ||
                       userName == "" ||
                       userName == " ") {
                     userName = widget.userInfo.get('userName');
                   }
                   widget.userInfo.reference
                       .update({'userName': userName});

                   if (monthlyIncome == null ||
                       monthlyIncome == "" ||
                       monthlyIncome == " ") {
                     monthlyIncome =
                         widget.userInfo.get('monthlyIncome');
                   }
                   widget.userInfo.reference
                       .update({'monthlyIncome': monthlyIncome});

                   double totalExpense =
                   double.parse(widget.userInfo.get('totalExpense'));
                   double totalMonthlyBill = double.parse(
                       widget.userInfo.get('totalMonthlyBillCost'));

                   double totalBudget =
                       (double.parse(monthlyIncome) * 0.80) -
                           totalExpense -
                           totalMonthlyBill;
                   widget.userInfo.reference
                       .update({'userBudget': totalBudget.toString()});

                   if (monthlyIncome == null) {
                     gender = widget.userInfo.get('gender');
                   }
                   widget.userInfo.reference.update({'gender': currentLang == "ar"? genderTransaltorENG[gender] : gender});

                   Navigator.pop(context);
                 },
                 child: Text(
                   '${S.of(context).save}',
                   style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 15,
                       color: Colors.white),
                 ),
               ),
             )

           ],
          ),
       ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Color(0xff01937C),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Container(
                    width: 150,
                    height: 150,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                          'images/${widget.userInfo.get('gender')}.png'),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff01937C),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              // color: Colors.white,
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
                          '${S.of(context).userName}',
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
                            editUsername
                                ? Expanded(
                                    child: TextField(
                                      onSubmitted: (value) {
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
                                  )
                                : Text(
                                    userName == null
                                        ? widget.userInfo.get('userName')
                                        : userName,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Container(
                                height: 25,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        editUsername = true;
                                      });
                                    },
                                    icon: Icon(Icons.edit)),
                              ),
                            )
                          ],
                        ),
                      ),
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
                          '${S.of(context).email}',
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
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                          '${S.of(context).monthlyIncome}',
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
                            editMonthlyIncome
                                ? Expanded(
                                    child: TextField(
                                      onSubmitted: (value) {
                                        setState(() {
                                          if (double.parse(monthlyIncome) <= 999) {
                                            Platform.isIOS? showIOSGeneralAlert(context, "${S.of(context).overThousnd}"):showGeneralErrorAlertDialog(
                                                context,
                                                '${S.of(context).error}',
                                                '${S.of(context).overThousnd}');
                                            monthlyIncome = null;
                                          }
                                          else
                                            editMonthlyIncome = false;
                                        });
                                      },
                                      keyboardType: TextInputType.numberWithOptions(signed: true),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
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
                                  )
                                : Text(
                                    monthlyIncome == null
                                        ? '${widget.userInfo.get('monthlyIncome')} ${S.of(context).saudiRyal}'
                                        : '$monthlyIncome ${S.of(context).saudiRyal}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Container(
                                height: 25,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        editMonthlyIncome = true;
                                      });
                                    },
                                    icon: Icon(Icons.edit)),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Divider(
                          thickness: 3,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(),
                        child: Text(
                          '${S.of(context).gender}',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: currentLang == 'ar' ? DropdownButton(
                                  value: gender,
                                  iconSize: 24,
                                  elevation: 10,
                                  style: const TextStyle(),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      editGender2 = false;
                                      editGender = false;
                                      gender = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'ذكر',
                                    'انثى',
                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ) : DropdownButton(
                              value: gender,
                              iconSize: 24,
                              elevation: 10,
                              style: const TextStyle(),
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
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
