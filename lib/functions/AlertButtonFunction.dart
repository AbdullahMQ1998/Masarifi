import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';





showAlertDialogForExpense(BuildContext context , bool shouldDelete,QueryDocumentSnapshot userInfoList, QueryDocumentSnapshot userExpenseList) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel",
      style:TextStyle(
          color: Colors.grey
      )
      ,),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Yes",
      style: TextStyle(
          color: Colors.red
      ),),
    onPressed:  () {

      //Here we Delete the current Expense

      double currentExpenseCost = double.parse(userExpenseList.get('expenseCost'));
      double currentTotalBudget = double.parse(userInfoList.get('userBudget'));
      double currentTotalExpense = double.parse(userInfoList.get('totalExpense'));
      double updatedTotalBudget = currentTotalBudget + currentExpenseCost;
      double updatedTotalExpense = currentTotalExpense - currentExpenseCost;

      userInfoList.reference.update({'userBudget': updatedTotalBudget.toString()});
      userInfoList.reference.update({'totalExpense': updatedTotalExpense.toString()});

      userExpenseList.reference.delete();

      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Delete Expense"),
    content: Text("Would you like to delete the current expense?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}



showAlertDialogForMonthlyBill(BuildContext context , bool shouldDelete,QueryDocumentSnapshot userInfo, QueryDocumentSnapshot userMonthlyBillList) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel",
      style:TextStyle(
          color: Colors.grey
      )
      ,),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Yes",
      style: TextStyle(
          color: Colors.red
      ),),
    onPressed:  () {

      //Here we Delete the current Expense

      double currentMonthlyBillCost = double.parse(userMonthlyBillList.get('billCost'));
      double currentTotalBudget = double.parse(userInfo.get('userBudget'));
      double currentTotalMonthlyBillCost = double.parse(userInfo.get('totalMonthlyBillCost'));
      double updatedTotalBudget = currentTotalBudget + currentTotalMonthlyBillCost;
      double updatedTotalMonthlyBillCost = currentTotalMonthlyBillCost - currentTotalMonthlyBillCost;

      userInfo.reference.update({'userBudget': updatedTotalBudget.toString()});
      userInfo.reference.update({'totalMonthlyBillCost': updatedTotalMonthlyBillCost.toString()});

      userMonthlyBillList.reference.delete();

      Navigator.pop(context);
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Delete Bill"),
    content: Text("Would you like to delete the current monthly bill?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}