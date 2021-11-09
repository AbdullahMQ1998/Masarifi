import 'package:flash_chat/functions/sort_function.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets.dart';



class MonthlyBillsSVerticalListView extends StatelessWidget {
  const MonthlyBillsSVerticalListView({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final HomeScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,

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

              //Sort the bills by ID
          for (i = 0; i < bills.length; i++) {
            for (j = i; j < bills.length; j++) {
              if (bills[i].get('bill_ID') <
                  bills[j].get('bill_ID')) {
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
            'installment':Icons.receipt,
          };

          for (var bill in bills) {

            final billName = bill.get('billName');
            final billCost = bill.get('billCost');
            final billDate = bill.get('billDate');
            final billIcon = bill.get('billIcon');

            monthlyBillList.add(monthlyBillBubble(billName, billCost, billDate,iconsMap2[billIcon]));
          }


          return ListView(
            scrollDirection: Axis.horizontal,
            children: monthlyBillList,
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
    return Container(
      height: 200,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('expense').where('email', isEqualTo: widget.loggedUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text(
              'No Expense',
            );
          }
          var expenses = snapshot.data.docs;
          





          return ListView(
            children: normalView(expenses , userInfoList),
          );
        },
      ),
    );
  }
}

