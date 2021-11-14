import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flash_chat/chartsData/categoryClass.dart';
import 'package:flash_chat/chartsData/dailyChartClass.dart';
import 'package:flash_chat/chartsData/monthlyChartClass.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
      backgroundColor: Color(0xff1F1D36),
      body: SafeArea(
        child: ListView(
          children:[
            Column(
              children: [
                Container(
                  child: SfCircularChart(
                    backgroundColor: Color(0xff1F1D36),
                    legend: Legend(isVisible: true,textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    )),
                    title: ChartTitle(
                        text: 'Masaryfy Category Count',
                        textStyle: TextStyle(fontWeight: FontWeight.bold,
                        color: Colors.white)),
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



                Container(
                  color:  Color(0xff1F1D36),
                  child: Column(

                    children: [


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Text('Most Category',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20
                                        ),),
                                      Divider(),
                                      new CircularPercentIndicator(

                                        radius: 80.0,
                                        lineWidth: 10.0,
                                        animation: true,
                                        percent: ((getMaxOtherUsersList()[0]/percent)),
                                        center: new Text(
                                          "${((getMaxOtherUsersList()[0]/percent) * 100).toInt()}%",
                                          style:
                                          new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.white),
                                        ),
                                        footer: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: new Text(
                                            "${othersExpensescounters[getMaxOtherUsersList()[0]]}",
                                            style:
                                            new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.white),
                                          ),
                                        ),
                                        circularStrokeCap: CircularStrokeCap.round,
                                        progressColor: Colors.white,
                                      ),

                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: Color(0xff864879),
                                    borderRadius: BorderRadius.all(Radius.circular(30))
                                ),
                              ),
                              VerticalDivider(
                                color: Colors.white,
                                thickness: 1,
                                indent: 0,
                                endIndent: 0,
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Text('Least Category',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20
                                        ),),
                                      Divider(),
                                      new CircularPercentIndicator(

                                        radius: 80.0,
                                        lineWidth: 10.0,
                                        animation: true,
                                        percent: ((getMaxOtherUsersList()[2]/percent)),
                                        center: new Text(
                                          "${((getMaxOtherUsersList()[2]/percent)* 100).toInt()}%",
                                          style:
                                          new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.white),
                                        ),
                                        footer: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: new Text(
                                            "${othersExpensescounters[getMaxOtherUsersList()[2]]}",
                                            style:
                                            new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.white),
                                          ),
                                        ),
                                        circularStrokeCap: CircularStrokeCap.round,
                                        progressColor: Colors.white,
                                      ),

                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: Color(0xff864879),
                                    borderRadius: BorderRadius.all(Radius.circular(30))
                                ),
                              ),


                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Divider( thickness: 2,color: Colors.white,
                  indent: 30,endIndent: 30,),

                Container(

                  child: SfCartesianChart(

                    legend: Legend(isVisible: true,textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    )),
                    title: ChartTitle(
                        text: 'Masaryfy Average Users Expense Compare To You',
                        textStyle: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 10, color: Colors.white)),
                    primaryXAxis: CategoryAxis(labelStyle: TextStyle(
                      color: Colors.white,fontWeight: FontWeight.bold, fontSize: 13
                    )),
                    primaryYAxis: NumericAxis(minimum: 0 , maximum: maxUser > maxOther? maxUser : maxOther , interval: maxUser == 0 ? maxOther / 2 : maxUser / 2,labelStyle: TextStyle(
                        color: Colors.white,fontWeight: FontWeight.bold, fontSize: 13
                    )),
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




                Container(

                  child: Column(

                    children: [


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(

                                  children: [
                                    Text('Most Average Category',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15
                                      ),),
                                    Divider(),

                                    Text('${avgOthersExpensescountersString[maxOther]}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30
                                      ),),

                                    SizedBox(
                                      height: 15,
                                    ),


                                    Text('$maxOther per User',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                      ),),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xff864879),
                                  borderRadius: BorderRadius.all(Radius.circular(30))
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Text('Your Most Category',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15
                                      ),),
                                    Divider(),

                                    Text('${avgOthersExpensescountersString[maxOther]}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30
                                      ),),

                                    SizedBox(
                                      height: 15,
                                    ),


                                    Text('Total: $maxUser',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                      ),),

                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xff864879),
                                  borderRadius: BorderRadius.all(Radius.circular(30))
                              ),
                            ),


                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider( thickness: 2,color: Colors.white, indent: 20, endIndent: 20,),


                SfCartesianChart(
                  legend: Legend(isVisible: true , textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  )),
                  title: ChartTitle(
                      text: 'Masaryfy Users Daily Expense Count',
                      textStyle: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 10,color: Colors.white)),
                  primaryXAxis: CategoryAxis( labelStyle: TextStyle(
                      color: Colors.white,fontWeight: FontWeight.bold, fontSize: 13
                  )),
                  primaryYAxis: NumericAxis(minimum: 0 , maximum: getMaxDailyExpenseCount()[0].toDouble() , interval: getMaxDailyExpenseCount()[0]/4.0,labelStyle: TextStyle(
                      color: Colors.white,fontWeight: FontWeight.bold, fontSize: 13
                  )),
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


                Divider( thickness: 2,color: Colors.white,indent: 20,endIndent: 20,),

                Container(

                  child: Column(

                    children: [


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(

                                  children: [
                                    Text('Best Day of Purchase',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15
                                      ),),
                                    Divider(),

                                    new CircularPercentIndicator(

                                      radius: 80.0,
                                      lineWidth: 10.0,
                                      animation: true,
                                      percent: ((getMaxDailyExpenseCount()[0]/percentDaily)),
                                      center: new Text(
                                        "${((getMaxDailyExpenseCount()[0]/percentDaily) * 100).toInt()}%",
                                        style:
                                        new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.white),
                                      ),

                                      footer: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: new Text(
                                          "${dailyExpenseCount[getMaxDailyExpenseCount()[0]]}",
                                          style:
                                          new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.white),
                                        ),
                                      ),
                                      circularStrokeCap: CircularStrokeCap.round,
                                      progressColor: Colors.white,
                                    ),

                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xff864879),
                                  borderRadius: BorderRadius.all(Radius.circular(30))
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Text('Lowest Day of Purchase',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15
                                      ),),
                                    Divider(),

                                    new CircularPercentIndicator(

                                      radius: 80.0,
                                      lineWidth: 10.0,
                                      animation: true,
                                      percent: ((getMaxDailyExpenseCount()[2]/percentDaily)),
                                      center: new Text(
                                        "${((getMaxDailyExpenseCount()[2]/percentDaily) * 100).toInt()}%",
                                        style:
                                        new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.white),
                                      ),

                                      footer: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: new Text(
                                          "${dailyExpenseCount[getMaxDailyExpenseCount()[2]]}",
                                          style:
                                          new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.white),
                                        ),
                                      ),
                                      circularStrokeCap: CircularStrokeCap.round,
                                      progressColor: Colors.white,
                                    ),

                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xff864879),
                                  borderRadius: BorderRadius.all(Radius.circular(30))
                              ),
                            ),


                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider( thickness: 2,color: Colors.white,endIndent: 20,indent: 20,),


                SfCartesianChart(
                  legend: Legend(isVisible: true, textStyle: TextStyle(
                    fontWeight: FontWeight.bold,color: Colors.white
                  )),
                  title: ChartTitle(

                      text: 'Masaryfy Users Monthly Expense Count',
                      textStyle: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 10,color: Colors.white)),
                  primaryXAxis: CategoryAxis(labelStyle: TextStyle(
                      color: Colors.white,fontWeight: FontWeight.bold, fontSize: 13
                  )),
                  primaryYAxis: NumericAxis(minimum: 0 , maximum: getMaxMonthlyExpenseCount()[0].toDouble() , interval: getMaxMonthlyExpenseCount()[0]/4.0,labelStyle: TextStyle(
                      color: Colors.white,fontWeight: FontWeight.bold, fontSize: 13
                  )),
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

                Divider( thickness: 2,color: Colors.white,),

                Container(

                  child: Column(

                    children: [


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(

                                  children: [
                                    Text('Best Day of Purchase',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15
                                      ),),
                                    Divider(),

                                    new CircularPercentIndicator(

                                      radius: 80.0,
                                      lineWidth: 10.0,
                                      animation: true,
                                      percent: ((getMaxMonthlyExpenseCount()[0]/percentMonthly)),
                                      center: new Text(
                                        "${((getMaxMonthlyExpenseCount()[0]/percentMonthly) * 100).toInt()}%",
                                        style:
                                        new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.white),
                                      ),

                                      footer: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: new Text(
                                          "${monthlyExpenseCount[getMaxMonthlyExpenseCount()[0]]}",
                                          style:
                                          new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.white),
                                        ),
                                      ),
                                      circularStrokeCap: CircularStrokeCap.round,
                                      progressColor: Colors.white,
                                    ),

                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xff864879),
                                  borderRadius: BorderRadius.all(Radius.circular(30))
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Text('Lowest Day of Purchase',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15
                                      ),),
                                    Divider(),

                                    new CircularPercentIndicator(

                                      radius: 80.0,
                                      lineWidth: 10.0,
                                      animation: true,
                                      percent: ((getMaxMonthlyExpenseCount()[2]/percentDaily)),
                                      center: new Text(
                                        "${((getMaxMonthlyExpenseCount()[2]/percentDaily) * 100).toInt()}%",
                                        style:
                                        new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.white),
                                      ),

                                      footer: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: new Text(
                                          "${monthlyExpenseCount[getMaxMonthlyExpenseCount()[2]]}",
                                          style:
                                          new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.white),
                                        ),
                                      ),
                                      circularStrokeCap: CircularStrokeCap.round,
                                      progressColor: Colors.white,
                                    ),

                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xff864879),
                                  borderRadius: BorderRadius.all(Radius.circular(30))
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),


              ],
            ),
          ]
        ),
      ),
    );
  }


}
