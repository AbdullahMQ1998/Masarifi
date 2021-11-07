import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'register_user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_expense_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  final User loggedUser;
  HomeScreen(this.loggedUser);
  double totalExpense= 0;


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  List<QueryDocumentSnapshot> userInfoList;





  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f3f4),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              // Here in the stream we get the user info from the database based on his email, we will get all of his information
              stream: FirebaseFirestore.instance
                  .collection('User_Info')
                  .where('email', isEqualTo: widget.loggedUser.email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator(
                    backgroundColor: Colors.blueAccent,
                  );
                }

                //userInfo holds all of the information required in the database,
                //We can access any info in the userInfo by an index like usersInfo[0].get("The information you need").
                final usersInfo = snapshot.data.docs;
                userInfoList = usersInfo;


                return Column(
                  
                  children: [
                    Container(
                      color: Color(0xff50c878),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 30, top: 30),
                            child: HomeScreenTextWidget(
                              text: 'Welcome ${usersInfo[0].get('userName')} !',
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              padding: 15,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: HomeScreenTextWidget(
                              text: "Total balance to spend",
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                              padding: 5,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 30),
                            child: HomeScreenTextWidget(
                              text: "${usersInfo[0].get('monthlyIncome')} SAR",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              padding: 5,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HomeScreenTextWidget(
                            text: "Expense",
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            padding: 20,
                          ),
                          HomeScreenTextWidget(
                            text: "${usersInfo[0].get('totalExpense')} SAR",
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.grey,
                            padding: 20,
                          ),
                        ]),
                    Container(
                      height: 200,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('expense')
                            .where('email', isEqualTo: widget.loggedUser.email)
                            .snapshots(),
                        builder: (context,snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator(
                              backgroundColor: Colors.blueAccent,
                            );
                          }
                            var expenses = snapshot.data.docs;
                          List<ExpenseBubble> expensesList = [];
                          //We add expense from here
                          for(var expense in expenses){
                            final expenseName = expense.get('expenseName');
                            final String expenseCost = expense.get('expenseCost');
                            final expenseDate = expense.get('expenseDate');
                            final expenseTime = expense.get('expenseTime');


                            //All the information above we add it into a list of bubbles which can be found below.
                            expensesList.add(ExpenseBubble(expenseName, expenseCost, expenseDate, expenseTime));
                          }
                            expensesList.reversed;
                          return ListView(
                            reverse: true,
                            scrollDirection: Axis.horizontal,
                            children: expensesList,
                            
                          );
                        },



                      ),
                    ),
                  ],
                );
              }),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: IconButton(icon: Icon(Icons.home)),),
            Expanded(child: IconButton(icon: Icon(Icons.show_chart)),),
            Expanded(child: new Text('')),
            Expanded(child: IconButton(icon: Icon(Icons.tab)),),
            Expanded(
              child: IconButton(icon: Icon(Icons.settings),
                onPressed: (){
                _auth.signOut();
                Navigator.pop(context);
                },
            ),
            ),
          ],
        ),
      ),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(backgroundColor: Color(0xff50c878),
            onPressed: (){
              showModalBottomSheet(context: context, builder: (BuildContext context) => AddExpenseScreen(
                      (taskTitle){
                    Navigator.pop(context);
                    setState(() {

                    });
                  },
                widget.loggedUser,
                userInfoList




              )
              );
            },
            child: Icon(Icons.add))
    );

  }
}

class HomeScreenTextWidget extends StatelessWidget {
  HomeScreenTextWidget(
      {this.text, this.fontSize, this.fontWeight, this.color, this.padding});

  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}

class ExpenseBubble extends StatelessWidget {
  ExpenseBubble(this.expenseName, this.expenseCost, this.expenseDate,this.expenseTime);

  final String expenseName;
  final String expenseCost;
  final String expenseDate;
  final String expenseTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Material(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 5,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                ExpenseBubbleTextStyle(firstText: "", secondText: expenseName, padding: 20, fontSize: 25,),
                ExpenseBubbleTextStyle(
                  firstText: "Cost: ",
                  secondText: "$expenseCost SAR",
                  padding: 15,
                  fontSize: 18,
                  color: Colors.green,
                ),
                ExpenseBubbleTextStyle(
                  firstText: "Date: ",
                  secondText: expenseDate,
                  fontSize: 15,
                  padding: 1,
                ),

                    ExpenseBubbleTextStyle(
                      firstText: "Time: ",
                      secondText: expenseTime,
                      fontSize: 15,
                      padding: 10,
                    ),

              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class ExpenseBubbleTextStyle extends StatelessWidget {

  final String firstText;
  final String secondText;
  final double padding;
  final Color color;
  final double fontSize;



  ExpenseBubbleTextStyle({this.firstText,this.secondText,this.padding,this.fontSize,this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.only(bottom: padding , right:padding ,),
      child: Row(
        children:[
          Text(firstText,
            style: TextStyle(
              color: Colors.black,
              fontSize: fontSize,
              fontWeight: FontWeight.bold
            ),

          ),
          Text("$secondText",
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: color
            ),
          ),
        ]
      ),
    );
  }
}
