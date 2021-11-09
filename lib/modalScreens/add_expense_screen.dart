import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flash_chat/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../screens/home_screen.dart';

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
  double currentTotalIncome;
  final _fireStore = FirebaseFirestore.instance;
  String dropdownValue = 'Food';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            )),
        child: Column(

          children: [
            Text(
              'Add Expense',
              style: TextStyle(
                  color: Color(0xff50c878),
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
                    autofocus: true,
                    onChanged: (text) {
                      setState(() {
                        expenseName = text;
                      });
                    },
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: 'Expense name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        expenseCost = value;
                      });
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter Expense cost',
                      suffixText: 'SAR',
                      suffixStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
          DropdownButton(
            value: dropdownValue,
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
                dropdownValue = newValue;
              });
            },
            items: <String>['Food', 'Shopping', 'Gas', 'Other']
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
                  currentTotalIncome =
                      double.parse(widget.userInfo[0].get('monthlyIncome'));
                  currentTotalIncome -= double.parse(expenseCost);
                  widget.userInfo[0].reference
                      .update({'monthlyIncome': currentTotalIncome.toString()});

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
                    'expenseIcon': dropdownValue,
                  });
                  // Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  //     HomeScreen(
                  //         widget.loggedUser)
                  //
                  //     ));

                  Navigator.pop(context);
                  Navigator.pop(context);
                } else {
                  Alert(
                          context: context,
                          title: "ERROR",
                          desc:
                              "Make sure you have filled the required information")
                      .show();
                }
              },
              child: Text(
                'Add',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              color: Color(0xff50c878),
            ),
          ],
        ),
      ),
    );
  }
}
