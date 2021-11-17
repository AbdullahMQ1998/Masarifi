import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class avgDayData {
  final String dayName;
  final int dayAmount;

  avgDayData(this.dayName,this.dayAmount);
}

List<avgDayData> getDayChartData(String currentLang) {

  if(currentLang == 'ar'){
    final List<avgDayData> arabicChartData = [
  avgDayData('الأحد',sundayCounter),
  avgDayData('الإثنين', mondayCounter),
  avgDayData('الثلاثاء', tuesdayCounter),
  avgDayData('الأربعاء', wednesdayCounter),
  avgDayData('الخميس', thursdayCounter),
  avgDayData('الجمعة', fridayCounter),
  avgDayData('السبت', saturdayCounter),
  ];
  return arabicChartData;
  }

  final List<avgDayData> chartData = [
    avgDayData('Sunday',sundayCounter),
    avgDayData('Monday', mondayCounter),
    avgDayData('Tuesday', tuesdayCounter),
    avgDayData('Wednesday', wednesdayCounter),
    avgDayData('Thursday', thursdayCounter),
    avgDayData('Friday', fridayCounter),
    avgDayData('Saturday', saturdayCounter),
  ];
  return chartData;
}







int saturdayCounter  = 0;
int sundayCounter  = 0;
int mondayCounter  = 0;
int tuesdayCounter  = 0;
int wednesdayCounter  = 0;
int thursdayCounter  = 0;
int fridayCounter  = 0;

Timestamp expenseDate;


Map<int , String> dailyExpenseCount;
Map<int , String> arabicDailyExpenseCount;
Map<String , int> maxDailyExpenseCount;

int percentDaily = 1;


void getOtherUsersDay(List<QueryDocumentSnapshot> otherUsersExpense) {


  DateTime currentDay = DateTime.now();

  for(int i = 0 ; i < otherUsersExpense.length ; i++){
    expenseDate = otherUsersExpense[i].get('expenseDate');
    currentDay = DateTime.parse(expenseDate.toDate().toString());
    if(DateFormat('EEEE').format(currentDay) == 'Saturday' || DateFormat('EEEE').format(currentDay) == 'السبت'){
      saturdayCounter++;
    }
    if(DateFormat('EEEE').format(currentDay) == 'Sunday' || DateFormat('EEEE').format(currentDay) == 'الأحد'){
      sundayCounter++;
    }
    if(DateFormat('EEEE').format(currentDay) == 'Monday' || DateFormat('EEEE').format(currentDay) == 'الاثنين'){
      mondayCounter++;
    }
    if(DateFormat('EEEE').format(currentDay) == 'Tuesday' || DateFormat('EEEE').format(currentDay) == 'الثلاثاء'){
      tuesdayCounter++;
    } if(DateFormat('EEEE').format(currentDay) == 'Wednesday' || DateFormat('EEEE').format(currentDay) == 'الأربعاء'){
      wednesdayCounter++;
    } if(DateFormat('EEEE').format(currentDay) == 'Thursday' || DateFormat('EEEE').format(currentDay) == 'الخميس'){
      thursdayCounter++;
    } if(DateFormat('EEEE').format(currentDay) == 'Friday' || DateFormat('EEEE').format(currentDay) == 'الجمعة'){
      fridayCounter++;
    }

  }

  maxDailyExpenseCount = {
    'Sunday': sundayCounter ,
    'Monday' : mondayCounter,
    'Tuesday': tuesdayCounter,
    'Wednesday':wednesdayCounter,
    'Thursday': thursdayCounter ,
    'Friday':fridayCounter,
    'Saturday': saturdayCounter,
  };


  dailyExpenseCount = {
    sundayCounter :'Sunday',
    mondayCounter : 'Monday',
    tuesdayCounter:'Tuesday',
    wednesdayCounter :'Wednesday',
    thursdayCounter : 'Thursday',
    fridayCounter :'Friday',
    saturdayCounter: 'Saturday',
  };

  arabicDailyExpenseCount = {
    sundayCounter :'الأحد',
    mondayCounter : 'الإثنين',
    tuesdayCounter:'الثلاثاء',
    wednesdayCounter :'الأربعاء',
    thursdayCounter : 'الخميس',
    fridayCounter :'الجمعة',
    saturdayCounter: 'السبت',
  };

}


List<int> getMaxDailyExpenseCount(){
  List<int> sort = [];
  int max  = 0;


  max = sundayCounter;
  int secondBest = 0;
  secondBest = max;


  int lowest = 0;
  lowest = sundayCounter;

  int total = 0;


  for(int i = 0 ; i < maxDailyExpenseCount.length ; i++){

    total += maxDailyExpenseCount.values.elementAt(i);
    if(max< maxDailyExpenseCount.values.elementAt(i)){
      secondBest = max;
      max = maxDailyExpenseCount.values.elementAt(i);
    }

    if(lowest > maxDailyExpenseCount.values.elementAt(i)){
      lowest = maxDailyExpenseCount.values.elementAt(i);
    }

  }

  sort.add(max);
  sort.add(secondBest);
  sort.add(lowest);
  percentDaily = total;
  return sort;
}
