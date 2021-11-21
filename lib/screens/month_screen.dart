import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flash_chat/functions/sort_function.dart';
import 'package:flash_chat/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mccounting_text/mccounting_text.dart';
import 'package:shared_preferences/shared_preferences.dart';




class MonthScreen extends StatefulWidget {
  final QueryDocumentSnapshot monthInfo;
  final List<QueryDocumentSnapshot> expenseList;
  final QueryDocumentSnapshot userInfo;
  MonthScreen(this.monthInfo,this.expenseList,this.userInfo);

  @override
  _MonthScreenState createState() => _MonthScreenState();
}

class _MonthScreenState extends State<MonthScreen> {


  SharedPreferences preferences;
  String currentLang;

  void getCurrenLanguage() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      currentLang = preferences.getString('language');
    });
  }



  @override
  void initState() {
    getCurrenLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    Timestamp expenseMonth = widget.monthInfo.get('monthDate');

    double moneySpent = double.parse(widget.monthInfo.get('totalExpense')) + double.parse(widget.monthInfo.get('monthlyBills'));

    return Scaffold(
      appBar: AppBar(
       title:  Text("${S.of(context).monthlyPageTitle}: ${DateFormat("MMMM").format(expenseMonth.toDate())}"
       ),
        backgroundColor: Color(0xff01937C),
      ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("${S.of(context).monthlyBudget}: ${widget.monthInfo.get('userBudget')} SAR",style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),),
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
              Padding(
                padding: const EdgeInsets.only(top: 20 , left:5),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff01937C),
                      borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [

                        Column(
                            children: [

                              Text('${S.of(context).moneySpent}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:  19,
                                    fontWeight: FontWeight.bold
                                ),),

                            ]
                        ),
Divider(
  color: Colors.white,
),
                        Row(

                          children: [
                            McCountingText(
                              begin: 0,
                              end:moneySpent,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                              duration: Duration(seconds: 1),
                              curve: Curves.decelerate,
                            ),
                            Text(' ${S.of(context).saudiRyal}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17
                              ),),



                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(top: 20 , left:5),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff01937C),
                      borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [

                        Column(
                            children: [

                              Text('${S.of(context).moneySaved}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:  19,
                                    fontWeight: FontWeight.bold
                                ),),

                              Divider(

                              )

                            ]
                        ),



                        Row(
                          children: [
                            McCountingText(
                              begin: 0,
                              end:double.parse(widget.monthInfo.get('budgetLeft')),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                              duration: Duration(seconds: 1),
                              curve: Curves.decelerate,
                            ),
                            Text(' ${S.of(context).saudiRyal}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17
                              ),),



                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),




            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20 , left:5),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff01937C),
                        borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [

                          Column(
                              children: [

                                Text('${S.of(context).monthlyBills}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:  19,
                                      fontWeight: FontWeight.bold
                                  ),),

                              ]
                          ),
                          Divider(
                            color: Colors.white,
                          ),
                          Row(

                            children: [
                              McCountingText(
                                begin: 0,
                                end:double.parse(widget.monthInfo.get('monthlyBills')),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                                duration: Duration(seconds: 1),
                                curve: Curves.decelerate,
                              ),
                              Text(' ${S.of(context).saudiRyal}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17
                                ),),



                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(top: 20 , left:5),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff01937C),
                        borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [

                          Column(
                              children: [

                                Text('${S.of(context).totalExpense}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:  17,
                                      fontWeight: FontWeight.bold
                                  ),),

                                Divider(

                                )

                              ]
                          ),



                          Row(
                            children: [
                              McCountingText(
                                begin: 0,
                                end:double.parse(widget.monthInfo.get('totalExpense')),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                                duration: Duration(seconds: 1),
                                curve: Curves.decelerate,
                              ),
                              Text(' ${S.of(context).saudiRyal}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17
                                ),),



                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),




              ],),
            SizedBox(height: 20,),
            Divider(),
            SizedBox(height: 20,),
            Expanded(
              child: Container(

                child: ListView(
                  children: normalViewByMonth(widget.expenseList, widget.userInfo,DateTime.parse(expenseMonth.toDate().toString()).month.toString()),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
