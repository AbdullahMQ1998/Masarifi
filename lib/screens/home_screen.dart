
import 'package:flash_chat/Components/widgets.dart';
import 'package:flash_chat/screens/expense_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../modalScreens/choose_expense_or_monthly_screen.dart';
import 'welcome_screen.dart';
import 'package:flash_chat/Components/ListViewWidgets.dart';

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
                                text:
                                    'Welcome ${usersInfo[0].get('userName')} !',
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
                                text:
                                    "${usersInfo[0].get('monthlyIncome')} SAR",
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
                      ),


                      //MonthlyBill list in Components > ListviewWidgets file
                      MonthlyBillsSVerticalListView(widget: widget),



                      Divider(
                        height: 10,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),


                      RowTextWithTotal(
                      text: "Expenses",
                      totalAmount: usersInfo[0].get('totalExpense'),
                        onPress: (){
                          DateTime currentDate = DateTime.now();
                          DateTime beforeOneMonthDate = DateTime(currentDate.year,currentDate.month-1,currentDate.day);

                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              ExpenseScreen(
                                  widget.loggedUser,
                                  beforeOneMonthDate

                              ))
                          );
                        },
                        ),

                      //ExpenseListView list in Components > ListViewWidgets file

                      ExpenseListView(widget , userInfoList),
                    ],
                  );
                }),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: IconButton(icon: Icon(Icons.home)),
              ),
              Expanded(
                child: IconButton(icon: Icon(Icons.show_chart)),
              ),
              Expanded(child: new Text('')),
              Expanded(
                child: IconButton(icon: Icon(Icons.tab)),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    _auth.signOut();
                    Navigator.pushNamed(context,WelcomeScreen.id);
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xff50c878),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) =>
                      ChooseExpenseOrMonthlyScreen((taskTitle) {
                        Navigator.pop(context);
                      },
                      widget.loggedUser,
                      userInfoList,
                      ));
            },
            child: Icon(Icons.add)));
  }
}




