import 'package:flutter/material.dart';
import 'add_expense_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_monthly_bill_screen.dart';
import 'package:flash_chat/generated/l10n.dart';


class ChooseExpenseOrMonthlyScreen extends StatelessWidget {
  final Function function;
  final User loggedUser;
  final List<QueryDocumentSnapshot> userInfo;
  ChooseExpenseOrMonthlyScreen(this.function, this.loggedUser, this.userInfo);


  @override
  Widget build(BuildContext context) {
    return Container(

        child: Container(
        padding: EdgeInsets.all(30),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.only(
    topRight: Radius.circular(20),
    topLeft: Radius.circular(20),
    )),
    child: Row(

      children: [
        Expanded(
          child: FlatButton(
            onPressed: () {
              showModalBottomSheet(
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) =>
                      AddExpenseScreen((taskTitle) {
                        Navigator.pop(context);
                      }, loggedUser, userInfo));
            },
            child: Container(
              height: 50,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xff01937C),
              ),
              child: Center(child: Text("${S.of(context).addExpense}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),)),
            ),
          ),
        ),
        Expanded(
          child: FlatButton(
            onPressed: () {
              showModalBottomSheet(
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) =>
                      AddMonthlyBillScreen((taskTitle) {
                        Navigator.pop(context);
                      }, loggedUser, userInfo));
            },
            child: Container(
              height: 50,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xff01937C),
              ),
              child: Center(child: Text("${S.of(context).addMonthlyBill}",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),)),
            ),
          ),
        ),
      ],
    ),),
    );
  }
}
