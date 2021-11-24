import 'package:flash_chat/functions/sort_function.dart';
import 'package:flash_chat/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets.dart';



class MonthlyBillsSVerticalListView extends StatelessWidget {

  final QueryDocumentSnapshot userInfo;
  final HomeScreen widget;

  MonthlyBillsSVerticalListView(this.widget,this.userInfo);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,

      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('monthly_bills')
            .where('email',
            isEqualTo: widget.loggedUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text(
              'No Bills',
            );
          }
          var bills = snapshot.data.docs;
          QueryDocumentSnapshot currentExpen;
          List<monthlyBillBubble> monthlyBillList = [];
          bool isLast = false;
          //We add expense from here
          int i = 0;
          int j = 0;
          DateTime firstDate = DateTime.now();
          DateTime secondDate = DateTime.now();

              //Sort the bills by Daysleft
          for (i = 0; i < bills.length; i++) {
            Timestamp FirstTime = bills[i].get('billDate');
            firstDate = DateTime.parse(FirstTime.toDate().toString());
            for (j = i; j < bills.length; j++) {
             Timestamp SecondTime = bills[j].get('billDate');
             secondDate = DateTime.parse(SecondTime.toDate().toString());
              if (secondDate.difference(firstDate).isNegative) {
                currentExpen = bills[i];
                bills[i] = bills[j];
                bills[j] = currentExpen;
              }
            }
          }
          i = 0;
          j=0;
          //All the information above we add it into a list of bubbles which can be found below.

          Map<String, IconData> iconsMap2 = {
            'Rent': Icons.house,
            'Water': Icons.water,
            'Internet': Icons.wifi,
            'Phone':Icons.phone_android,
            'Electric':Icons.flash_on,
            'Installment':Icons.receipt,
            'Subscription': Icons.subscriptions_outlined
          };

          for (var bill in bills) {

            final billName = bill.get('billName');
            final billCost = bill.get('billCost');
            final billDate = bill.get('billDate');
            final billIcon = bill.get('billIcon');

            monthlyBillList.add(monthlyBillBubble(billName, billCost, billDate,iconsMap2[billIcon], bill, userInfo));
          }


          return ListView(
            scrollDirection: monthlyBillList.length == 0 ? Axis.vertical: Axis.horizontal,
            children: monthlyBillList.length == 0 ? [

              Center(child: Text('${S.of(context).noMonthlyBill}')),
            ]: monthlyBillList,
          );
        },
      ),
    );
  }
}



class ExpenseListView extends StatelessWidget {


  final HomeScreen widget;
  final QueryDocumentSnapshot userInfoList;

  ExpenseListView(this.widget, this.userInfoList);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('expense').where('email', isEqualTo: widget.loggedUser.email)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text(
            '${S.of(context).noExpenses}',
          );
        }
        var expenses = snapshot.data.docs;



        return Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Container(
            height: 242,
            child: ListView(
              children: normalView(expenses , userInfoList).length == 0 ? [Center(child: Text("No expense for the current Month"))] : normalView(expenses , userInfoList)  ,
            ),
          ),
        );
      },
    );
  }
}

