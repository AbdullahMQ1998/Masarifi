import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/Provider/dark_them.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flash_chat/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditExpenseScreen extends StatefulWidget {
  final Function addExpense;
  final QueryDocumentSnapshot userExpenseList;
  final QueryDocumentSnapshot userInfo;

  EditExpenseScreen(this.addExpense, this.userExpenseList, this.userInfo);

  @override
  _EditExpenseScreenState createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {
  String expenseName;
  String expenseCost;
  String newExpenseName;

  double updatedTotalBudget;
  double updatedExpenseTotal;

  SharedPreferences preferences;

  String dropdownValue;
  bool editDropDownMenu = false;
  int counter = 0;

  bool expenseNameEnabled = false;
  bool expenseNameEnabled2 = true;

  bool expenseCostEnabled = false;
  bool expenseCostEnabled2 = true;

  bool checkNullorSpace() {
    if (expenseName != null &&
        expenseName != '' &&
        expenseCost != null &&
        expenseCost != '') {
      return true;
    } else {
      return false;
    }
  }

  int picker;
  bool pickerChanged = false;

  @override
  void initState() {
    getCurrenLanguage();
    super.initState();
  }

  void showCupertionPicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            child: CupertinoPicker(
                backgroundColor: CupertinoColors.white,
                itemExtent: 32,
                onSelectedItemChanged: (value) {
                  setState(() {
                    picker = value;
                    pickerChanged = true;
                  });
                },
                children: [
                  Text('Restaurants'),
                  Text('Shopping'),
                  Text('Gas'),
                  Text('Coffee'),
                  Text('Finance'),
                  Text('Grocery'),
                  Text('Furniture'),
                  Text('Health'),
                  Text('Online-Shopping'),
                  Text('Entertainment'),
                  Text('Education'),
                  Text('Other')
                ]),
          );
        });
  }

  void showArabicCupertionPicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            child: CupertinoPicker(
                backgroundColor: CupertinoColors.white,
                itemExtent: 32,
                onSelectedItemChanged: (value) {
                  setState(() {
                    picker = value;
                    pickerChanged = true;
                  });
                },
                children: [
                  Text('مطاعم'),
                  Text('تسوق'),
                  Text('بنزين'),
                  Text('قهوة'),
                  Text('مالية'),
                  Text('بقالة'),
                  Text('أثاث'),
                  Text('صحة'),
                  Text('تسوق إلكتروني'),
                  Text('ترفيه'),
                  Text('تعليم'),
                  Text('اخرى')
                ]),
          );
        });
  }

  String currentLang = "ar";

  void getCurrenLanguage() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      currentLang = preferences.getString('language');
    });

  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> arabicCategory = {
      'Restaurants': 'مطاعم',
      'Shopping': "تسوق",
      'Gas': "بنزين",
      'Coffee': "قهوة",
      'Finance': "مالية",
      'Grocery': "بقالة",
      'Furniture': "أثاث",
      'Health': "صحة",
      'Online-Shopping': "تسوق إلكتروني",
      'Entertainment': "ترفيه",
      'Education': "تعليم",
      'Other': "أخرى"
    };

    Map<String, String> arabicToEnglish = {
      'مطاعم': 'Restaurants',
      "تسوق": 'Shopping',
      "بنزين": 'Gas',
      "قهوة": 'Coffee',
      "مالية": 'Finance',
      "بقالة": 'Grocery',
      "أثاث": 'Furniture',
      "صحة": 'Health',
      "تسوق إلكتروني": 'Online-Shopping',
      "ترفيه": 'Entertainment',
      "تعليم": 'Education',
      "أخرى": 'Other',
    };

    Map<String, int> expenseCategoryInt = {
      'Restaurants': 0,
      'Shopping': 1,
      'Gas': 2,
      'Coffee': 3,
      'Finance': 4,
      'Grocery': 5,
      'Furniture': 6,
      'Health': 7,
      'Online-Shopping': 8,
      'Entertainment': 9,
      'Education': 10,
      'Other': 11
    };

    Map<int, String> expenseCategoryString = {
      0: 'Restaurants',
      1: 'Shopping',
      2: 'Gas',
      3: 'Coffee',
      4: 'Finance',
      5: 'Grocery',
      6: 'Furniture',
      7: 'Health',
      8: 'Online-Shopping',
      9: 'Entertainment',
      10: 'Education',
      11: 'Other'
    };

    Map<int, String> arabicExpenseCategoryString = {
      0: 'مطاعم',
      1: 'تسوق',
      2: 'بنزين',
      3: 'قهوة',
      4: 'مالية',
      5: 'بقالة',
      6: 'أثاث',
      7: 'صحة',
      8: 'تسوق إلكتروني',
      9: 'ترفيه',
      10: 'تعليم',
      11: 'أخرى'
    };

    if (pickerChanged == false)
      picker = expenseCategoryInt[widget.userExpenseList.get('expenseIcon')];

    final themChange = Provider.of<DarkThemProvider>(context);

    if (editDropDownMenu == false && counter == 0)
      dropdownValue = currentLang == 'ar'
          ? arabicCategory[widget.userExpenseList.get('expenseIcon')]
          : widget.userExpenseList.get('expenseIcon');

    return Scaffold(
      backgroundColor: themChange.getDarkTheme() ? Colors.grey.shade800 : null,
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            )),
            child: Column(
              children: [
                Text(
                  '${S.of(context).editExpense}',
                  style: TextStyle(
                      color: Color(0xff01937C),
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
                      child: expenseNameEnabled
                          ? TextField(
                              onSubmitted: (value) {
                                setState(() {
                                  expenseNameEnabled = false;
                                  expenseNameEnabled2 = false;
                                  if (expenseName == null) {
                                    expenseName = widget.userExpenseList
                                        .get('expenseName');
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
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: widget.userExpenseList
                                      .get('expenseName')),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  Text(
                                    expenseNameEnabled2
                                        ? widget.userExpenseList
                                            .get('expenseName')
                                        : expenseName,
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        expenseNameEnabled = true;
                                      });
                                    },
                                    icon: Icon(Icons.edit),
                                  )
                                ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: expenseCostEnabled
                          ? TextField(
                              onSubmitted: (value) {
                                setState(() {
                                  double oldCost = double.parse(widget
                                      .userExpenseList
                                      .get('expenseCost'));
                                  double updatedCost =
                                      double.parse(expenseCost);
                                  double differenceBetweenCosts =
                                      updatedCost - oldCost;

                                  double currentUserBudget = double.parse(
                                      widget.userInfo.get('userBudget'));
                                  double updatedMonthlyIncome =
                                      currentUserBudget -
                                          differenceBetweenCosts;
                                  updatedTotalBudget = updatedMonthlyIncome;

                                  double currentTotalExpense = double.parse(
                                      widget.userInfo.get('totalExpense'));
                                  double updatedTotalExpense =
                                      currentTotalExpense +
                                          differenceBetweenCosts;
                                  updatedExpenseTotal = updatedTotalExpense;

                                  expenseCostEnabled = false;
                                  expenseCostEnabled2 = false;
                                  if (expenseCost == null) {
                                    expenseCost = widget.userExpenseList
                                        .get('expenseCost');
                                  }
                                });
                              },
                              maxLength: 6,
                              textAlign: TextAlign.center,
                              autofocus: true,
                              keyboardType:
                                  TextInputType.numberWithOptions(signed: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (text) {
                                setState(() {
                                  expenseCost = text;
                                });
                              },
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: widget.userExpenseList
                                      .get('expenseCost')),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  Text(
                                    expenseCostEnabled2
                                        ? widget.userExpenseList
                                            .get('expenseCost')
                                        : expenseCost,
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        expenseCostEnabled = true;
                                      });
                                    },
                                    icon: Icon(Icons.edit),
                                  )
                                ]),
                    ),
                    Platform.isIOS
                        ? Container(
                            child: FlatButton(
                                onPressed: () {
                                  currentLang == 'ar'? showArabicCupertionPicker() :
                                  showCupertionPicker();
                                },
                                child: currentLang == 'ar'?  Text('${arabicExpenseCategoryString[picker]}') : Text('${expenseCategoryString[picker]}')),
                          )
                        : currentLang == 'ar'
                            ? DropdownButton(
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 10,
                                style: const TextStyle(color: Colors.grey),
                                underline: Container(
                                  height: 1,
                                  color: Color(0xff01937C),
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                    counter++;
                                  });
                                },
                                items: <String>[
                                  'مطاعم',
                                  "تسوق",
                                  "بنزين",
                                  "قهوة",
                                  "مالية",
                                  "بقالة",
                                  "أثاث",
                                      "صحة",
                                  "تسوق إلكتروني",
                                  "ترفيه",
                                  "تعليم",
                                  "أخرى",
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )
                            : DropdownButton(
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 10,
                                style: const TextStyle(color: Colors.grey),
                                underline: Container(
                                  height: 1,
                                  color: Color(0xff01937C),
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                    counter++;
                                  });
                                },
                                items: <String>[
                                  'Restaurants',
                                  'Shopping',
                                  'Gas',
                                  'Coffee',
                                  'Finance',
                                  'Grocery',
                                  'Furniture',
                                  'Health',
                                  'Online-Shopping',
                                  'Entertainment',
                                  'Education',
                                  'Other'
                                ].map<DropdownMenuItem<String>>((String value) {
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
                    if (expenseName == null) {
                      expenseName = widget.userExpenseList.get('expenseName');
                    }
                    widget.userExpenseList.reference
                        .update({'expenseName': expenseName});

                    if (updatedTotalBudget == null) {
                      updatedTotalBudget =
                          double.parse(widget.userInfo.get('userBudget'));
                    }
                    widget.userInfo.reference
                        .update({'userBudget': updatedTotalBudget.toString()});

                    if (updatedExpenseTotal == null) {
                      updatedExpenseTotal =
                          double.parse(widget.userInfo.get('totalExpense'));
                    }
                    widget.userInfo.reference.update(
                        {'totalExpense': updatedExpenseTotal.toString()});

                    if (expenseCost == null) {
                      expenseCost = widget.userExpenseList.get('expenseCost');
                    }
                    widget.userExpenseList.reference
                        .update({'expenseCost': expenseCost});

                    if (Platform.isIOS) {
                      widget.userExpenseList.reference.update(
                          {'expenseIcon': expenseCategoryString[picker]});
                    }

                    if (Platform.isAndroid) {
                      if (dropdownValue == null) {
                        dropdownValue =
                            widget.userExpenseList.get('expenseIcon');
                      }
                      if(currentLang == 'ar')
                        widget.userExpenseList.reference
                            .update({'expenseIcon': arabicToEnglish[dropdownValue]});
                      else{
                      widget.userExpenseList.reference
                          .update({'expenseIcon': dropdownValue});
                      }
                    }

                    Navigator.pop(context);
                  },
                  child: Text(
                    '${S.of(context).update}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  color: Color(0xff01937C),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
