import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';



class avgMonthData {
  final String monthName;
  final int monthAmount;

  avgMonthData(this.monthName,this.monthAmount);
}


List<avgMonthData> getMonthChartData() {
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


int januaryCounter  = 0;
int februaryCounter  = 0;
int marchCounter  = 0;
int aprilCounter  = 0;
int mayCounter  = 0;
int juneCounter  = 0;
int julyCounter  = 0;
int augustCounter  = 0;
int septemberCounter  = 0;
int octoberCounter  = 0;
int novemberCounter  = 0;
int decemberCounter  = 0;


Map<int , String> monthlyExpenseCount;
Map<String , int> maxMonthlyExpenseCount;

int percentMonthly = 1;


Timestamp expenseDate;


void getOtherUsersMonth(List<QueryDocumentSnapshot> otherUsersExpense) {


  DateTime currentMonth = DateTime.now();

  for(int i = 0 ; i < otherUsersExpense.length ; i++){
    expenseDate = otherUsersExpense[i].get('expenseDate');
    currentMonth = DateTime.parse(expenseDate.toDate().toString());

    if(DateFormat('MMMM').format(currentMonth) == 'January'){
      januaryCounter++;
    }
    if(DateFormat('MMMM').format(currentMonth) == 'February'){
      februaryCounter++;
    }
    if(DateFormat('MMMM').format(currentMonth) == 'March'){
      marchCounter++;
    }
    if(DateFormat('MMMM').format(currentMonth) == 'April'){
      aprilCounter++;
    } if(DateFormat('MMMM').format(currentMonth) == 'May'){
      mayCounter++;
    } if(DateFormat('MMMM').format(currentMonth) == 'June'){
      juneCounter++;
    } if(DateFormat('MMMM').format(currentMonth) == 'July'){
      julyCounter++;
    }

    if(DateFormat('MMMM').format(currentMonth) == 'August'){
      augustCounter++;
    }
    if(DateFormat('MMMM').format(currentMonth) == 'September'){
      septemberCounter++;
    }if(DateFormat('MMMM').format(currentMonth) == 'October'){
      octoberCounter++;
    }
    if(DateFormat('MMMM').format(currentMonth) == 'November'){
      novemberCounter++;
    }
    if(DateFormat('MMMM').format(currentMonth) == 'December'){
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

