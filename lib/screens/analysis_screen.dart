import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:collection';

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

  int userResturantCounter;
  int userShoppingCounter;
  int userGasCounter;
  int userCoffeCounter;
  int userFinanceCounter;
  int userGroceryCounter;
  int userFurnitureCounter;
  int userHealthCounter;
  int userEntertainmentCounter;
  int userOnlineShoppingCounter;
  int userEducationCounter;



  int resturantCounter;
  int shoppingCounter;
  int gasCounter;
  int coffeCounter;
  int financeCounter;
  int groceryCounter;
  int furnitureCounter;
  int healthCounter;
  int entertainmentCounter;
  int onlineShoppingCounter;
  int educationCounter;


  double avgRestaurant = 0;
  double avgGas = 0;
  double avgShopping = 0;
  double avgCoffee = 0;
  double avgFurniture = 0;
  double avgHealth = 0;
  double avgOnlineShopping = 0;
  double avgEducation = 0;
  double avgEntertainment = 0;
  double avgGrocery = 0;
  double avgFinance = 0;



  int percent = 0;


  var userSortedCounter;
  var othersSortedCounter;

  Map<String , int> userExpenseCounter;
  double maxUser = 0;


  Map<int , String> othersExpensescounters;
  Map<String , int> maxOtherExpenserList;


  Map<String , double> avgOthersExpensescounters;
  double maxOther = 0;


  List<CategoryData> _charData;
  List<avgCategoryData> _avgcharData;

  @override
  void initState() {
    getCatagoryInfo();
    getUserCategoryInfo();
    getMaxOtherUsersList();
    _charData = getChartData();
    _avgcharData = getAvgChartData();
    super.initState();
  }

  void getCatagoryInfo() {
    resturantCounter = 0;
    shoppingCounter = 0;
    gasCounter = 0;
    coffeCounter = 0;
    financeCounter = 0;
    groceryCounter = 0;
    furnitureCounter = 0;
    healthCounter = 0;
    entertainmentCounter = 0;
    onlineShoppingCounter = 0;
    educationCounter = 0;

    for (int i = 0; i < widget.otherUsersExpense.length; i++) {
      if (widget.otherUsersExpense[i].get('expenseIcon') == 'Restaurants') {
        resturantCounter++;

      }
      if (widget.otherUsersExpense[i].get('expenseIcon') == 'Gas') {
        gasCounter++;
      }

      if (widget.otherUsersExpense[i].get('expenseIcon') == 'Shopping') {
        shoppingCounter++;
      }
      if (widget.otherUsersExpense[i].get('expenseIcon') == 'Coffee') {
        coffeCounter++;
      }
      if (widget.otherUsersExpense[i].get('expenseIcon') == 'Finance') {
        financeCounter++;
      }
      if (widget.otherUsersExpense[i].get('expenseIcon') == 'Grocery') {
        groceryCounter++;
      }
      if (widget.otherUsersExpense[i].get('expenseIcon') == 'Furniture') {
        furnitureCounter++;
      }
      if (widget.otherUsersExpense[i].get('expenseIcon') == 'Health') {
        healthCounter++;
      }
      if (widget.otherUsersExpense[i].get('expenseIcon') == 'Entertainment') {
        entertainmentCounter++;
      }
      if (widget.otherUsersExpense[i].get('expenseIcon') == 'Online-Shopping') {
        onlineShoppingCounter++;
      }
      if (widget.otherUsersExpense[i].get('expenseIcon') == 'Education') {
        educationCounter++;
      }


    }





    maxOtherExpenserList = {
      'Restaurants': resturantCounter ,
       'Shopping' : shoppingCounter,
      'Gas': gasCounter,
        'Coffee':coffeCounter,
       'Finance': financeCounter ,
       'Grocery':groceryCounter,
      'Furniture': furnitureCounter,
      'Health' : healthCounter ,
      'Online-Shopping':onlineShoppingCounter ,
    'Entertainment': entertainmentCounter ,
      'Education': educationCounter
    };


    othersExpensescounters = {
      resturantCounter :'Restaurants',
      shoppingCounter : 'Shopping',
      gasCounter:'Gas',
      coffeCounter:'Coffee',
      financeCounter : 'Finance',
      groceryCounter :'Grocery',
      furnitureCounter: 'Furniture',
      healthCounter :'Health' ,
      onlineShoppingCounter :'Online-Shopping',
      entertainmentCounter: 'Entertainment',
      educationCounter: 'Education',
    };


    avgRestaurant = resturantCounter / widget.otherUsersInfo.length;
    avgGas = gasCounter / widget.otherUsersInfo.length;
    avgShopping = shoppingCounter / widget.otherUsersInfo.length;
    avgCoffee = coffeCounter / widget.otherUsersInfo.length;
    avgFurniture = furnitureCounter / widget.otherUsersInfo.length;
    avgHealth = healthCounter / widget.otherUsersInfo.length;
    avgOnlineShopping = onlineShoppingCounter / widget.otherUsersInfo.length;
    avgEducation = educationCounter / widget.otherUsersInfo.length;
    avgEntertainment = entertainmentCounter / widget.otherUsersInfo.length;
    avgGrocery = groceryCounter / widget.otherUsersInfo.length;
    avgFinance = financeCounter / widget.otherUsersInfo.length;

    avgOthersExpensescounters = {
      'Restaurants' : avgRestaurant,
      'Shopping' : avgShopping,
      'Gas': avgGas,
      'Coffee': avgCoffee,
      'Finance': avgFinance,
      'Grocery': avgGrocery,
      'Furniture': avgFurniture,
      'Health' : avgHealth,
      'Online-Shopping': avgOnlineShopping,
      'Entertainment': avgEntertainment,
      'Education': avgEntertainment
    };


    var sortedKeys = avgOthersExpensescounters.keys.toList(growable:true)
      ..sort((k1, k2) => avgOthersExpensescounters[k1].compareTo(avgOthersExpensescounters[k2]));
    LinkedHashMap sortedMap = new LinkedHashMap
        .fromIterable(sortedKeys, key: (k) => k, value: (k) => avgOthersExpensescounters[k]);

    othersSortedCounter = sortedKeys;

    maxOther = avgOthersExpensescounters[othersSortedCounter[othersSortedCounter.length - 1]].toDouble();


  }

  void getUserCategoryInfo(){

    userResturantCounter = 0;
    userShoppingCounter = 0;
    userGasCounter = 0;
    userCoffeCounter = 0;
    userFinanceCounter = 0;
    userGroceryCounter = 0;
    userFurnitureCounter = 0;
    userHealthCounter = 0;
    userEntertainmentCounter = 0;
    userOnlineShoppingCounter = 0;
    userEducationCounter = 0;


    for (int i = 0; i < widget.userExpenseList.length; i++) {
      if (widget.userExpenseList[i].get('expenseIcon') == 'Restaurants') {
        userResturantCounter++;
      }
      if (widget.userExpenseList[i].get('expenseIcon') == 'Gas') {
        userGasCounter++;
      }

      if (widget.userExpenseList[i].get('expenseIcon') == 'Shopping') {
        userShoppingCounter++;
      }
      if (widget.userExpenseList[i].get('expenseIcon') == 'Coffee') {
        userCoffeCounter++;
      }
      if (widget.userExpenseList[i].get('expenseIcon') == 'Finance') {
        userFinanceCounter++;
      }
      if (widget.userExpenseList[i].get('expenseIcon') == 'Grocery') {
        userGroceryCounter++;
      }
      if (widget.userExpenseList[i].get('expenseIcon') == 'Furniture') {
        userFurnitureCounter++;
      }
      if (widget.userExpenseList[i].get('expenseIcon') == 'Health') {
        userHealthCounter++;
      }
      if (widget.userExpenseList[i].get('expenseIcon') == 'Entertainment') {
        userEntertainmentCounter++;
      }
      if (widget.userExpenseList[i].get('expenseIcon') == 'Online-Shopping') {
        userOnlineShoppingCounter++;
      }
      if (widget.userExpenseList[i].get('expenseIcon') == 'Education') {
        userEducationCounter++;
      }

    }

    userExpenseCounter = {
      'Restaurants' : userResturantCounter,
      'Shopping' : userShoppingCounter,
      'Gas': userGasCounter,
      'Coffee': userCoffeCounter,
      'Finance': userFinanceCounter,
      'Grocery': userGroceryCounter,
      'Furniture': userFurnitureCounter,
      'Health' : userHealthCounter,
      'Online-Shopping': userOnlineShoppingCounter,
      'Entertainment': userEntertainmentCounter,
      'Education': userEducationCounter
    };


    var sortedKeys = userExpenseCounter.keys.toList(growable:false)
      ..sort((k1, k2) => userExpenseCounter[k1].compareTo(userExpenseCounter[k2]));
    LinkedHashMap sortedMap = new LinkedHashMap
        .fromIterable(sortedKeys, key: (k) => k, value: (k) => userExpenseCounter[k]);


    userSortedCounter = sortedKeys;

    maxUser = userExpenseCounter[userSortedCounter[userExpenseCounter.length - 1]].toDouble();

  }


  List<int> getMaxOtherUsersList(){
    List<int> sort = [];
    int max  = 0;


    max = resturantCounter;
    int secondBest = 0;
    secondBest = max;


    int lowest =0;
    lowest = resturantCounter;

    int total = 0;


    for(int i = 0 ; i < maxOtherExpenserList.length ; i++){

      total += maxOtherExpenserList.values.elementAt(i);
      if(max< maxOtherExpenserList.values.elementAt(i)){
        secondBest = max;
        max = maxOtherExpenserList.values.elementAt(i);
      }

      if(lowest > maxOtherExpenserList.values.elementAt(i)){
        lowest = maxOtherExpenserList.values.elementAt(i);
      }

    }

    sort.add(max);
    sort.add(secondBest);
    sort.add(lowest);
    percent = total;

    return sort;

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
                    primaryYAxis: NumericAxis(minimum: 0 , maximum: maxUser > maxOther? maxUser : maxOther , interval: maxUser / 2),
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


              ],
            ),
          ]
        ),
      ),
    );
  }

  List<CategoryData> getChartData() {
    final List<CategoryData> chartData = [
      CategoryData('Restaurants', resturantCounter, Colors.red),
      CategoryData('Gas', gasCounter, Colors.blue),
      CategoryData('Shopping', shoppingCounter, Colors.yellow),
      CategoryData('Coffee', coffeCounter, Colors.green),
      CategoryData('Finance', financeCounter, Colors.pink),
      CategoryData('Grocery', groceryCounter, Colors.brown),
      CategoryData('Furniture', furnitureCounter, Colors.deepOrange),
      CategoryData('Health', healthCounter, Colors.indigo),
      CategoryData('Entertainment', entertainmentCounter, Colors.cyan),
      CategoryData('Online Shopping', onlineShoppingCounter, Colors.redAccent),
      CategoryData('Education', educationCounter, Colors.greenAccent),
    ];
    return chartData;
  }



  List<avgCategoryData> getAvgChartData() {
    final List<avgCategoryData> chartData = [
      avgCategoryData('Restaurants', avgRestaurant, userResturantCounter, Colors.red , Colors.black),
      avgCategoryData('Gas', avgGas, userGasCounter,Colors.blue , Colors.black),
      avgCategoryData('Shopping', avgShopping,userShoppingCounter, Colors.yellow,Colors.black),
      avgCategoryData('Coffee', avgCoffee, userCoffeCounter, Colors.green,Colors.black),
      avgCategoryData('Finance', avgFinance,userFinanceCounter, Colors.pink, Colors.black),
      avgCategoryData('Grocery', avgGrocery,userGroceryCounter, Colors.brown, Colors.black),
      avgCategoryData('Furniture', avgFurniture,userFurnitureCounter, Colors.deepOrange, Colors.black),
      avgCategoryData('Health', avgHealth,userHealthCounter, Colors.indigo, Colors.black),
      avgCategoryData('Entertainment', avgEntertainment,userEntertainmentCounter, Colors.cyan, Colors.black),
     avgCategoryData('Online Shopping', avgOnlineShopping,userOnlineShoppingCounter, Colors.redAccent, Colors.black),
     avgCategoryData('Education',avgEducation,userEducationCounter, Colors.greenAccent, Colors.black),
    ];
    return chartData;
  }
}






class CategoryData {
  final String continent;
  final int gdp;
  final Color color;
  CategoryData(this.continent, this.gdp, this.color);
}



class avgCategoryData {
  final String expenseName;
  final double otherUserstotalAmount;
  final int myTotalAmount;
  final Color color;
  final Color userColor;
  avgCategoryData(this.expenseName, this.otherUserstotalAmount,this.myTotalAmount, this.color,this.userColor);
}
