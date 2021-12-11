import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/Provider/dark_them.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/functions/AlertButtonFunction.dart';
import 'package:provider/provider.dart';
import 'package:flash_chat/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMonthlyBillScreen extends StatefulWidget {
  final Function addMonthlyBill;
  final User loggedUser;
  final List<QueryDocumentSnapshot> userInfo;

  AddMonthlyBillScreen(this.addMonthlyBill, this.loggedUser, this.userInfo);

  @override
  _AddMonthlyBillScreenState createState() => _AddMonthlyBillScreenState();
}

class _AddMonthlyBillScreenState extends State<AddMonthlyBillScreen> {

  String monthlyBillName;
  String monthlyBillCost;
  // ignore: non_constant_identifier_names
  int monthlyBill_Id;
  DateTime selectedDate = DateTime.now();
  bool isEnabled = false;
  String formattedDate;
  String formattedTime;
  double currentTotalMonthlyBill;
  double currentTotalBudget;
  final _fireStore = FirebaseFirestore.instance;
  String dropdownValue;
  SharedPreferences preferences;

  bool checkNullorSpace() {
    if (monthlyBillName != null &&
        monthlyBillName != '' &&
        monthlyBillCost != null &&
        monthlyBillCost != '' &&
        formattedDate != null &&
        formattedDate != '' &&
        formattedTime != null &&
        formattedTime != '') {
      return true;
    } else {
      return false;
    }
  }


  DateTime currentDay = DateTime.now();


  _selectDate(BuildContext context) async {
    int lastDay = DateTime(currentDay.year,currentDay.month+1,0).day;
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(DateTime.now().year,DateTime.now().month),
      lastDate: DateTime(DateTime.now().year,DateTime.now().month, lastDay ),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
        isEnabled = true;

      });
  }


  int picker = 0;

  bool dropDownChanged = false;
  String currentLang = "ar";

  void getCurrentLanguage() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      currentLang = preferences.getString('language');
    });

  }


  @override
  void initState() {
    getCurrentLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    Map<String, String> arabicCategory = {
      'Rent': "إيجار",
      'Water': "فاتورة المياة",
      'Internet': "فاتورة الانترنت",
      'Phone': "فاتورة الجوال",
      'Electricity': "فاتورة الكهرباء",
      'Installment': "قسط",
      'Subscription': 'اشتراك شهري'
    };

    Map<String, String> arabicToEnglish = {
      "إيجار": 'Rent',
      "فاتورة المياة": 'Water',
      "فاتورة الانترنت": 'Internet',
      "فاتورة الجوال": 'Phone',
      "فاتورة الكهرباء": 'Electricity',
      "قسط": 'Installment',
      'اشتراك شهري': "Subscription"
    };

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
                    Text('Rent'),
                    Text('Water'),
                    Text('Internet'),
                    Text('Phone'),
                    Text('Electricity'),
                    Text('Installment'),
                    Text('Subscription'),
                  ]
              ),
            );});

    }

    void showArabicCupertionPicker(){

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
                    Text('إيجار'),
                    Text('فاتورة مياه'),
                    Text('فاتورة الأنترنت'),
                    Text('فاتورة الجوال'),
                    Text('فاتورة الكهرب'),
                    Text('قسط'),
                    Text('اشتراك شهري')
                  ]
              ),
            );});

    }


    Map<String,int> monthlyBillCategoryInt = {
      'Rent': 0,
      'Water':1,
      'Internet':2,
      'Phone':3,
      'Electricity':4,
      'Installment':5,
      "Subscription":6,
    };

    Map<int,String> monthlyBillCategoryString = {
      0 : 'Rent',
      1 : 'Water',
      2: 'Internet',
      3: 'Phone',
      4: 'Electricity',
      5: 'Installment',
      6:"Subscription"
    };

    Map<int, String> arabicMonthlyBillCategoryString = {
      0: 'إيجار',
      1: 'فاتورة المياة',
      2: 'فاتورة الأنترنت',
      3: 'فاتورة الجوال',
      4: 'فاتورة الكهرب',
      5: 'قسط'
    };

    if(dropDownChanged == false)
      dropdownValue = currentLang == "ar" ? "فاتورة الجوال" :'Phone';


    void addMonthlyBill(){

      formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      formattedTime = DateFormat().add_jm().format(selectedDate);


      if(double.tryParse(monthlyBillCost) == null && monthlyBillCost.isNotEmpty){
        showIOSGeneralAlert(context, '${S.of(context).rightNumber}');
      }

      if(double.parse(monthlyBillCost) <= 0){
      Platform.isIOS?
      showIOSGeneralAlert(context, '${S.of(context).rightNumber}')
          :
      showGeneralErrorAlertDialog(context, "${S.of(context).error}", "${S.of(context).rightNumber}");
      }
      
      else if (checkNullorSpace()) {
        //Update MonthlyIncome.
        currentTotalBudget = double.parse(widget.userInfo[0].get('userBudget'));
        currentTotalBudget -= double.parse(monthlyBillCost);
        widget.userInfo[0].reference.update({'userBudget': currentTotalBudget.toString()});


        //Update The total for monthly bills
        currentTotalMonthlyBill = double.parse(widget.userInfo[0].get('totalMonthlyBillCost'));
        currentTotalMonthlyBill += double.parse(monthlyBillCost);
        widget.userInfo[0].reference.update({'totalMonthlyBillCost': currentTotalMonthlyBill.toString()});


        //Update the ID for the bills
        monthlyBill_Id = widget.userInfo[0].get('expenseNumber');
        monthlyBill_Id += 1;
        widget.userInfo[0].reference.update({'expenseNumber': monthlyBill_Id});

        _fireStore.collection('monthly_bills').add({
          'email': widget.loggedUser.email,
          'billCost': monthlyBillCost,
          'billDate': selectedDate,
          'billName': monthlyBillName,
          'bill_ID': monthlyBill_Id,
          'billIcon': Platform.isIOS? monthlyBillCategoryString[picker] : currentLang == "ar" ? arabicToEnglish[dropdownValue] : dropdownValue,
        });
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        Platform.isIOS?
        showIOSGeneralAlert(context, "${S.of(context).makeSureyoufilled}"):
        showErrorAlertDialog(context);
      }
    }

    final themChange = Provider.of<DarkThemProvider>(context);
    return Scaffold(
      backgroundColor: themChange.getDarkTheme()? Colors.grey.shade800 : null,
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
                  '${S.of(context).monthlyBills}',
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
                        textAlign: TextAlign.center,
                        onChanged: (text) {
                          setState(() {
                            monthlyBillName = text;
                          });
                        },
                        maxLength: 10,
                        decoration:
                            kTextFieldDecoration.copyWith(hintText: '${S.of(context).billName}' , counter: Offstage()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        maxLength: 6,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.numberWithOptions(signed: true,decimal: true),
                        onChanged: (value) {
                          setState(() {
                            monthlyBillCost = value;
                          });
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: '${S.of(context).billCost}',
                          suffixText: '${S.of(context).saudiRyal}',
                          suffixStyle: TextStyle(), counter: Offstage()
                        ),
                      ),
                    ),
                    Platform.isIOS? Container(
                      child: FlatButton(onPressed: (){
                        currentLang == 'ar'? showArabicCupertionPicker():
                        showCupertionPicker();
                      }, child: currentLang == 'ar'? Text('${arabicMonthlyBillCategoryString[picker]}') :  Text('${monthlyBillCategoryString[picker]}')),
                    ) : currentLang == 'ar'?  DropdownButton(
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
                        "إيجار",
                        "فاتورة المياة",
                        "فاتورة الانترنت",
                        "فاتورة الجوال",
                        "فاتورة الكهرباء",
                        "قسط",
                        "اشتراك شهري"
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
                        'Rent',
                        'Water',
                        'Internet',
                        'Phone',
                        'Electricity',
                        'Installment',
                        "Subscription"
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

                Container(
                  width: 200,
                  child: TextButton(
                    onPressed: () => _selectDate(context),
                    child: Row(
                        children:[
                          Icon(Icons.calendar_today_rounded,
                            color: Colors.grey,
                          ),
                          Center(
                            child: Text(formattedDate == null? " ${S.of(context).billDate}" : ' $formattedDate',
                              style:
                              TextStyle(
                                color: Colors.grey,
                                   fontWeight: FontWeight.bold,
                              fontSize: 15),
                            ),
                          ),
                        ]
                    ),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.grey)
                            )
                        )
                    ),
                  ),
                ),

                FlatButton(
                  onPressed: () {
                  addMonthlyBill();
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
