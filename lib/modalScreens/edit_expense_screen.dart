import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flash_chat/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../screens/home_screen.dart';

class EditExpenseScreen extends StatefulWidget {

  final Function addExpense;
  final QueryDocumentSnapshot userExpenseList;
  final QueryDocumentSnapshot userInfo;

  EditExpenseScreen(this.addExpense,this.userExpenseList,this.userInfo);

  @override
  _EditExpenseScreenState createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {
  String expenseName;
  String expenseCost;
  int expenseID;
  String newExpenseName;
  double currentTotalExpense;
  double currentTotalIncome;
  final _fireStore = FirebaseFirestore.instance;
  String dropdownValue = 'Food';

  bool expenseNameEnabled = false;
  bool expenseNameEnabled2 = true;

  bool expenseCostEnabled = false;
  bool expenseCostEnabled2 = true;

  bool checkNullorSpace() {
    if (expenseName != null &&
        expenseName != '' &&
        expenseCost != null &&
        expenseCost != '')
    {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    newExpenseName = widget.userExpenseList.get('expenseName');
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
              'Edit Expense',
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
                  child: expenseNameEnabled? TextField(
                    onSubmitted: (value){
                      setState(() {
                        widget.userExpenseList.reference.update({'expenseName': expenseName});
                        expenseNameEnabled = false;
                        expenseNameEnabled2 = false;
                        if(expenseName == null){
                          expenseName = widget.userExpenseList.get('expenseName');
                        }

                      });

                    },
                    maxLength: 10,
                    textAlign: TextAlign.center,
                    autofocus: true,
                    onChanged: (text) {
                      setState(() {
                        expenseName = text;
                      });
                    },
                    decoration:
                    kTextFieldDecoration.copyWith(hintText: widget.userExpenseList.get('expenseName')),
                  ) : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Text(expenseNameEnabled2? widget.userExpenseList.get('expenseName'): expenseName,
                        style: TextStyle(
                            fontSize: 30
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        onPressed: (){
                            setState(() {
                              expenseNameEnabled = true;
                            });
                        },
                        icon: Icon(Icons.edit),
                      )
                    ]
                  ),
      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: expenseCostEnabled? TextField(
                    onSubmitted: (value){
                      setState(() {
                        double oldCost = double.parse(widget.userExpenseList.get('expenseCost'));
                        double updatedCost = double.parse(expenseCost);
                        double differenceBetweenCosts = updatedCost - oldCost;

                        double currentMonthlyIncome = double.parse(widget.userInfo.get('monthlyIncome'));
                        double updatedMonthlyIncome = currentMonthlyIncome - differenceBetweenCosts;
                        widget.userInfo.reference.update({'monthlyIncome' : updatedMonthlyIncome.toString()});

                        double currentTotalExpense = double.parse(widget.userInfo.get('totalExpense'));
                        double updatedTotalExpense = currentTotalExpense + differenceBetweenCosts;
                        widget.userInfo.reference.update({'totalExpense' : updatedTotalExpense.toString()});


                        widget.userExpenseList.reference.update({'expenseCost': expenseCost});
                        expenseCostEnabled = false;
                        expenseCostEnabled2 = false;
                        if(expenseCost == null){
                          expenseCost = widget.userExpenseList.get('expenseCost');
                        }

                      });

                    },
                    maxLength: 6,
                    textAlign: TextAlign.center,
                    autofocus: true,
                    keyboardType: TextInputType.numberWithOptions(),
                    onChanged: (text) {
                      setState(() {
                        expenseCost = text;
                      });
                    },
                    decoration:
                    kTextFieldDecoration.copyWith(hintText: widget.userExpenseList.get('expenseCost')),
                  ) : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Text(expenseCostEnabled2? widget.userExpenseList.get('expenseCost'): expenseCost,
                          style: TextStyle(
                              fontSize: 30
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          onPressed: (){
                            setState(() {
                              expenseCostEnabled = true;
                            });
                          },
                          icon: Icon(Icons.edit),
                        )
                      ]
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
                      widget.userExpenseList.reference.update({'expenseIcon': dropdownValue});
                    });
                  },
                  items: <String>['Food', 'Shopping', 'Gas']
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
                    Navigator.pop(context);
                },

              child: Text(
                'Update',
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
