import 'package:flutter/material.dart';
import 'add_expense_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_monthly_bill_screen.dart';


class ChooseExpenseOrMonthlyScreen extends StatelessWidget {
  final Function function;
  final User loggedUser;
  final List<QueryDocumentSnapshot> userInfo;
  ChooseExpenseOrMonthlyScreen(this.function, this.loggedUser, this.userInfo);

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
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: FlatButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) =>
                      AddExpenseScreen((taskTitle) {
                        Navigator.pop(context);
                      }, loggedUser, userInfo));
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.red,
              ),
              child: Center(child: Text("Add Expense")),
            ),
          ),
        ),
        Expanded(
          child: FlatButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) =>
                      AddMonthlyBillScreen((taskTitle) {
                        Navigator.pop(context);
                      }, loggedUser, userInfo));
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.red,
              ),
              child: Center(child: Text("Add Monthly Bill")),
            ),
          ),
        ),
      ],
    ),),
    );
  }
}
