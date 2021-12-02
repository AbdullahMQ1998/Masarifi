
import 'package:flash_chat/Components/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';



List<ExpensesBubble> normalView(List<QueryDocumentSnapshot> list , QueryDocumentSnapshot userInfo ){

  QueryDocumentSnapshot currentExpen;
  List<ExpensesBubble> expensesList = [];
  Timestamp expenseDates;
  DateTime currentMonth = DateTime.now();

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

    'Restaurants': Icons.restaurant_menu_outlined,
    'Shopping': Icons.shopping_cart,
    'Gas':  Icons.local_gas_station_rounded,
    'Coffee': Icons.coffee,
    'Finance': Icons.monetization_on,
    'Grocery': Icons.shopping_bag,
    'Furniture': Icons.event_seat,
    'Health': Icons.health_and_safety,
    'Entertainment': Icons.videogame_asset,
    'Online-Shopping': Icons.credit_card,
    'Education': Icons.book,
    'Other': Icons.sort,

  };
  
  Timestamp timestamp;

  for (var expense in list) {

    expenseDates = expense.get('expenseDate');
    if(expenseDates.toDate().month == currentMonth.month){
    final expenseName = expense.get('expenseName');
    final expenseTotal = expense.get('expenseCost');
    timestamp = expense.get('expenseDate');
    final expenseDate = DateTime.parse(timestamp.toDate().toString());
    final expenseTime = expense.get('expenseTime');
    final expenseIcon = expense.get('expenseIcon');
    final formattedTime = DateFormat('yyyy-MM-dd').format(expenseDate);
    expensesList.add(ExpensesBubble(
      userInfoList: userInfo,
      userExpenseList: expense,
      expenseTotal: expenseTotal,
      expenseName: expenseName,
      expenseDate: formattedTime,
      expenseTime: expenseTime ,
      expenseIcon: iconsMap[expenseIcon],
      isLast: isLast,
    ));
    isLast= false;
  }}
  return expensesList;
}

List<ExpensesBubble> normalViewExpensesPage(List<QueryDocumentSnapshot> list , QueryDocumentSnapshot userInfo ){

  QueryDocumentSnapshot currentExpen;
  List<ExpensesBubble> expensesList = [];
  Timestamp expenseDates;
  DateTime currentMonth = DateTime.now();

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

    'Restaurants': Icons.restaurant_menu_outlined,
    'Shopping': Icons.shopping_cart,
    'Gas':  Icons.local_gas_station_rounded,
    'Coffee': Icons.coffee,
    'Finance': Icons.monetization_on,
    'Grocery': Icons.shopping_bag,
    'Furniture': Icons.event_seat,
    'Health': Icons.health_and_safety,
    'Entertainment': Icons.videogame_asset,
    'Online-Shopping': Icons.credit_card,
    'Education': Icons.book,
    'Other': Icons.sort,

  };

  Timestamp timestamp;

  for (var expense in list) {

    expenseDates = expense.get('expenseDate');

      final expenseName = expense.get('expenseName');
      final expenseTotal = expense.get('expenseCost');
      timestamp = expense.get('expenseDate');
      final expenseDate = DateTime.parse(timestamp.toDate().toString());
      final expenseTime = expense.get('expenseTime');
      final expenseIcon = expense.get('expenseIcon');
      final formattedTime = DateFormat('yyyy-MM-dd').format(expenseDate);
      expensesList.add(ExpensesBubble(
        userInfoList: userInfo,
        userExpenseList: expense,
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



List<ExpensesBubble> searchByName(List<QueryDocumentSnapshot> list , QueryDocumentSnapshot userInfo , String name){

  QueryDocumentSnapshot currentExpen;
  List<ExpensesBubble> expensesList = [];
  Timestamp expenseDates;
  DateTime currentMonth = DateTime.now();

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

    'Restaurants': Icons.restaurant_menu_outlined,
    'Shopping': Icons.shopping_cart,
    'Gas':  Icons.local_gas_station_rounded,
    'Coffee': Icons.coffee,
    'Finance': Icons.monetization_on,
    'Grocery': Icons.shopping_bag,
    'Furniture': Icons.event_seat,
    'Health': Icons.health_and_safety,
    'Entertainment': Icons.videogame_asset,
    'Online-Shopping': Icons.credit_card,
    'Education': Icons.book,
    'Other': Icons.sort,

  };

  Timestamp timestamp;

  for (var expense in list) {
    expenseDates = expense.get('expenseDate');

    final expenseName = expense.get('expenseName');
    if (expenseName.toString().contains(name)) {
      final expenseTotal = expense.get('expenseCost');
      timestamp = expense.get('expenseDate');
      final expenseDate = DateTime.parse(timestamp.toDate().toString());
      final expenseTime = expense.get('expenseTime');
      final expenseIcon = expense.get('expenseIcon');
      final formattedTime = DateFormat('yyyy-MM-dd').format(expenseDate);
      expensesList.add(ExpensesBubble(
        userInfoList: userInfo,
        userExpenseList: expense,
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




List<monthExpensesBubble> normalViewByMonth(List<QueryDocumentSnapshot> list , QueryDocumentSnapshot userInfo , String month){

  QueryDocumentSnapshot currentExpen;
  List<monthExpensesBubble> expensesList = [];
  Timestamp expenseDates;
  DateTime currentMonth = DateTime.now();

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

    'Restaurants': Icons.restaurant_menu_outlined,
    'Shopping': Icons.shopping_cart,
    'Gas':  Icons.local_gas_station_rounded,
    'Coffee': Icons.coffee,
    'Finance': Icons.monetization_on,
    'Grocery': Icons.shopping_bag,
    'Furniture': Icons.event_seat,
    'Health': Icons.health_and_safety,
    'Entertainment': Icons.videogame_asset,
    'Online-Shopping': Icons.credit_card,
    'Education': Icons.book,
    'Other': Icons.sort,

  };

  Timestamp timestamp;

  for (var expense in list) {
    expenseDates = expense.get('expenseDate');
    if(expenseDates.toDate().month.toString() == month){
      final expenseName = expense.get('expenseName');
      final expenseTotal = expense.get('expenseCost');
      timestamp = expense.get('expenseDate');
      final expenseDate = DateTime.parse(timestamp.toDate().toString());
      final expenseTime = expense.get('expenseTime');
      final expenseIcon = expense.get('expenseIcon');
      final formattedTime = DateFormat('yyyy-MM-dd').format(expenseDate);
      expensesList.add(monthExpensesBubble(
        userInfoList: userInfo,
        userExpenseList: expense,
        expenseTotal: expenseTotal,
        expenseName: expenseName,
        expenseDate: formattedTime,
        expenseTime: expenseTime ,
        expenseIcon: iconsMap[expenseIcon],
        isLast: isLast,
      ));
      isLast= false;
    }}
  return expensesList;
}


List<ExpensesBubble> sortByDate(List<QueryDocumentSnapshot> list , DateTime date1 , DateTime date2 , QueryDocumentSnapshot userInfoList  ){

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

    'Restaurants': Icons.restaurant_menu_outlined,
    'Shopping': Icons.shopping_cart,
    'Gas':  Icons.local_gas_station_rounded,
    'Coffee': Icons.coffee,
    'Finance': Icons.monetization_on,
    'Grocery': Icons.shopping_bag,
    'Furniture': Icons.event_seat,
    'Health': Icons.health_and_safety,
    'Entertainment': Icons.videogame_asset,
    'Online-Shopping': Icons.credit_card,
    'Education': Icons.book,
    'Other': Icons.sort,

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
        userInfoList: userInfoList,
        userExpenseList: expense,
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









List<ExpensesBubble> sortByDateAndType(List<QueryDocumentSnapshot> list , DateTime date1 , DateTime date2, String type , QueryDocumentSnapshot userInfoList ){

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
    'Restaurants': Icons.restaurant_menu_outlined,
    'Shopping': Icons.shopping_cart,
    'Gas':  Icons.local_gas_station_rounded,
    'Coffee': Icons.coffee,
    'Finance': Icons.monetization_on,
    'Grocery': Icons.shopping_bag,
    'Furniture': Icons.event_seat,
    'Health': Icons.health_and_safety,
    'Entertainment': Icons.videogame_asset,
    'Online-Shopping': Icons.credit_card,
    'Education': Icons.book,
    'Other': Icons.sort,

  };
  Timestamp timestamp;


  expensesList.clear();


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
          userInfoList: userInfoList,
          userExpenseList: expense,
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

List<ExpensesBubble> sortByDateAndTypeAndName(List<QueryDocumentSnapshot> list , DateTime date1 , DateTime date2, String type , QueryDocumentSnapshot userInfoList ,name){

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
    'Restaurants': Icons.restaurant_menu_outlined,
    'Shopping': Icons.shopping_cart,
    'Gas':  Icons.local_gas_station_rounded,
    'Coffee': Icons.coffee,
    'Finance': Icons.monetization_on,
    'Grocery': Icons.shopping_bag,
    'Furniture': Icons.event_seat,
    'Health': Icons.health_and_safety,
    'Entertainment': Icons.videogame_asset,
    'Online-Shopping': Icons.credit_card,
    'Education': Icons.book,
    'Other': Icons.sort,

  };
  Timestamp timestamp;


  expensesList.clear();


  for (var expense in list) {
    timestamp = expense.get('expenseDate');
    final expenseDate = DateTime.parse(timestamp.toDate().toString());
    if( !expenseDate.difference(date1).isNegative && expenseDate.difference(date2).inDays <= 0 ) {
      if (type == expense.get('expenseIcon')) {
        final expenseTotal = expense.get('expenseCost');
        final expenseName = expense.get('expenseName');
        if (expenseName.toString().contains(name)) {
          final formattedTime = DateFormat('yyyy-MM-dd').format(expenseDate);
          final expenseTime = expense.get('expenseTime');
          final expenseIcon = expense.get('expenseIcon');

          expensesList.add(ExpensesBubble(
            userInfoList: userInfoList,
            userExpenseList: expense,
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
  }
  return expensesList;
}


