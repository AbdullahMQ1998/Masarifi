

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/Provider/dark_them.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flash_chat/constants.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flash_chat/functions/AlertButtonFunction.dart';
import 'package:flash_chat/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddExpenseScreen extends StatefulWidget {

  final Function addExpense;
  final User loggedUser;
  final List<QueryDocumentSnapshot> userInfo;

  AddExpenseScreen(this.addExpense, this.loggedUser, this.userInfo);

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  String expenseName;
  String expenseCost;
  int expenseID;
  DateTime selectedDate = DateTime.now();
  bool isEnabled = false;
  String formattedDate;
  String formattedTime;
  double currentTotalExpense;
  double currentTotalBudget;
  final _fireStore = FirebaseFirestore.instance;
  SharedPreferences preferences;




  bool checkNullorSpace() {
    if (expenseName != null &&
        expenseName != '' &&
        expenseCost != null &&
        expenseCost != '' &&
        formattedDate != null &&
        formattedDate != '' &&
        formattedTime != null &&
        formattedTime != '') {
      return true;
    } else {
      return false;
    }
  }


  int picker = 0;


  String dropdownValue;


  void showCupertionPicker(){

    showCupertinoModalPopup(context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            child: CupertinoPicker(

                backgroundColor: CupertinoColors.white
                ,itemExtent: 32, onSelectedItemChanged: (value){
              setState(() {
                picker = value;
              });

            },
                children: [
                  Text('Restaurants'),
                  Text('Shopping'),
                  Text('Gas'),
                  Text('Coffee'),
                  Text('Finance'),
                  Text('Grocery'),
                  Text('Furniture'),
                  Text('Health'),
                  Text('Online-Shopping'),
                  Text('Entertainment'),
                  Text('Education'),
                  Text('Other')
                ]
            ),
          );});

  }


  void showArabicCupertionPicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            child: CupertinoPicker(
                backgroundColor: CupertinoColors.white,
                itemExtent: 32,
                onSelectedItemChanged: (value) {
                  setState(() {
                    picker = value;
                  });
                },
                children: [
                  Text('مطاعم'),
                  Text('تسوق'),
                  Text('بنزين'),
                  Text('قهوة'),
                  Text('مالية'),
                  Text('بقالة'),
                  Text('أثاث'),
                  Text('صحة'),
                  Text('تسوق إلكتروني'),
                  Text('ترفيه'),
                  Text('تعليم'),
                  Text('اخرى')
                ]),
          );
        });
  }


 bool dropDownChanged = false;
  String currentLang = "ar";

  void getCurrenLanguage() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      currentLang = preferences.getString('language');
    });

  }




  @override
  void initState() {
   getCurrenLanguage();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    if(dropDownChanged == false)
    dropdownValue = currentLang == "ar" ? "مطاعم" :'Restaurants';

    Map<String, String> arabicCategory = {
      'Restaurants': 'مطاعم',
      'Shopping': "تسوق",
      'Gas': "بنزين",
      'Coffee': "قهوة",
      'Finance': "مالية",
      'Grocery': "بقالة",
      'Furniture': "أثاث",
      'Health': "صحة",
      'Online-Shopping': "تسوق إلكتروني",
      'Entertainment': "ترفيه",
      'Education': "تعليم",
      'Other': "أخرى"
    };

    Map<String, String> arabicToEnglish = {
      'مطاعم': 'Restaurants',
      "تسوق": 'Shopping',
      "بنزين": 'Gas',
      "قهوة": 'Coffee',
      "مالية": 'Finance',
      "بقالة": 'Grocery',
      "أثاث": 'Furniture',
      "صحة": 'Health',
      "تسوق إلكتروني": 'Online-Shopping',
      "ترفيه": 'Entertainment',
      "تعليم": 'Education',
      "أخرى": 'Other',
    };


    Map<String,int> expenseCategoryInt = {
      'Restaurants':0,
      'Shopping':1,
      'Gas':2,
      'Coffee':3,
      'Finance':4,
      'Grocery':5,
      'Furniture':6,
      'Health':7,
      'Online-Shopping':8,
      'Entertainment':9,
      'Education':10,
      'Other':11
    };

    Map<int,String> expenseCategoryString = {
      0 : 'Restaurants',
      1 : 'Shopping',
      2: 'Gas',
      3: 'Coffee',
      4: 'Finance',
      5: 'Grocery',
      6: 'Furniture',
      7:'Health',
      8:'Online-Shopping',
      9:'Entertainment',
      10:'Education',
      11:'Other'

    };

    Map<int, String> arabicExpenseCategoryString = {
      0: 'مطاعم',
      1: 'تسوق',
      2: 'بنزين',
      3: 'قهوة',
      4: 'مالية',
      5: 'بقالة',
      6: 'أثاث',
      7: 'صحة',
      8: 'تسوق إلكتروني',
      9: 'ترفيه',
      10: 'تعليم',
      11: 'أخرى'
    };


    final themChange = Provider.of<DarkThemProvider>(context);
    return Scaffold(
      backgroundColor: themChange.getDarkTheme()? Colors.grey.shade800 : Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(

                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                )),
            child: Column(

              children: [
                Text(
                  '${S.of(context).addExpense}',
                  style: TextStyle(
                      color: Color(0xff01937C),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 50, right: 50, top: 20, bottom: 20),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        maxLength: 15,
                        textAlign: TextAlign.center,

                        onChanged: (text) {
                          setState(() {
                            expenseName = text;
                          });
                        },
                        decoration:
                            kTextFieldDecoration.copyWith(hintText: '${S.of(context).expenseName}'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        maxLength: 6,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.numberWithOptions(signed: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) {
                          setState(() {
                            expenseCost = value;
                          });
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: '${S.of(context).expenseCost}',
                          suffixText: '${S.of(context).saudiRyal}',
                          suffixStyle: TextStyle(),

                        ),
                      ),
                    ),
                    Platform.isIOS? Container(
                      child: FlatButton(onPressed: (){
                        currentLang == "ar" ? showArabicCupertionPicker() :
                        showCupertionPicker();
                      }, child: currentLang == 'ar' ? Text('${arabicExpenseCategoryString[picker]}') : Text('${expenseCategoryString[picker]}')),
                    ): currentLang == "ar" ? DropdownButton(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 10,
                      style: const TextStyle(color: Colors.grey),
                      underline: Container(
                        height: 1,
                        color: Color(0xff01937C),
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                          dropDownChanged = true;
                        });
                      },
                      items: <String>[
                        'مطاعم',
                        "تسوق",
                        "بنزين",
                        "قهوة",
                        "مالية",
                        "بقالة",
                        "أثاث",
                        "صحة",
                        "تسوق إلكتروني",
                        "ترفيه",
                        "تعليم",
                        "أخرى",
                      ]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ) : DropdownButton(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 10,
                style: const TextStyle(color: Colors.grey),
                underline: Container(
                  height: 1,
                  color: Color(0xff01937C),
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                    dropDownChanged = true;
                  });
                },
                items: <String>[
                  'Restaurants',
                  'Shopping',
                  'Gas',
                  'Coffee',
                  'Finance',
                  'Grocery',
                  'Furniture',
                  'Health',
                  'Online-Shopping',
                  'Entertainment',
                  'Education',
                  'Other'
                ]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),

                  ]),
                ),
                FlatButton(
                  onPressed: () {
                    formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
                    formattedTime = DateFormat().add_jm().format(selectedDate);
                    if (checkNullorSpace()) {
                      currentTotalBudget = double.parse(widget.userInfo[0].get('userBudget'));
                      currentTotalBudget -= double.parse(expenseCost);
                      widget.userInfo[0].reference
                          .update({'userBudget': currentTotalBudget.toString()});

                      currentTotalExpense =
                          double.parse(widget.userInfo[0].get('totalExpense'));
                      currentTotalExpense += double.parse(expenseCost);
                      widget.userInfo[0].reference
                          .update({'totalExpense': currentTotalExpense.toString()});

                      expenseID = widget.userInfo[0].get('expenseNumber');
                      expenseID += 1;
                      widget.userInfo[0].reference
                          .update({'expenseNumber': expenseID});

                      _fireStore.collection('expense').add({
                        'email': widget.loggedUser.email,
                        'expenseCost': expenseCost,
                        'expenseDate': selectedDate,
                        'expenseName': expenseName,
                        'expenseTime': formattedTime,
                        'expenseID': expenseID,
                        'expenseIcon': Platform.isIOS? expenseCategoryString[picker] : currentLang == "ar" ? arabicToEnglish[dropdownValue] :dropdownValue,
                      });

                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      showErrorAlertDialog(context);
                    }
                  },
                  child: Text(
                    '${S.of(context).add}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  color: Color(0xff01937C),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
