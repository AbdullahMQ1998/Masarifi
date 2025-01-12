

import 'package:flash_chat/Components/widgets.dart';
import 'package:flash_chat/Provider/dark_them.dart';
import 'package:flash_chat/generated/l10n.dart';
import 'package:flash_chat/screens/analysis_screen.dart';
import 'package:flash_chat/screens/expense_screen.dart';
import 'package:flash_chat/screens/monthly_report_screen.dart';
import 'package:flash_chat/screens/saving_plan_screen.dart';
import 'package:flash_chat/screens/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../modalScreens/choose_expense_or_monthly_screen.dart';
import 'package:flash_chat/Components/ListViewWidgets.dart';
import 'package:mccounting_text/mccounting_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flash_chat/notification/notificationAPI.dart';



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



  SharedPreferences preferences;
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  List<QueryDocumentSnapshot> userInfoList;
  List<QueryDocumentSnapshot> expenseList;
  List<QueryDocumentSnapshot> monthlyBillList;
  List<QueryDocumentSnapshot> monthlyReportList;


  List<QueryDocumentSnapshot> otherUserExpenseList;
  List<QueryDocumentSnapshot> otherUserInfoList;



  String currentLang = "ar";

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



  void updateNotification(){
    NotificationApi.showScheduledNotification(
        title: 'Masarifi',
        body: "${S.of(context).notifications}",
        payload: "Masarifi",
        hours: 19,
        min: 00
    );
  }

  void lastDayOftheMonth()  {
    DateTime currentDay = DateTime.now();
    final firstDayOfMonth = DateTime(currentDay.year, currentDay.month, 1);
    DateTime secondDayOftheMonth= DateTime(currentDay.year,currentDay.month ,2);
    double userBudget = double.parse(userInfoList[0].get('monthlyIncome')) * 0.80;


    if(currentDay.day >= secondDayOftheMonth.day){
      userInfoList[0].reference.update({'lastDayBool': true});
    }

    if(currentDay.day == firstDayOfMonth.day && userInfoList[0].get('lastDayBool') == true){
      _fireStore.collection("monthly_report").add(
        {
          'email': userInfoList[0].get('email'),
          'budgetLeft': userInfoList[0].get('userBudget'),
          'monthDate': DateTime(currentDay.year,currentDay.month-1),
          'totalExpense': userInfoList[0].get('totalExpense'),
          'userBudget': userBudget,
          'totalMonthly': userInfoList[0].get('totalMonthlyBillCost'),
          'monthlyBills': userInfoList[0].get('totalMonthlyBillCost')
        }
      );
      double zero = 0;
      userInfoList[0].reference.update({'totalExpense': zero.toString() });
      double monthlyExpense =  userBudget - double.parse(userInfoList[0].get('totalMonthlyBillCost'));
      userInfoList[0].reference.update({'userBudget': monthlyExpense.toString()});
      userInfoList[0].reference.update({'lastDayBool': false});
    }
  }

  @override
  Widget build(BuildContext context) {



    final themChange = Provider.of<DarkThemProvider>(context);
    Color _topContainerColor(String userBudget, String monthlyIncome) {
      double userBdget = double.parse(userBudget);
      double monthlyIncm = double.parse(monthlyIncome);

      double halfOfTheBudgetTracker = monthlyIncm * 0.5;
      double quarterOfTheBudgetTracker = monthlyIncm * 0.25;

      //50% left from the budget => color change to orange;
      if (userBdget <= halfOfTheBudgetTracker &&
          userBdget >= quarterOfTheBudgetTracker) {
        return Color(0xffFF7600);
      }

      if (userBdget < halfOfTheBudgetTracker &&
          userBdget <= quarterOfTheBudgetTracker) {
        return Color(0xffe51342);
      } else
        return Color(0xff007563);
    }

    double totalBudget = 0;
    updateNotification();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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

                  lastDayOftheMonth();


                  return Column(
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('User_Info')
                            .where('email', isNotEqualTo: widget.loggedUser.email)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator(
                              backgroundColor: Colors.blueAccent,
                            );
                          }

                          final otheruser = snapshot.data.docs;
                          otherUserInfoList = otheruser;

                          return SizedBox();
                        },
                      ),

                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('expense')
                              .where('email', isEqualTo: widget.loggedUser.email)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text(
                                '',
                              );
                            }
                            var expenses = snapshot.data.docs;
                            expenseList = expenses;

                            return SizedBox();
                          }),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('expense')
                            .where('email', isNotEqualTo: widget.loggedUser.email)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator(
                              backgroundColor: Colors.blueAccent,
                            );
                          }

                          final otheruser = snapshot.data.docs;
                          otherUserExpenseList = otheruser;

                          return SizedBox();
                        },
                      ),


                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('monthly_bills')
                              .where('email', isEqualTo: widget.loggedUser.email)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text(
                                '',
                              );
                            }
                            var monthlyBill = snapshot.data.docs;
                            monthlyBillList = monthlyBill;

                            return SizedBox();
                          }),

                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('monthly_report')
                              .where('email', isEqualTo: widget.loggedUser.email)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text(
                                '',
                              );
                            }
                            var monthlyReport = snapshot.data.docs;
                            monthlyReportList = monthlyReport;

                            return SizedBox();
                          }),

                      Container(
                        color: _topContainerColor(
                            userInfoList[0].get('userBudget'),
                            userInfoList[0].get('monthlyIncome')),
                        child: Column(

                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 20, top: 30),
                                    child: HomeScreenTextWidget(
                                      text: '${S.of(context).welcomeText} ${usersInfo[0].get('userName')} !',
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      padding: 5,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 0),
                                    child: HomeScreenTextWidget(
                                      text: "${S.of(context).balanceToSpend}",
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70,
                                      padding: 0,
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Row(
                                      children: [
                                        McCountingText(
                                          begin: totalBudget,
                                          end: double.parse(
                                              usersInfo[0].get('userBudget')),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                          duration: Duration(seconds: 1),
                                          curve: Curves.decelerate,
                                        ),
                                        Text(
                                          ' ${S.of(context).saudiRyal}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],),



                                Padding(
                                  padding: const EdgeInsets.only(top: 50),
                                  child: Image.asset("images/144.png"),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 5,
                            ),

                            // Padding(
                            //   padding: EdgeInsets.only(left: 15,bottom: 10),
                            //   child: HomeScreenTextWidget(
                            //     text: "${_getDaysLeftForSalary(userInfoList[0].get('salaryDate'))} Days left",
                            //     color: Colors.white,
                            //     fontWeight: FontWeight.bold,
                            //     fontSize: 20,
                            //     padding: 10,
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      RowTextWithTotal(
                        text: "${S.of(context).monthlyBills}",
                        totalAmount: double.parse(usersInfo[0].get('totalMonthlyBillCost')).toStringAsFixed(2),
                        userInfo: usersInfo[0],
                        onPress: (){

                        },
                      ),

                      //MonthlyBill list in Components > ListviewWidgets file
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MonthlyBillsSVerticalListView(widget, usersInfo[0]),
                      ),

                      Divider(
                        height: 10,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),

                      RowTextWithTotal(
                        userInfo: usersInfo[0],
                        text: "${S.of(context).expense} >>",
                        totalAmount: double.parse(usersInfo[0].get('totalExpense')).toStringAsFixed(2),
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

                      SingleChildScrollView(child: ExpenseListView(widget, userInfoList[0])),
                    ],
                  );
                }),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {},
              color:  Color(0xff01937C),
            ),
            IconButton(
              icon: Icon(Icons.show_chart),
              onPressed: () {

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AnalysisScreen(
                            userInfoList[0],
                            expenseList,
                            otherUserExpenseList,
                            otherUserInfoList,

                       )));
              },
            ),
            IconButton(
              icon: Icon(Icons.tab),
              onPressed: () {
                double monthlyIncome =
                    double.parse(userInfoList[0].get('monthlyIncome'));
                double needs = monthlyIncome * 0.50;
                double wants = monthlyIncome * 0.30;
                double saving = monthlyIncome * 0.20;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SavingPlanScreen(
                            widget.loggedUser,
                            userInfoList[0],
                            needs,
                            wants,
                            saving)));
              },
            ),

            IconButton(
              icon: Icon(Icons.file_copy),
              onPressed: () {

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MonthlyReportScreen(expenseList,userInfoList[0])));
              },
            ),

            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingScreen(userInfoList[0],expenseList,monthlyBillList,monthlyReportList)));
              },
            ),


            SizedBox(
              width: 10,
            ),
            Container(
              height: 40,
              child: FloatingActionButton(

                  backgroundColor:  Color(0xff01937C),
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
                  child: Icon(Icons.add)),
            )
          ],
        ),
      ),
      // backgroundColor: Color(0xfff2f3f4),
    );
  }
}
