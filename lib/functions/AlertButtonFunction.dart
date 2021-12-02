import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flash_chat/generated/l10n.dart';



void textFieldDialog(BuildContext context,User user,QueryDocumentSnapshot userInfo ,List<QueryDocumentSnapshot> userExpenseList,List<QueryDocumentSnapshot> monthlyBillList,List<QueryDocumentSnapshot> monthlyReportList,bool shouldDelete) async{
  TextEditingController _textFieldController = TextEditingController();
  String confirm;



  return showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text("${S.of(context).writeDelete}"),
      content: TextField(
        controller: _textFieldController,
        decoration: InputDecoration(hintText: "DELETE"),
        onChanged: (value){
          confirm = value;
        },
      ),
      actions: [
        new FlatButton(
          child: Text('${S.of(context).confirm}',
            style: TextStyle(
                color: Colors.red
            ),),
          onPressed: () {
            if(confirm == "DELETE"){
              for(int i = 0 ; i < userExpenseList.length;i++){
                userExpenseList[i].reference.delete();
              }
              for(int i = 0 ; i < monthlyBillList.length;i++){
                monthlyBillList[i].reference.delete();
              }
              for(int i = 0; i<monthlyReportList.length ; i++){
                monthlyReportList[i].reference.delete();
              }
              userInfo.reference.delete();
              user.delete();
              Navigator.pushNamed(context, WelcomeScreen.id);
            }
            else {

            }
          },
        ),
      ],
    );

  });
}

_showDialog(BuildContext context,User user,QueryDocumentSnapshot userInfo,List<QueryDocumentSnapshot> userExpenseList,List<QueryDocumentSnapshot> monthlyBillList,List<QueryDocumentSnapshot> monthlyReportList,bool shouldDelete) async {

  TextEditingController _textFieldController = TextEditingController();
  String confirm;

  return showDialog(context: context, builder: (context){
  return CupertinoAlertDialog(
    title: Text('${S.of(context).writeDelete}'),
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CupertinoTextField(
        controller: _textFieldController,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white
        ),
        onChanged: (value){
          confirm = value;
        },
      ),
    ),
    actions: [
      CupertinoDialogAction(
        child: Text('${S.of(context).confirm}'),
        onPressed: () {
          if(confirm == "DELETE"){
            for(int i = 0 ; i < userExpenseList.length;i++){
              userExpenseList[i].reference.delete();
            }
            for(int i = 0 ; i < monthlyBillList.length;i++){
              monthlyBillList[i].reference.delete();
            }
            for(int i = 0; i<monthlyReportList.length ; i++){
              monthlyReportList[i].reference.delete();
            }
            userInfo.reference.delete();
            user.delete();
            Navigator.pushNamed(context, WelcomeScreen.id);
          }
          else {

          }
        },
      ),
    ],
  );


}
  );}



  showIOSGeneralAlert(BuildContext context, String text){

    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title:  Text('Alert'),
        content: Text(text),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: Text('${S.of(context).confirm}'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

        ],
      ),
    );
  }

showIOSGeneralAlertwithDoulbePop(BuildContext context, String title,String text){

  showCupertinoDialog<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title:  Text(title),
      content: Text(text),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          child: Text('${S.of(context).confirm}'),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),

      ],
    ),
  );
}


showIOSDeleteMonthlyBillsAlert(BuildContext context,QueryDocumentSnapshot userInfo, QueryDocumentSnapshot userMonthlyBillList,bool shouldDelete){

  showCupertinoDialog<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title:  Text('${S.of(context).deleteBill}'),
      content: Text("${S.of(context).wouldYouLikeDeleteMonthly}"),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          child: Text('${S.of(context).confirm}'),
          onPressed: () {


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
        ),

        CupertinoDialogAction(
          child: Text('${S.of(context).cancel}'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

      ],
    ),
  );
}


showIOSDeleteExpenseAlert(BuildContext context,QueryDocumentSnapshot userInfoList, QueryDocumentSnapshot userExpenseList,bool shouldDelete){

  showCupertinoDialog<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title:  Text('${S.of(context).deleteExpense}'),
      content: Text("${S.of(context).wouldYouLikeDeleteExpense}"),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          child: Text('${S.of(context).confirm}'),
          onPressed: () {


            Timestamp expenseMonthy = userExpenseList.get('expenseDate');
            DateTime currentMonth = DateTime.now();



            if(expenseMonthy.toDate().month == currentMonth.month){
              print(expenseMonthy.toDate().month);
              print(currentMonth.month);
            }

            double currentExpenseCost = double.parse(userExpenseList.get('expenseCost'));
            double currentTotalBudget = double.parse(userInfoList.get('userBudget'));
            double currentTotalExpense = double.parse(userInfoList.get('totalExpense'));
            double updatedTotalBudget = currentTotalBudget + currentExpenseCost;
            double updatedTotalExpense = currentTotalExpense - currentExpenseCost;

            if(expenseMonthy.toDate().month == currentMonth.month){
              userInfoList.reference.update({'userBudget': updatedTotalBudget.toString()});
              userInfoList.reference.update({'totalExpense': updatedTotalExpense.toString()});
            }

            userExpenseList.reference.delete();

            Navigator.pop(context);
          },
        ),






        CupertinoDialogAction(
          child: Text('${S.of(context).cancel}'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

      ],
    ),
  );
}


showIOSDeleteAccount(BuildContext context,User user,QueryDocumentSnapshot userInfo,List<QueryDocumentSnapshot> userExpenseList,List<QueryDocumentSnapshot> monthlyBillList,List<QueryDocumentSnapshot> monthlyReportList,bool shouldDelete){

  showCupertinoDialog<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title:  Text('${S.of(context).deleteAccount}'),
      content: Text("${S.of(context).areyousureDeleteAccount}"),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          child: Text('${S.of(context).confirm}'),
          onPressed: () {
_showDialog(context, user, userInfo, userExpenseList, monthlyBillList, monthlyReportList, shouldDelete);
            // for(int i = 0 ; i < userExpenseList.length;i++){
            //   userExpenseList[i].reference.delete();
            // }
            // for(int i = 0 ; i < monthlyBillList.length;i++){
            //   monthlyBillList[i].reference.delete();
            // }
            // for(int i = 0; i<monthlyReportList.length ; i++){
            //   monthlyReportList[i].reference.delete();
            // }
            // userInfo.reference.delete();
            // user.delete();
            // Navigator.pushNamed(context, WelcomeScreen.id);
          },
        ),






        CupertinoDialogAction(
          child: Text('${S.of(context).cancel}'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

      ],
    ),
  );
}






showErrorAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("${S.of(context).confirm}"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("${S.of(context).error}"),
    content: Text("${S.of(context).makeSureyoufilled}"),
    actions: [
      okButton,
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


showGeneralErrorAlertDialog(BuildContext context, String title , String text) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("${S.of(context).confirm}"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(text),
    actions: [
      okButton,
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


showGeneralErrorAlertDialogwithDoublePop(BuildContext context, String title , String text) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("${S.of(context).confirm}"),
    onPressed: () {
      Navigator.pop(context);
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(text),
    actions: [
      okButton,
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




showEmailAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("${S.of(context).confirm}"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("${S.of(context).error}"),
    content: Text("${S.of(context).validEmail}"),
    actions: [
      okButton,
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



showAlertDialogForExpense(BuildContext context , bool shouldDelete,QueryDocumentSnapshot userInfoList, QueryDocumentSnapshot userExpenseList) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("${S.of(context).cancel}",
      style:TextStyle(
          color: Colors.grey
      )
      ,),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("${S.of(context).confirm}",
      style: TextStyle(
          color: Colors.red
      ),),
    onPressed:  () {

      //Here we Delete the current Expense
      Timestamp expenseMonthy = userExpenseList.get('expenseDate');
      DateTime currentMonth = DateTime.now();




      double currentExpenseCost = double.parse(userExpenseList.get('expenseCost'));
      double currentTotalBudget = double.parse(userInfoList.get('userBudget'));
      double currentTotalExpense = double.parse(userInfoList.get('totalExpense'));
      double updatedTotalBudget = currentTotalBudget + currentExpenseCost;
      double updatedTotalExpense = currentTotalExpense - currentExpenseCost;

      if(expenseMonthy.toDate().month == currentMonth.month){
        userInfoList.reference.update({'userBudget': updatedTotalBudget.toString()});
        userInfoList.reference.update({'totalExpense': updatedTotalExpense.toString()});
      }



      userExpenseList.reference.delete();

      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("${S.of(context).deleteExpense}"),
    content: Text("${S.of(context).wouldYouLikeDeleteExpense}"),
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
    child: Text("${S.of(context).cancel}",
      style:TextStyle(
          color: Colors.grey
      )
      ,),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("${S.of(context).confirm}",
      style: TextStyle(
          color: Colors.red
      ),),
    onPressed:  () {

      //Here we Delete the current Expense

      double currentMonthlyBillCost = double.parse(userMonthlyBillList.get('billCost'));
      double currentTotalBudget = double.parse(userInfo.get('userBudget'));
      double currentTotalMonthlyBillCost = double.parse(userInfo.get('totalMonthlyBillCost'));
      double updatedTotalBudget = currentTotalBudget + currentTotalMonthlyBillCost;
      double updatedTotalMonthlyBillCost = currentTotalMonthlyBillCost - currentMonthlyBillCost;

      userInfo.reference.update({'userBudget': updatedTotalBudget.toString()});
      userInfo.reference.update({'totalMonthlyBillCost': updatedTotalMonthlyBillCost.toString()});

      userMonthlyBillList.reference.delete();

      Navigator.pop(context);
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("${S.of(context).deleteBill}"),
    content: Text("${S.of(context).wouldYouLikeDeleteMonthly}"),
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




showAlertDialogForAccount(BuildContext context,User user,QueryDocumentSnapshot userInfo ,List<QueryDocumentSnapshot> userExpenseList,List<QueryDocumentSnapshot> monthlyBillList,List<QueryDocumentSnapshot> monthlyReportList,bool shouldDelete) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("${S.of(context).cancel}",
      style:TextStyle(
          color: Colors.grey
      )
      ,),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("${S.of(context).confirm}",
      style: TextStyle(
          color: Colors.red
      ),),
    onPressed:  () {

      textFieldDialog(context,user,userInfo,userExpenseList,monthlyBillList,monthlyReportList,shouldDelete);

    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("${S.of(context).deleteAccount}"),
    content: Text("${S.of(context).areyousureDeleteAccount}"),
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