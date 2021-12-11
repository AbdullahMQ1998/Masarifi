import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/functions/AlertButtonFunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/generated/l10n.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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

  bool isEmployee = true;

  bool editGender = false;
  bool editGender2 = true;
  String gender;
  SharedPreferences preferences;


  bool editOccupation = false;
  bool editOccupation2 = true;
  String occupation;




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




 DateTime selectedDate;

  bool dateChanged = false;

  _selectDate(BuildContext context) async {


    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2021),
        lastDate: DateTime(2090),
        selectableDayPredicate: _decideWhichDayToEnable
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        dateChanged = true;
        selectedDate = picked;
      });
  }


  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))))) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (!editGender && editGender2) {
      gender = widget.userInfo.get('gender');
      if(currentLang == "ar"){
        gender =  genderTransaltorEArb[widget.userInfo.get('gender')];
      }
    }






    Map<String,String> occupationTranslator ={
      "موظف" : "Employed",
      "غير موظف" : "Unemployed",
      "متقاعد" : "Retired"
    };

    Map<String,String> occupationTranslatorEng ={
        "Employed":"موظف",
       "Unemployed": "غير موظف",
     "Retired"  :"متقاعد",
    };

    if(!editOccupation && editOccupation2){
      occupation = widget.userInfo.get('occupation');
      if(currentLang == 'ar'){
        occupation = occupationTranslatorEng[widget.userInfo.get('occupation')];
      }
    }

    Timestamp currentdate = widget.userInfo.get('expectedRetireDate');


    if(dateChanged == false)
    selectedDate = DateTime.parse(currentdate.toDate().toString());


    void newGender(){

    }

    void newOccupation(){

    }

    return Scaffold(



      resizeToAvoidBottomInset: true,
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
                   if(double.tryParse(monthlyIncome) != null)
                   widget.userInfo.reference
                       .update({'monthlyIncome': monthlyIncome});
                   else
                     showIOSGeneralAlert(context, "${S.of(context).rightNumber}");

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
                     occupation = widget.userInfo.get('occupation');
                   }


                   if(selectedDate == null){
                     selectedDate == widget.userInfo.get('expectedRetireDate');
                   }

                   widget.userInfo.reference.update({'expectedRetireDate': selectedDate});

                   widget.userInfo.reference.update({'gender': currentLang == "ar"? genderTransaltorENG[gender] : gender});
                   widget.userInfo.reference.update({'occupation': currentLang == "ar"? occupationTranslator[occupation] : occupation});

                   if(double.tryParse(monthlyIncome) != null && double.parse(monthlyIncome) > 0)
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
                  child: SingleChildScrollView(

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
                                        keyboardType: TextInputType.numberWithOptions(signed: true,decimal: true),
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
                                        child: Text(value,style: TextStyle(
                                            color: Colors.grey
                                        ),),
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
                                    child: Text(value,style: TextStyle(
                                        color: Colors.grey
                                    ),),
                                  );
                                }).toList(),
                              ))
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(),
                          child: Text(
                            '${S.of(context).occupation}',
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
                                    value: occupation,
                                    iconSize: 24,
                                    elevation: 10,
                                    style: const TextStyle(),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        editOccupation2 = false;
                                        editOccupation = false;
                                        occupation = newValue;
                                        setState(() {
                                          if(occupationTranslator[newValue] == 'Retired' || occupationTranslator[newValue] == 'Unemployed'){
                                            isEmployee = false;
                                          }
                                          else{
                                            isEmployee = true;
                                          }
                                        });
                                      });
                                    },
                                    items: <String>[
                                      'موظف',
                                      'غير موظف',
                                      'متقاعد',
                                    ].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,style: TextStyle(
                                          color: Colors.grey
                                        ),),
                                      );
                                    }).toList(),
                                  ) : DropdownButton(
                                    value: occupation,
                                    iconSize: 24,
                                    elevation: 10,
                                    style: const TextStyle(),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        editOccupation2 = false;
                                        editOccupation = false;
                                       occupation = newValue;
                                        setState(() {
                                          if(occupation == 'Retired' || occupation == 'Unemployed'){
                                            isEmployee = false;
                                          }
                                          else{
                                            isEmployee = true;
                                          }
                                        });
                                      });
                                    },
                                    items: <String>[
                                      'Employed',
                                      'Unemployed',
                                      'Retired'
                                    ].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,style: TextStyle(
                                            color: Colors.grey
                                        ),),
                                      );
                                    }).toList(),
                                  ))
                            ],
                          ),
                        ),

                        Visibility(
                          visible: isEmployee,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${S.of(context).expectedRetireDay}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                color: Colors.grey
                              ),),
                          ),
                        ),




                        Visibility(
                          visible: isEmployee,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 150,
                                child: TextButton(
                                  onPressed: () => _selectDate(context),
                                  child: Row(
                                      children:[
                                        Icon(Icons.calendar_today_rounded,
                                          color: Colors.grey,
                                        ),
                                        Text(" ${DateFormat('yyyy-MM-dd').format(selectedDate)}",
                                          style:
                                          TextStyle( fontWeight: FontWeight.bold , color: Colors.grey),
                                        ),
                                      ]
                                  ),
                                  style: ButtonStyle(

                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            side: BorderSide(color: Colors.grey),
                                          )
                                      )
                                  ),
                                ),
                              ),

                              IconButton(onPressed: () {
                                showGeneralErrorAlertDialog(context,'${S.of(context).retirementDate}','${S.of(context).retirementDateAnswer}');
                              }, icon: Icon(Icons.info_outline))


                            ],
                          ),
                        ),

                      ],
                    ),
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
