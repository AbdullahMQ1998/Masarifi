
import 'package:flash_chat/Components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';


List<ExpensesBubble> normalView(List<QueryDocumentSnapshot> list){

  QueryDocumentSnapshot currentExpen;
  List<ExpensesBubble> expensesList = [];
  bool isLast = false;

  int i = 0;
  int j = 0;


  for (i = 0; i < list.length; i++) {
    for (j = i; j < list.length; j++) {
      if (list[i].get('expenseID') <
          list[j].get('expenseID')) {
        currentExpen = list[i];
        list[i] = list[j];
        list[j] = currentExpen;
      }
    }
  }
  i = 0;
  j=0;
  //All the information above we add it into a list of bubbles which can be found below.
  isLast = true;

  Map<String, IconData> iconsMap = {
    'Food': Icons.restaurant_menu_outlined,
    'Shopping': Icons.shopping_cart,
    'Gas': Icons.local_gas_station_rounded,
    'Other': Icons.other_houses,
  };
  
  Timestamp timestamp;

  for (var expense in list) {

    final expenseName = expense.get('expenseName');
    final expenseTotal = expense.get('expenseCost');
    timestamp = expense.get('expenseDate');
    final expenseDate = DateTime.parse(timestamp.toDate().toString());
    final expenseTime = expense.get('expenseTime');
    final expenseIcon = expense.get('expenseIcon');
    final formattedTime = DateFormat('yyyy-MM-dd').format(expenseDate);
    expensesList.add(ExpensesBubble(
      expenseTotal: expenseTotal,
      expenseName: expenseName,
      expenseDate: formattedTime,
      expenseTime: expenseTime ,
      expenseIcon: iconsMap[expenseIcon],
      isLast: isLast,
    ));
    isLast= false;
  }
  return expensesList;
}


List<ExpensesBubble> sortByDate(List<QueryDocumentSnapshot> list , DateTime date1 , DateTime date2){

  QueryDocumentSnapshot currentExpen;
  List<ExpensesBubble> expensesList = [];
  bool isLast = false;


  int i = 0;
  int j = 0;

  for (i = 0; i < list.length; i++) {
    for (j = i; j < list.length; j++) {
      if (list[i].get('expenseID') <
          list[j].get('expenseID')) {
        currentExpen = list[i];
        list[i] = list[j];
        list[j] = currentExpen;
      }
    }
  }
  i = 0;
  j=0;

  //All the information above we add it into a list of bubbles which can be found below.
  isLast = true;


  Map<String, IconData> iconsMap = {
    'Food': Icons.restaurant_menu_outlined,
    'Shopping': Icons.shopping_cart,
    'Gas': Icons.local_gas_station_rounded,
    'Other': Icons.other_houses,
  };
  Timestamp timestamp;
  expensesList.clear();

  for (var expense in list) {
    timestamp = expense.get('expenseDate');
    final expenseDate = DateTime.parse(timestamp.toDate().toString());
    if( !expenseDate.difference(date1).isNegative && expenseDate.difference(date2).inDays <= 0 ) {

      final expenseTotal = expense.get('expenseCost');
      final expenseName = expense.get('expenseName');
      final formattedTime = DateFormat('yyyy-MM-dd').format(expenseDate);
      final expenseTime = expense.get('expenseTime');
      final expenseIcon = expense.get('expenseIcon');

      expensesList.add(ExpensesBubble(
        expenseTotal: expenseTotal,
        expenseName: expenseName,
        expenseDate: formattedTime,
        expenseTime: expenseTime,
        expenseIcon: iconsMap[expenseIcon],
        isLast: isLast,
      ));
      isLast = false;
    }

  }
  return expensesList;
}




List<ExpensesBubble> sortByDateAndType(List<QueryDocumentSnapshot> list , DateTime date1 , DateTime date2, String type){

  QueryDocumentSnapshot currentExpen;
  List<ExpensesBubble> expensesList = [];
  bool isLast = false;



  int i = 0;
  int j = 0;



  for (i = 0; i < list.length; i++) {
    for (j = i; j < list.length; j++) {
      if (list[i].get('expenseID') <
          list[j].get('expenseID')) {
        currentExpen = list[i];
        list[i] = list[j];
        list[j] = currentExpen;
      }
    }
  }
  i = 0;
  j=0;

  //All the information above we add it into a list of bubbles which can be found below.
  isLast = true;


  Map<String, IconData> iconsMap = {
    'Food': Icons.restaurant_menu_outlined,
    'Shopping': Icons.shopping_cart,
    'Gas': Icons.local_gas_station_rounded,
    'Other': Icons.other_houses,
  };
  Timestamp timestamp;



  for (var expense in list) {
    timestamp = expense.get('expenseDate');
    final expenseDate = DateTime.parse(timestamp.toDate().toString());
    if( !expenseDate.difference(date1).isNegative && expenseDate.difference(date2).inDays <= 0 ) {
      if(type == expense.get('expenseIcon') ) {
        final expenseTotal = expense.get('expenseCost');
        final expenseName = expense.get('expenseName');
        final formattedTime = DateFormat('yyyy-MM-dd').format(expenseDate);
        final expenseTime = expense.get('expenseTime');
        final expenseIcon = expense.get('expenseIcon');

        expensesList.add(ExpensesBubble(
          expenseTotal: expenseTotal,
          expenseName: expenseName,
          expenseDate: formattedTime,
          expenseTime: expenseTime,
          expenseIcon: iconsMap[expenseIcon],
          isLast: isLast,
        ));
        isLast = false;
      }
    }

  }
  return expensesList;
}



