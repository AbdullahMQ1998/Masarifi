import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:collection';

import 'package:shared_preferences/shared_preferences.dart';



SharedPreferences preferences;

String currentLang;



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


var userSortedCounter;
var othersSortedCounter;

Map<String , int> userExpenseCounter;
Map<int , String> maxUserExpense;
Map<int , String> arabicMaxUserExpense;
double maxUser = 0;


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




Map<String , int> maxOtherExpenserList;
Map<int , String> othersExpensescounters;
Map<int , String> arabicOthersExpensescounters;

Map<String , double> avgOthersExpensescounters;
Map<double , String> avgOthersExpensescountersString;
Map<double , String> arabicAvgOthersExpensescountersString;
double maxOther = 0;


int percent = 0;


//this class is for the first chart (pie)


class CategoryData {
  final String continent;
  final int gdp;
  final Color color;
  CategoryData(this.continent, this.gdp, this.color);

}



List<CategoryData> getChartData(String currentLang) {


  if(currentLang == 'ar'){
    final List<CategoryData> arabicChartData = [
      CategoryData('مطاعم', resturantCounter, Colors.red),
      CategoryData('بنزين', gasCounter, Colors.blue),
      CategoryData('تسوق', shoppingCounter, Colors.yellow),
      CategoryData('قهوة', coffeCounter, Colors.green),
      CategoryData('مالية', financeCounter, Colors.pink),
      CategoryData('بقالة', groceryCounter, Colors.brown),
      CategoryData('أثاث', furnitureCounter, Colors.deepOrange),
      CategoryData('صحة', healthCounter, Colors.indigo),
      CategoryData('ترفيه', entertainmentCounter, Colors.cyan),
      CategoryData('تسوق إلكتروني', onlineShoppingCounter, Colors.redAccent),
      CategoryData('تعليم', educationCounter, Colors.greenAccent),
    ];
    return arabicChartData;
  }

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


List<avgCategoryData> getAvgChartData(String currentLang) {


  if(currentLang == 'ar'){
    final List<avgCategoryData> arabicChartData = [
      avgCategoryData('مطاعم', avgRestaurant, userResturantCounter),
      avgCategoryData('بنزين',avgGas, userGasCounter),
      avgCategoryData('تسوق',avgShopping,userShoppingCounter),
      avgCategoryData('قهوة', avgCoffee, userCoffeCounter),
      avgCategoryData('مالية', avgFinance,userFinanceCounter),
      avgCategoryData('بقالة',avgGrocery,userGroceryCounter),
      avgCategoryData('أثاث', avgFurniture,userFurnitureCounter),
      avgCategoryData('صحة', avgHealth,userHealthCounter),
      avgCategoryData('ترفيه', avgEntertainment,userEntertainmentCounter),
      avgCategoryData('تسوق إلكتروني',avgOnlineShopping,userOnlineShoppingCounter),
      avgCategoryData('تعليم', avgEducation,userEducationCounter),
    ];
    return arabicChartData;
  }

  final List<avgCategoryData> chartData = [
    avgCategoryData('Restaurants', avgRestaurant, userResturantCounter),
    avgCategoryData('Gas', avgGas, userGasCounter),
    avgCategoryData('Shopping', avgShopping,userShoppingCounter),
    avgCategoryData('Coffee', avgCoffee, userCoffeCounter),
    avgCategoryData('Finance', avgFinance,userFinanceCounter),
    avgCategoryData('Grocery', avgGrocery,userGroceryCounter),
    avgCategoryData('Furniture', avgFurniture,userFurnitureCounter),
    avgCategoryData('Health', avgHealth,userHealthCounter),
    avgCategoryData('Entertainment', avgEntertainment,userEntertainmentCounter),
    avgCategoryData('Online Shopping', avgOnlineShopping,userOnlineShoppingCounter),
    avgCategoryData('Education',avgEducation,userEducationCounter),
  ];
  return chartData;
}



//this class is for the second chart
class avgCategoryData {
  final String expenseName;
  final double otherUserstotalAmount;
  final int myTotalAmount;
  avgCategoryData(this.expenseName, this.otherUserstotalAmount,this.myTotalAmount,);
}















void getCatagoryInfo(List<QueryDocumentSnapshot> otherUsersExpense , List<QueryDocumentSnapshot> otherUsersInfo) {
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






  for (int i = 0; i < otherUsersExpense.length; i++) {
    if (otherUsersExpense[i].get('expenseIcon') == 'Restaurants') {
      resturantCounter++;

    }
    if (otherUsersExpense[i].get('expenseIcon') == 'Gas') {
      gasCounter++;
    }

    if (otherUsersExpense[i].get('expenseIcon') == 'Shopping') {
      shoppingCounter++;
    }
    if (otherUsersExpense[i].get('expenseIcon') == 'Coffee') {
      coffeCounter++;
    }
    if (otherUsersExpense[i].get('expenseIcon') == 'Finance') {
      financeCounter++;
    }
    if (otherUsersExpense[i].get('expenseIcon') == 'Grocery') {
      groceryCounter++;
    }
    if (otherUsersExpense[i].get('expenseIcon') == 'Furniture') {
      furnitureCounter++;
    }
    if (otherUsersExpense[i].get('expenseIcon') == 'Health') {
      healthCounter++;
    }
    if (otherUsersExpense[i].get('expenseIcon') == 'Entertainment') {
      entertainmentCounter++;
    }
    if (otherUsersExpense[i].get('expenseIcon') == 'Online-Shopping') {
      onlineShoppingCounter++;
    }
    if (otherUsersExpense[i].get('expenseIcon') == 'Education') {
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

  arabicOthersExpensescounters = {

    resturantCounter :'مطاعم',
    shoppingCounter : 'تسوق',
    gasCounter:'بنزين',
    coffeCounter:'قهوة',
    financeCounter : 'مالية',
    groceryCounter :'بقالة',
    furnitureCounter: 'أثاث',
    healthCounter :'صحة' ,
    onlineShoppingCounter :'تسوق إلكتروني',
    entertainmentCounter: 'ترفيه',
    educationCounter: 'تعليم',
  };


  avgRestaurant = resturantCounter / otherUsersInfo.length;
  avgGas = gasCounter / otherUsersInfo.length;
  avgShopping = shoppingCounter / otherUsersInfo.length;
  avgCoffee = coffeCounter / otherUsersInfo.length;
  avgFurniture = furnitureCounter / otherUsersInfo.length;
  avgHealth = healthCounter / otherUsersInfo.length;
  avgOnlineShopping = onlineShoppingCounter / otherUsersInfo.length;
  avgEducation = educationCounter / otherUsersInfo.length;
  avgEntertainment = entertainmentCounter / otherUsersInfo.length;
  avgGrocery = groceryCounter / otherUsersInfo.length;
  avgFinance = financeCounter / otherUsersInfo.length;

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

  avgOthersExpensescountersString = {
     avgRestaurant:'Restaurants',
   avgShopping : 'Shopping',
    avgGas : 'Gas',
     avgCoffee:'Coffee',
    avgFinance :'Finance',
    avgGrocery: 'Grocery',
   avgFurniture:  'Furniture',
    avgHealth  :'Health',
   avgOnlineShopping: 'Online-Shopping',
    avgEntertainment :'Entertainment',
    avgEntertainment :'Education'
  };


  arabicAvgOthersExpensescountersString = {
    avgRestaurant:"مطاعم",
    avgShopping : 'تسوق',
    avgGas : 'بنزين',
    avgCoffee:'قهوة',
    avgFinance :'مالية',
    avgGrocery: 'بقالة',
    avgFurniture:'أثاث',
    avgHealth  :'صحة',
    avgOnlineShopping: 'تسوق إلكتروني',
    avgEntertainment :'ترفيه',
    avgEntertainment :'تعليم'
  };


  var sortedKeys = avgOthersExpensescounters.keys.toList(growable:true)
    ..sort((k1, k2) => avgOthersExpensescounters[k1].compareTo(avgOthersExpensescounters[k2]));
  LinkedHashMap sortedMap = new LinkedHashMap
      .fromIterable(sortedKeys, key: (k) => k, value: (k) => avgOthersExpensescounters[k]);

  othersSortedCounter = sortedKeys;

  maxOther = avgOthersExpensescounters[othersSortedCounter[othersSortedCounter.length - 1]].toDouble();


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



void getUserCategoryInfo(List<QueryDocumentSnapshot> userExpenseList ){

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


  for (int i = 0; i < userExpenseList.length; i++) {
    if (userExpenseList[i].get('expenseIcon') == 'Restaurants') {
      userResturantCounter++;
    }
    if (userExpenseList[i].get('expenseIcon') == 'Gas') {
      userGasCounter++;
    }

    if (userExpenseList[i].get('expenseIcon') == 'Shopping') {
      userShoppingCounter++;
    }
    if (userExpenseList[i].get('expenseIcon') == 'Coffee') {
      userCoffeCounter++;
    }
    if (userExpenseList[i].get('expenseIcon') == 'Finance') {
      userFinanceCounter++;
    }
    if (userExpenseList[i].get('expenseIcon') == 'Grocery') {
      userGroceryCounter++;
    }
    if (userExpenseList[i].get('expenseIcon') == 'Furniture') {
      userFurnitureCounter++;
    }
    if (userExpenseList[i].get('expenseIcon') == 'Health') {
      userHealthCounter++;
    }
    if (userExpenseList[i].get('expenseIcon') == 'Entertainment') {
      userEntertainmentCounter++;
    }
    if (userExpenseList[i].get('expenseIcon') == 'Online-Shopping') {
      userOnlineShoppingCounter++;
    }
    if (userExpenseList[i].get('expenseIcon') == 'Education') {
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

  maxUserExpense = {
    userResturantCounter:'Restaurants' ,
    userShoppingCounter:'Shopping' ,
    userGasCounter: 'Gas',
 userCoffeCounter: 'Coffee',
   userFinanceCounter:'Finance',
   userGroceryCounter: 'Grocery',
  userFurnitureCounter: 'Furniture',
    userHealthCounter: 'Health' ,
    userOnlineShoppingCounter: 'Online-Shopping',
   userEntertainmentCounter:'Entertainment',
   userEducationCounter : 'Education',
  };

  arabicMaxUserExpense = {
    userResturantCounter:'مطاعم' ,
    userShoppingCounter:'تسوق' ,
    userGasCounter: 'بنزين',
    userCoffeCounter: 'قهوة',
    userFinanceCounter:'مالية',
    userGroceryCounter: 'بقالة',
    userFurnitureCounter: 'أثاث',
    userHealthCounter: 'صحة' ,
    userOnlineShoppingCounter: 'تسوق إلكتروني',
    userEntertainmentCounter:'ترفيه',
    userEducationCounter : 'تعليم',
  };



  var sortedKeys = userExpenseCounter.keys.toList(growable:false)
    ..sort((k1, k2) => userExpenseCounter[k1].compareTo(userExpenseCounter[k2]));
  LinkedHashMap sortedMap = new LinkedHashMap
      .fromIterable(sortedKeys, key: (k) => k, value: (k) => userExpenseCounter[k]);


  userSortedCounter = sortedKeys;

  maxUser = userExpenseCounter[userSortedCounter[userExpenseCounter.length - 1]].toDouble();

}






