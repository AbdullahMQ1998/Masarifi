import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';



class avgMonthData {
  final String monthName;
  final int monthAmount;

  avgMonthData(this.monthName,this.monthAmount);
}


int januaryCounter ;
int februaryCounter  ;
int marchCounter ;
int aprilCounter ;
int mayCounter ;
int juneCounter ;
int julyCounter ;
int augustCounter ;
int septemberCounter;
int octoberCounter ;
int novemberCounter;
int decemberCounter;


List<avgMonthData> getMonthChartData(String currentLang) {

  if(currentLang == 'ar'){

    final List<avgMonthData> arabicChartData = [
      avgMonthData('يناير',januaryCounter),
      avgMonthData('فبراير',februaryCounter),
      avgMonthData('مارس',marchCounter),
      avgMonthData('أبريل',aprilCounter),
      avgMonthData('ماي',mayCounter),
      avgMonthData('يونيو',juneCounter),
      avgMonthData('يوليو',julyCounter),
      avgMonthData('أغسطس',augustCounter),
      avgMonthData('سبتمبر',septemberCounter),
      avgMonthData('أكتوبر',octoberCounter),
      avgMonthData('نوفمبر',novemberCounter),
      avgMonthData('ديسمبر',decemberCounter),
    ];
    return arabicChartData;

  }

  final List<avgMonthData> chartData = [
    avgMonthData('January',januaryCounter),
    avgMonthData('February',februaryCounter),
    avgMonthData('March',marchCounter),
    avgMonthData('April',aprilCounter),
    avgMonthData('May',mayCounter),
    avgMonthData('June',juneCounter),
    avgMonthData('July',julyCounter),
    avgMonthData('August',augustCounter),
    avgMonthData('September',septemberCounter),
    avgMonthData('October',octoberCounter),
    avgMonthData('November',novemberCounter),
    avgMonthData('December',decemberCounter),
  ];
  return chartData;
}





Map<int , String> monthlyExpenseCount;
Map<int , String> arabicMonthlyExpenseCount;
Map<String , int> maxMonthlyExpenseCount;

int percentMonthly = 1;


Timestamp expenseDate;


void getOtherUsersMonth(List<QueryDocumentSnapshot> otherUsersExpense) {

  januaryCounter  = 0;
   februaryCounter  = 0;
   marchCounter  = 0;
   aprilCounter  = 0;
   mayCounter  = 0;
   juneCounter  = 0;
   julyCounter  = 0;
   augustCounter  = 0;
   septemberCounter  = 0;
   octoberCounter  = 0;
   novemberCounter  = 0;
   decemberCounter  = 0;


  DateTime currentMonth = DateTime.now();

  Map<String,String> monthTranslate =  {

    "يناير": "January",
    "فبراير": "February",
    "مارس": "March",
    "أبريل": "April",
    "مايو" : "May",
    "يونيو": "June",
    "يوليو": "July",
    "أغسطس" : "August",
    "سبتمبر": "September",
    "أكتوبر":"October",
    "نوفمبر": "November",
    "ديسمبر" : "December",
  };

  for(int i = 0 ; i < otherUsersExpense.length ; i++){
    expenseDate = otherUsersExpense[i].get('expenseDate');
    currentMonth = DateTime.parse(expenseDate.toDate().toString());



    if(DateFormat('MMMM').format(currentMonth) == 'January' || DateFormat('MMMM').format(currentMonth) == 'يناير' ){
      januaryCounter++;
    }
    if(DateFormat('MMMM').format(currentMonth) == 'February' || DateFormat('MMMM').format(currentMonth) == 'فبراير'){
      februaryCounter++;
    }
    if(DateFormat('MMMM').format(currentMonth) == 'March' || DateFormat('MMMM').format(currentMonth) == 'مارس'){
      marchCounter++;
    }
    if(DateFormat('MMMM').format(currentMonth) == 'April' || DateFormat('MMMM').format(currentMonth) == 'أبريل'){
      aprilCounter++;
    } if(DateFormat('MMMM').format(currentMonth) == 'May' || DateFormat('MMMM').format(currentMonth) == 'مايو'){
      mayCounter++;
    } if(DateFormat('MMMM').format(currentMonth) == 'June' || DateFormat('MMMM').format(currentMonth) == 'يونيو'){
      juneCounter++;
    } if(DateFormat('MMMM').format(currentMonth) == 'July' || DateFormat('MMMM').format(currentMonth) == "يوليو"){
      julyCounter++;
    }

    if(DateFormat('MMMM').format(currentMonth) == 'August' || DateFormat('MMMM').format(currentMonth) == 'أغسطس'){
      augustCounter++;
    }
    if(DateFormat('MMMM').format(currentMonth) == 'September' || DateFormat('MMMM').format(currentMonth) == 'سبتمبر'){
      septemberCounter++;
    }if(DateFormat('MMMM').format(currentMonth) == 'October' || DateFormat('MMMM').format(currentMonth) == 'أكتوبر'){
      octoberCounter++;
    }
    if(DateFormat('MMMM').format(currentMonth) == 'November' || DateFormat('MMMM').format(currentMonth) == 'نوفمبر'){
      novemberCounter++;
    }
    if(DateFormat('MMMM').format(currentMonth) == 'December' || DateFormat('MMMM').format(currentMonth) == 'ديسمبر'){
      decemberCounter++;
    }



  }

  maxMonthlyExpenseCount = {
    'January': januaryCounter ,
    'February' : februaryCounter,
    'March': marchCounter,
    'April':aprilCounter,
    'May': mayCounter ,
    'June':juneCounter,
    'July': julyCounter,
    'August': augustCounter ,
    'September' : septemberCounter,
    'October': octoberCounter,
    'November':novemberCounter,
    'December': decemberCounter ,
  };


  monthlyExpenseCount = {
    januaryCounter :'January',
    februaryCounter : 'February',
    marchCounter:'March',
    aprilCounter :'April',
    mayCounter : 'May',
    juneCounter :'June',
    julyCounter: 'July',
    augustCounter :'August',
    septemberCounter : 'September',
    octoberCounter:'October',
    novemberCounter :'November',
    decemberCounter : 'December',
  };

  arabicMonthlyExpenseCount = {
    januaryCounter :'يناير',
    februaryCounter : 'فبراير',
    marchCounter:'مارس',
    aprilCounter :'أبريل',
    mayCounter : 'ماي',
    juneCounter :'يونيو',
    julyCounter: 'يوليو',
    augustCounter :'أغسطس',
    septemberCounter : 'سبتمبر',
    octoberCounter:'أكتوبر',
    novemberCounter :'نوفمبر',
    decemberCounter : 'ديسمبر',
  };

}



List<int> getMaxMonthlyExpenseCount(){
  List<int> sort = [];
  int max  = 0;


  max = januaryCounter;
  int secondBest = 0;
  secondBest = max;


  int lowest = 0;
  lowest = januaryCounter;

  int total = 0;


  for(int i = 0 ; i < maxMonthlyExpenseCount.length ; i++){

    total +=maxMonthlyExpenseCount.values.elementAt(i);

    if(max< maxMonthlyExpenseCount.values.elementAt(i)){
      secondBest = max;
      max = maxMonthlyExpenseCount.values.elementAt(i);
    }

    if(lowest > maxMonthlyExpenseCount.values.elementAt(i)){
      lowest = maxMonthlyExpenseCount.values.elementAt(i);
    }

  }

  sort.add(max);
  sort.add(secondBest);
  sort.add(lowest);
  percentMonthly = total;

  return sort;
}

