import 'package:flash_chat/Components/widgets.dart';
import 'package:flash_chat/screens/expense_screen.dart';
import 'package:flash_chat/screens/saving_plan_screen.dart';
import 'package:flash_chat/screens/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../modalScreens/choose_expense_or_monthly_screen.dart';
import 'welcome_screen.dart';
import 'package:flash_chat/Components/ListViewWidgets.dart';
import 'package:path/path.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  final User loggedUser;

  HomeScreen(this.loggedUser);
  double totalExpense = 0;
  int count = 0;



  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  List<QueryDocumentSnapshot> userInfoList;
  List<QueryDocumentSnapshot> expenseList;

  bool darkMode = false;

  @override


@override




  @override
  @override
  Widget build(BuildContext context) {




    return Scaffold(

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
                              text: "${usersInfo[0].get('userBudget')} SAR",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              padding: 5,
                            ),
                          )
                        ],
                      ),
                    ),
                    RowTextWithTotal(
                      text: "Monthly Bills",
                      totalAmount: usersInfo[0].get('totalMonthlyBillCost'),
                      userInfo: usersInfo[0],
                    ),

                    //MonthlyBill list in Components > ListviewWidgets file
                    MonthlyBillsSVerticalListView(widget, usersInfo[0]),

                    Divider(
                      height: 10,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),

                    RowTextWithTotal(
                      userInfo: usersInfo[0],
                      text: "Expenses >",
                      totalAmount: usersInfo[0].get('totalExpense'),
                      onPress: () {
                        DateTime currentDate = DateTime.now();
                        DateTime beforeOneMonthDate = DateTime(currentDate.year,
                            currentDate.month - 1, currentDate.day);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExpenseScreen(
                                      widget.loggedUser,
                                      beforeOneMonthDate,
                                      userInfoList[0],
                                    )));
                      },
                    ),

                    //ExpenseListView list in Components > ListViewWidgets file

                    ExpenseListView(widget, userInfoList[0]),
                  ],
                );
              }),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: (){
              },
              color: Colors.green,

            ),
            IconButton(
                icon: Icon(Icons.show_chart),
              onPressed: (){



              },

            ),
            IconButton(icon: Icon(Icons.tab),

              onPressed: (){
              double monthlyIncome = double.parse(userInfoList[0].get('monthlyIncome'));
              double needs = monthlyIncome * 0.50;
              double wants = monthlyIncome * 0.30;
              double saving = monthlyIncome * 0.20;
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SavingPlanScreen(widget.loggedUser,userInfoList[0],needs,wants,saving)

              ));
              },

            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(

                        builder: (context) => SettingScreen(
                          userInfoList[0]
                        )
                )
                );

              },
            ),
            SizedBox(
              width: 10,
            ),
            FloatingActionButton(
                backgroundColor: Color(0xff50c878),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) =>
                          ChooseExpenseOrMonthlyScreen(
                            (taskTitle) {
                              Navigator.pop(context);
                            },
                            widget.loggedUser,
                            userInfoList,
                          ));
                },
                child: Icon(Icons.add))
          ],
        ),
      ),
      backgroundColor: Color(0xfff2f3f4)  ,
    );
  }
}
