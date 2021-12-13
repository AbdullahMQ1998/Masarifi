import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/Provider/dark_them.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flash_chat/chartsData/categoryClass.dart';
import 'package:flash_chat/chartsData/dailyChartClass.dart';
import 'package:flash_chat/chartsData/monthlyChartClass.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flash_chat/Provider/language_change_provider.dart';
import 'package:flash_chat/generated/l10n.dart';

class AnalysisScreen extends StatefulWidget {
  final QueryDocumentSnapshot userInfo;
  final List<QueryDocumentSnapshot> userExpenseList;
  final List<QueryDocumentSnapshot> otherUsersExpense;
  final List<QueryDocumentSnapshot> otherUsersInfo;

  AnalysisScreen(this.userInfo, this.userExpenseList, this.otherUsersExpense,
      this.otherUsersInfo);

  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  SharedPreferences preferences;
  List<CategoryData> _charData;
  List<avgCategoryData> _avgcharData;

  //Date Related Functions below here
  List<avgDayData> _dayData;

// month related data here
  List<avgMonthData> _monthData;



  @override
  void initState() {
    getCatagoryInfo(widget.otherUsersExpense, widget.otherUsersInfo);
    getUserCategoryInfo(widget.userExpenseList);
    getMaxOtherUsersList();
    getOtherUsersDay(widget.otherUsersExpense);
    getMaxDailyExpenseCount();
    getOtherUsersMonth(widget.otherUsersExpense);
    getMaxMonthlyExpenseCount();
    getCurrenLanguage();
    super.initState();
  }



  String currentLang;

  void getCurrenLanguage() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      currentLang = preferences.getString('language');
    });
  }


  @override
  Widget build(BuildContext context) {
    final langChange = Provider.of<LanguageChangeProvider>(context);
    final themChange = Provider.of<DarkThemProvider>(context);

    _charData = getChartData(currentLang);
    _avgcharData = getAvgChartData(currentLang);
    _dayData = getDayChartData(currentLang);
    _monthData = getMonthChartData(currentLang);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff01937C),
        title: Center(child: Text("${S.of(context).dataAnalysisPageTitle}")),
      ),
      body: SafeArea(
        child: ListView(children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 600,
                  child:  SfCartesianChart(
                    legend: Legend(
                        isVisible: true,
                        textStyle: TextStyle(
                            color: themChange.getDarkTheme()
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold)),
                    title: ChartTitle(
                        text: '${S.of(context).masarifiCategoryCount}',
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: themChange.getDarkTheme()
                                ? Colors.white
                                : Colors.black)),
                    primaryXAxis: CategoryAxis(
                        labelStyle: TextStyle(
                            color: themChange.getDarkTheme()
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                    primaryYAxis: NumericAxis(
                        minimum: 0,
                        maximum: getMaxOtherUsersList()[0].toDouble(),
                        interval: getMaxOtherUsersList()[0] / 4 ,
                        labelStyle: TextStyle(
                            color: themChange.getDarkTheme()
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                    series: <CartesianSeries>[
                      BarSeries<CategoryData, String>(
                        dataSource: _charData,
                        xValueMapper: (CategoryData data, _) =>
                        data.continent,
                        yValueMapper: (CategoryData data, _) =>
                        data.gdp,
                        name: '${S.of(context).categoryChart}',
                        dataLabelSettings: DataLabelSettings(
                          showCumulativeValues: true,
                          useSeriesColor: true,

                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Text(
                                      '${S.of(context).mostCategory}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Divider(),
                                    new CircularPercentIndicator(
                                      radius: 80.0,
                                      lineWidth: 10.0,
                                      animation: true,
                                      percent: ((getMaxOtherUsersList()[0] /
                                          percent)),
                                      center: new Text(
                                        "${((getMaxOtherUsersList()[0] / percent) * 100).toInt()}%",
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white),
                                      ),
                                      footer: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: currentLang == 'ar'
                                            ? Text(
                                                "${arabicOthersExpensescounters[getMaxOtherUsersList()[0]]}",
                                                style: new TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.white),
                                              )
                                            : Text(
                                                "${othersExpensescounters[getMaxOtherUsersList()[0]]}",
                                                style: new TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.white),
                                              ),
                                      ),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xff01937C),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                            ),
                            VerticalDivider(
                              color: themChange.getDarkTheme()
                                  ? Colors.white
                                  : Colors.black,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Text(
                                      '${S.of(context).leastCategory}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Divider(),
                                    new CircularPercentIndicator(
                                      radius: 80.0,
                                      lineWidth: 10.0,
                                      animation: true,
                                      percent: ((getMaxOtherUsersList()[2] /
                                          percent)),
                                      center: new Text(
                                        "${((getMaxOtherUsersList()[2] / percent) * 100).toInt()}%",
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                      footer: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: currentLang == 'ar'
                                            ? Text(
                                                "${arabicOthersExpensescounters[getMaxOtherUsersList()[2]]}",
                                                style: new TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.white),
                                              )
                                            : Text(
                                                "${othersExpensescounters[getMaxOtherUsersList()[2]]}",
                                                style: new TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.white),
                                              ),
                                      ),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xff01937C),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
                color: themChange.getDarkTheme() ? Colors.white : Colors.black,
                indent: 30,
                endIndent: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 400,
                  child: SfCartesianChart(
                    legend: Legend(
                      position: LegendPosition.top,
                        isVisible: true,
                        textStyle: TextStyle(
                            color: themChange.getDarkTheme()
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold)),
                    title: ChartTitle(
                        text: '${S.of(context).masaryfyAverageUsersCatefories}',
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: themChange.getDarkTheme()
                                ? Colors.white
                                : Colors.black)),
                    primaryXAxis: CategoryAxis(
                        labelStyle: TextStyle(
                            color: themChange.getDarkTheme()
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                    primaryYAxis: NumericAxis(
                        minimum: 0,
                        maximum: maxUser > maxOther ? maxUser : maxOther,
                        interval: maxUser == 0 ? maxOther / 2 : maxUser / 2,
                        labelStyle: TextStyle(
                            color: themChange.getDarkTheme()
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                    series: <CartesianSeries>[
                      BarSeries<avgCategoryData, String>(
                        dataSource: _avgcharData,
                        xValueMapper: (avgCategoryData data, _) =>
                            data.expenseName,
                        yValueMapper: (avgCategoryData data, _) =>
                            data.otherUserstotalAmount,
                        name: '${S.of(context).avgExpense}',
                        dataLabelSettings: DataLabelSettings(
                          showCumulativeValues: true,
                          useSeriesColor: true,
                        ),
                      ),
                      BarSeries<avgCategoryData, String>(
                        dataSource: _avgcharData,
                        xValueMapper: (avgCategoryData data, _) =>
                            data.expenseName,
                        yValueMapper: (avgCategoryData data, _) =>
                            data.myTotalAmount,
                        name: '${S.of(context).yourExpense}',
                        dataLabelSettings: DataLabelSettings(
                          showCumulativeValues: true,
                          useSeriesColor: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Text(
                                    '${S.of(context).mostAvgCategory}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                  Divider(),
                                  currentLang == 'ar'
                                      ? Text(
                                          '${arabicAvgOthersExpensescountersString[maxOther]}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        )
                                      : Text(
                                          '${avgOthersExpensescountersString[maxOther]}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    '${maxOther.toStringAsFixed(2)} ${S.of(context).perUser}',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xff01937C),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                          ),
                          SizedBox(width: 10),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Text(
                                    '${S.of(context).yourMostCategory}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                  Divider(),
                                  currentLang == 'ar'
                                      ? Text(
                                          '${arabicMaxUserExpense[maxUser]}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        )
                                      : Text(
                                          '${maxUserExpense[maxUser]}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    '${S.of(context).total} $maxUser',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xff01937C),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
                color: themChange.getDarkTheme() ? Colors.white : Colors.black,
                indent: 20,
                endIndent: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 300,
                  child: SfCartesianChart(
                    legend: Legend(
                      position: LegendPosition.top,
                        isVisible: true,
                        textStyle: TextStyle(
                            color: themChange.getDarkTheme()
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold)),
                    title: ChartTitle(
                        text: '${S.of(context).masarifiUserDaily}',
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: themChange.getDarkTheme()
                                ? Colors.white
                                : Colors.black)),
                    primaryXAxis: CategoryAxis(
                        labelStyle: TextStyle(
                            color: themChange.getDarkTheme()
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                    primaryYAxis: NumericAxis(
                        minimum: 0,
                        maximum: getMaxDailyExpenseCount()[0].toDouble(),
                        interval: getMaxDailyExpenseCount()[0] / 4.0,
                        labelStyle: TextStyle(
                            color: themChange.getDarkTheme()
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                    series: <CartesianSeries>[
                      BarSeries<avgDayData, String>(
                        dataSource: _dayData,
                        xValueMapper: (avgDayData data, _) => data.dayName,
                        yValueMapper: (avgDayData data, _) => data.dayAmount,
                        name: '${S.of(context).dailyExpense}',
                        dataLabelSettings: DataLabelSettings(
                          showCumulativeValues: true,
                          useSeriesColor: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 2,
                color: themChange.getDarkTheme() ? Colors.white : Colors.black,
                indent: 20,
                endIndent: 20,
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Text(
                                    '${S.of(context).bestDay}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                  Divider(),
                                  new CircularPercentIndicator(
                                    radius: 80.0,
                                    lineWidth: 10.0,
                                    animation: true,
                                    percent: ((getMaxDailyExpenseCount()[0] /
                                        percentDaily)),
                                    center: Text(
                                      "${((getMaxDailyExpenseCount()[0] / percentDaily) * 100).toInt()}%",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          color: Colors.white),
                                    ),
                                    footer: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:  currentLang == "ar" ? Text(
                                        "${arabicDailyExpenseCount[getMaxDailyExpenseCount()[0]]}",
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white),
                                      ) : Text(
                                        "${dailyExpenseCount[getMaxDailyExpenseCount()[0]]}",
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white),
                                      ),
                                    ),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xff01937C),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Text(
                                    '${S.of(context).lowestDay}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                  Divider(),
                                  new CircularPercentIndicator(
                                    radius: 80.0,
                                    lineWidth: 10.0,
                                    animation: true,
                                    percent: ((getMaxDailyExpenseCount()[2] /
                                        percentDaily)),
                                    center:  Text(
                                      "${((getMaxDailyExpenseCount()[2] / percentDaily) * 100).toInt()}%",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          color: Colors.white),
                                    ),
                                    footer: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: currentLang == "ar" ? Text(
                                        "${arabicDailyExpenseCount[getMaxDailyExpenseCount()[2]]}",
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white),
                                      ) :  Text(
                                        "${dailyExpenseCount[getMaxDailyExpenseCount()[2]]}",
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white),
                                      ),
                                    ),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xff01937C),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
                color: themChange.getDarkTheme() ? Colors.white : Colors.black,
                endIndent: 20,
                indent: 20,
              ),
              Container(
                height: 600,
                width: 300,
                child: SfCartesianChart(
                  legend: Legend(
                      isVisible: true,
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: themChange.getDarkTheme()
                              ? Colors.white
                              : Colors.black),
                  position: LegendPosition.top),
                  title: ChartTitle(
                      text: '${S.of(context).masarifiMonthly}',
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: themChange.getDarkTheme()
                              ? Colors.white
                              : Colors.black)),
                  primaryXAxis: CategoryAxis(
                      labelStyle: TextStyle(
                          color: themChange.getDarkTheme()
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13)),
                  primaryYAxis: NumericAxis(
                      minimum: 0,
                      maximum: getMaxMonthlyExpenseCount()[0].toDouble(),
                      interval: getMaxMonthlyExpenseCount()[0] / 4.0,
                      labelStyle: TextStyle(
                          color: themChange.getDarkTheme()
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13)),
                  series: <CartesianSeries>[
                    BarSeries<avgMonthData, String>(
                      dataSource: _monthData,
                      xValueMapper: (avgMonthData data, _) => data.monthName,
                      yValueMapper: (avgMonthData data, _) => data.monthAmount,
                      name: '${S.of(context).monthlyExpense}',
                      dataLabelSettings: DataLabelSettings(
                        showCumulativeValues: true,
                        useSeriesColor: true,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
                color: Colors.white,
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Text(
                                    '${S.of(context).bestMonth}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                  Divider(),
                                  new CircularPercentIndicator(
                                    radius: 80.0,
                                    lineWidth: 10.0,
                                    animation: true,
                                    percent: ((getMaxMonthlyExpenseCount()[0] /
                                        percentMonthly)),
                                    center: new Text(
                                      "${((getMaxMonthlyExpenseCount()[0] / percentMonthly) * 100).toInt()}%",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          color: Colors.white),
                                    ),
                                    footer: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: currentLang == "ar"
                                          ? Text(
                                              "${arabicMonthlyExpenseCount[getMaxMonthlyExpenseCount()[0]]}",
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                  color: Colors.white),
                                            )
                                          : Text(
                                              "${monthlyExpenseCount[getMaxMonthlyExpenseCount()[0]]}",
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                  color: Colors.white),
                                            ),
                                    ),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xff01937C),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Text(
                                    '${S.of(context).lowestMonth}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                  Divider(),
                                  new CircularPercentIndicator(
                                    radius: 80.0,
                                    lineWidth: 10.0,
                                    animation: true,
                                    percent: ((getMaxMonthlyExpenseCount()[2] /
                                        percentMonthly)),
                                    center: new Text(
                                      "${((getMaxMonthlyExpenseCount()[2] / percentMonthly) * 100).toInt()}%",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          color: Colors.white),
                                    ),
                                    footer: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: currentLang == "ar"?  Text(
                                        "${arabicMonthlyExpenseCount[getMaxMonthlyExpenseCount()[2]]}",
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white),
                                      )
                                          :
                                      Text(
                                        "${monthlyExpenseCount[getMaxMonthlyExpenseCount()[2]]}",
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.white),
                                      ),

                                    ),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xff01937C),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
