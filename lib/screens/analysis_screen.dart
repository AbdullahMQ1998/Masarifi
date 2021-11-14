import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flash_chat/chartsData/categoryClass.dart';
import 'package:flash_chat/chartsData/dailyChartClass.dart';
import 'package:flash_chat/chartsData/monthlyChartClass.dart';

class AnalysisScreen extends StatefulWidget {
  final QueryDocumentSnapshot userInfo;
  final List<QueryDocumentSnapshot> userExpenseList;
  final List<QueryDocumentSnapshot> otherUsersExpense;
  final List<QueryDocumentSnapshot> otherUsersInfo;

  AnalysisScreen(this.userInfo, this.userExpenseList,this.otherUsersExpense, this.otherUsersInfo);

  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {

  List<CategoryData> _charData;
  List<avgCategoryData> _avgcharData;

  //Date Related Functions below here
  List<avgDayData> _dayData;

// month related data here
  List<avgMonthData> _monthData;
  @override
  void initState() {
    getCatagoryInfo(widget.otherUsersExpense , widget.otherUsersInfo);
    getUserCategoryInfo(widget.userExpenseList);
    getMaxOtherUsersList();
    getOtherUsersDay(widget.otherUsersExpense);
    getMaxDailyExpenseCount();
    getOtherUsersMonth(widget.otherUsersExpense);
    getMaxMonthlyExpenseCount();
    _charData = getChartData();
    _avgcharData = getAvgChartData();
    _dayData = getDayChartData();
    _monthData = getMonthChartData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children:[
            Column(
              children: [
                Container(
                  height: 300,
                  child: SfCircularChart(
                    legend: Legend(isVisible: true),
                    title: ChartTitle(
                        text: 'Masaryfy Category Count',
                        textStyle: TextStyle(fontWeight: FontWeight.bold)),
                    series: <CircularSeries>[
                      PieSeries<CategoryData, String>(
                        explode: true,
                        dataSource: _charData,
                        xValueMapper: (CategoryData data, _) => data.continent,
                        yValueMapper: (CategoryData data, _) => data.gdp,
                        dataLabelSettings: DataLabelSettings(

                            showCumulativeValues: true, useSeriesColor: true),
                        pointColorMapper: (CategoryData data, _) => data.color,
                      ),
                    ],
                  ),
                ),

                Divider(),

                Container(
                  color: Colors.white,
                  child: Column(

                    children: [

                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text('From the above chart, we can see the total amount of categories among the users in Masaryfy excluding you.'),
                      ),

                      Text("By observing the data from the above chart we discovered the next:"),
                      Text("The majority of expenses goes to ${othersExpensescounters[getMaxOtherUsersList()[0]]} by ${((getMaxOtherUsersList()[0]/percent) * 100).toInt()}%"),
                      Text("The second most category goes to ${othersExpensescounters[getMaxOtherUsersList()[1]]} by ${((getMaxOtherUsersList()[1]/percent) * 100).toInt()}%"),
                      Text("The least category goes to ${othersExpensescounters[getMaxOtherUsersList()[2]]} by ${((getMaxOtherUsersList()[2]/percent)* 100).toInt()}%"),
                      Text('Saturday = $saturdayCounter'),
                      Text('Sunday = $sundayCounter'),



                    ],
                  ),
                ),


                Container(

                  child: SfCartesianChart(
                    legend: Legend(isVisible: true),
                    title: ChartTitle(
                        text: 'Masaryfy Average Users Expense Compare To You',
                        textStyle: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 10)),
                    primaryXAxis: CategoryAxis(),
                    primaryYAxis: NumericAxis(minimum: 0 , maximum: maxUser > maxOther? maxUser : maxOther , interval: maxUser == 0 ? maxOther / 2 : maxUser / 2),
                    series: <CartesianSeries>[
                      BarSeries<avgCategoryData, String>(
                        dataSource: _avgcharData,
                        xValueMapper: (avgCategoryData data, _) => data.expenseName,
                        yValueMapper: (avgCategoryData data, _) => data.otherUserstotalAmount,
                        name: 'Avg Expense',
                        dataLabelSettings: DataLabelSettings(
                          showCumulativeValues: true, useSeriesColor: true,),

                      ),

                      BarSeries<avgCategoryData, String>(
                        dataSource: _avgcharData,
                        xValueMapper: (avgCategoryData data, _) => data.expenseName,
                        yValueMapper: (avgCategoryData data, _) => data.myTotalAmount,
                        name: 'Your Expense',
                        dataLabelSettings: DataLabelSettings(
                          showCumulativeValues: true, useSeriesColor: true,
                        ),

                      ),

                    ],
                  ),
                ),


                SfCartesianChart(
                  legend: Legend(isVisible: true),
                  title: ChartTitle(
                      text: 'Masaryfy Users Daily Expense Count',
                      textStyle: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 10)),
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(minimum: 0 , maximum: getMaxDailyExpenseCount()[0].toDouble() , interval: getMaxDailyExpenseCount()[0]/4.0),
                  series: <CartesianSeries>[
                    BarSeries<avgDayData, String>(
                      dataSource: _dayData,
                      xValueMapper: (avgDayData data, _) => data.dayName,
                      yValueMapper: (avgDayData data, _) => data.dayAmount,
                      name: 'Daily Expense',
                      dataLabelSettings: DataLabelSettings(
                        showCumulativeValues: true, useSeriesColor: true,),

                    ),

                  ],
                ),

                Text("By observing the data from the above chart we discovered the next:"),
                Text("The majority of expenses goes to ${dailyExpenseCount[getMaxDailyExpenseCount()[0]]} by ${((getMaxDailyExpenseCount()[0]/percentDaily) * 100).toInt()}%"),
                Text("The second most category goes to ${dailyExpenseCount[getMaxDailyExpenseCount()[1]]} by ${((getMaxDailyExpenseCount()[1]/percentDaily) * 100).toInt()}%"),
                Text("The least category goes to ${dailyExpenseCount[getMaxDailyExpenseCount()[2]]} by ${((getMaxDailyExpenseCount()[2]/percentDaily) * 100).toInt()}%"),
                Text('Saturday = $saturdayCounter'),
                Text('Sunday = $sundayCounter'),



                SfCartesianChart(
                  legend: Legend(isVisible: true),
                  title: ChartTitle(
                      text: 'Masaryfy Users Monthly Expense Count',
                      textStyle: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 10)),
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(minimum: 0 , maximum: getMaxMonthlyExpenseCount()[0].toDouble() , interval: getMaxMonthlyExpenseCount()[0]/4.0),
                  series: <CartesianSeries>[
                    BarSeries<avgMonthData, String>(
                      dataSource: _monthData,
                      xValueMapper: (avgMonthData data, _) => data.monthName,
                      yValueMapper: (avgMonthData data, _) => data.monthAmount,
                      name: 'Monthly Expense',
                      dataLabelSettings: DataLabelSettings(
                        showCumulativeValues: true, useSeriesColor: true,),

                    ),

                  ],
                ),

                Text("By observing the data from the above chart we discovered the next:"),
                Text("The majority of expenses goes to ${monthlyExpenseCount[getMaxMonthlyExpenseCount()[0]]} by ${((getMaxMonthlyExpenseCount()[0]/percentMonthly) * 100).toInt()}%"),
                Text("The second most category goes to ${monthlyExpenseCount[getMaxMonthlyExpenseCount()[1]]} by ${((getMaxMonthlyExpenseCount()[1]/percentMonthly) * 100).toInt()}%"),
                Text("The least category goes to ${monthlyExpenseCount[getMaxMonthlyExpenseCount()[2]]} by ${((getMaxMonthlyExpenseCount()[2]/percentMonthly) * 100).toInt()}%"),

              ],
            ),
          ]
        ),
      ),
    );
  }


}
