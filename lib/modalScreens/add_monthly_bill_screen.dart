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
  String dropdownValue = 'Phone';

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



  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
        isEnabled = true;

      });
  }


  int picker = 0;


  @override
  Widget build(BuildContext context) {


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
                    Text('Electric'),
                    Text('Installment'),
                  ]
              ),
            );});

    }


    Map<String,int> monthlyBillCategoryInt = {
      'Rent': 0,
      'Water':1,
      'Internet':2,
      'Phone':3,
      'Electric':4,
      'Installment':5,
    };

    Map<int,String> monthlyBillCategoryString = {
      0 : 'Rent',
      1 : 'Water',
      2: 'Internet',
      3: 'Phone',
      4: 'Electric',
      5: 'Installment'
    };


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
                        maxLength: 4,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.numberWithOptions(signed: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
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
                        showCupertionPicker();
                      }, child: Text('${monthlyBillCategoryString[picker]}')),
                    ) :DropdownButton(
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
                        });
                      },
                      items: <String>[
                        'Rent',
                        'Water',
                        'Internet',
                        'Phone',
                        'Electric',
                        'installment',
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

                    formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
                    formattedTime = DateFormat().add_jm().format(selectedDate);

                    if (checkNullorSpace()) {
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
                        'billIcon': Platform.isIOS? monthlyBillCategoryString[picker] :dropdownValue,
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
