import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalysisScreen extends StatefulWidget {
  final QueryDocumentSnapshot userInfo;
  final List<QueryDocumentSnapshot> otherUsersExpense;
  final List<QueryDocumentSnapshot> otherUsersInfo;

  AnalysisScreen(this.userInfo, this.otherUsersExpense, this.otherUsersInfo);

  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
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


  List<CategoryData> _charData;

  @override
  void initState() {
    getCatagoryInfo();
    _charData = getChartData();
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



  }

  void getMostCategory(){

    int max =  resturantCounter;

    for(int i = 0 ; i < 10 ; i++){




    }




  }

  @override
  Widget build(BuildContext context) {
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


    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 200,
              child: SfCircularChart(
                legend: Legend(isVisible: true),
                title: ChartTitle(text: 'Masaryfy Expense Count',textStyle: TextStyle(fontWeight: FontWeight.bold)),
                series: <CircularSeries>[
                  DoughnutSeries<CategoryData,String>(
                    dataSource: _charData,
                    xValueMapper: (CategoryData data, _) => data.continent,
                    yValueMapper: (CategoryData data, _) => data.gdp ,
                    dataLabelSettings: DataLabelSettings(
                      showCumulativeValues: true,
                      useSeriesColor: true
                    ),
                    pointColorMapper: (CategoryData data, _) => data.color,
                  ),
                ],
              ),
            ),
          ],
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
}

class CategoryData {
  final String continent;
  final int gdp;
  final Color color;
  CategoryData(this.continent, this.gdp, this.color);
}
