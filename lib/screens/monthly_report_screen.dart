import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'month_screen.dart';


class MonthlyReportScreen extends StatefulWidget {
  final List<QueryDocumentSnapshot> expenseList;
  final QueryDocumentSnapshot userInfo;

  MonthlyReportScreen(this.expenseList,this.userInfo);
  @override
  _MonthlyReportScreenState createState() => _MonthlyReportScreenState();
}

class _MonthlyReportScreenState extends State<MonthlyReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff01937C),
        title: Text("${S.of(context).monthlyPageTitle}"),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
    // Here in the stream we get the user info from the database based on his email, we will get all of his information
    stream: FirebaseFirestore.instance
        .collection('monthly_report')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser.email)
        .snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return CircularProgressIndicator(
          backgroundColor: Colors.blueAccent,
        );
      }

      final monthlyList = snapshot.data.docs;


      List<MonthlyReportBubble> monthlyReports= [];

      for(int i = 0 ; i < monthlyList.length ; i++){
        Timestamp currentMonth =  monthlyList[i].get('monthDate');
        DateTime dateTime = DateTime.parse(currentMonth.toDate().toString());
        String monthName = DateFormat('MMMM').format(dateTime);
        String yearName = dateTime.year.toString();
        monthlyReports.add(MonthlyReportBubble(yearName, monthName,monthlyList[i],widget.expenseList,widget.userInfo));
      }


      

      return Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: monthlyReports,
        ),
      );
    } ),
      ),
    );
  }
}

class MonthlyReportBubble extends StatelessWidget {

  final String monthName;
  final String yearName;
  final QueryDocumentSnapshot monthInfo;
  final List<QueryDocumentSnapshot> expenseList;
  final QueryDocumentSnapshot userInfo;
  MonthlyReportBubble(this.yearName,this.monthName,this.monthInfo,this.expenseList,this.userInfo);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlatButton(
        onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => MonthScreen(monthInfo,expenseList,userInfo)));
        },
        child: Container(

          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text("${S.of(context).monthTitle}",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),),
                  Divider(thickness: 2,),
                  Text(monthName,style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),),
                  Text(yearName,style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
