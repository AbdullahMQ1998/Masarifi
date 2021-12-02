
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/Components/widgets.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/functions/sort_function.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flash_chat/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';





class ExpenseScreen extends StatefulWidget {

  final User loggedUser;
  final DateTime date;
  final QueryDocumentSnapshot userInfo;

  ExpenseScreen(this.loggedUser,this.date,this.userInfo);

  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {

  int differenceBetweenDates = 29;
  int picker = 0;
  int counter = 0;
  String name;


  DateTime selectedDate = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  DateTime currentDay = DateTime.now();
  DateTime pastDate = DateTime.now();
  String formattedDate;
  bool isEnabled = false;
  bool isEnabled2 = false;

  String beforeOneMonthDate;
  String currentDate;
  String currentDate2;
  String todayDate;
  String dropdownValue;
  bool dropDownChanged = false;

  SharedPreferences preferences;


  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: widget.date,
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        counter++;
        if(name == null || name.isEmpty)
        picker = 4;
        selectedDate = picked;
        differenceBetweenDates = currentDay.difference(selectedDate).inDays;
        isEnabled = true;
      });
  }

  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: differenceBetweenDates + 1))) &&
        day.isBefore(DateTime.now().add(Duration(days: 10))))) {
      return true;
    }
    return false;
  }

  _selectDate2(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: pastDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
      selectableDayPredicate: _decideWhichDayToEnable,
    );
    if (picked != null && picked != selectedDate2)
      setState(() {
        selectedDate2 = picked;
        if(name == null || name.isEmpty)
        picker = 4;
        isEnabled2 = true;

      });
  }


  String currentLang = "ar";

  void getCurrenLanguage() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      currentLang = preferences.getString('language');
    });
  }



  Map<String, String> arabicCategory = {
    'All' : 'الكل',
    'Restaurants': 'مطاعم',
    'Shopping': "تسوق",
    'Gas': "بنزين",
    'Coffee': "قهوة",
    'Finance': "مالية",
    'Grocery': "بقالة",
    'Furniture': "أثاث",
    'Health': "صحة",
    'Online-Shopping': "تسوق إلكتروني",
    'Entertainment': "ترفيه",
    'Education': "تعليم",
    'Other': "أخرى"
  };

  Map<String, String> arabicToEnglish = {
    'الكل' : 'All',
    'مطاعم': 'Restaurants',
    "تسوق": 'Shopping',
    "بنزين": 'Gas',
    "قهوة": 'Coffee',
    "مالية": 'Finance',
    "بقالة": 'Grocery',
    "أثاث": 'Furniture',
    "صحة": 'Health',
    "تسوق إلكتروني": 'Online-Shopping',
    "ترفيه": 'Entertainment',
    "تعليم": 'Education',
    "أخرى": 'Other',
  };

@override
  void initState() {
    getCurrenLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  double height = MediaQuery.of(context).size.height;


    if(dropDownChanged == false || dropdownValue == null){

      if(currentLang == 'ar'){
        dropdownValue = 'الكل';
      }
      else{
        dropdownValue = 'All';
      }

    }

    beforeOneMonthDate = DateFormat('yyyy-MM-dd').format(widget.date);
    todayDate = DateFormat('yyyy-MM-dd').format(pastDate);

    currentDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    currentDate2 = DateFormat('yyyy-MM-dd').format(selectedDate2);


    TextEditingController textEditingController;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Color(0xfff2f3f4),
      body: SafeArea(
        child: Column(
          children:[


            Padding(
              padding: currentLang == 'ar'? EdgeInsets.only(left: 20.0,right: 20) : EdgeInsets.only(left: 20.0,right: 20 , bottom: 20),
              child: Container(
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),

                 child: Padding(
                   padding: const EdgeInsets.all(15.0),
                   child: Column(
                     children: [

                       Row(
                         children: [
                           Icon(Icons.sort,
                           size: 30,),
                           Text(' ${S.of(context).filter}',
                           style: TextStyle(
                             fontSize: 25
                           ),),
                         ],
                       ),

                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             TextButton(
                               onPressed: () => _selectDate(context),
                               child: Row(
                                 children:[
                                   Icon(Icons.calendar_today_rounded,
                                   color: Colors.grey,
                                   ),
                                   Text(isEnabled? '  $currentDate' : "  $beforeOneMonthDate",
                                     style:
                                     TextStyle(
                                          fontWeight: FontWeight.bold,
                                       color: Colors.grey
                                     ),
                                   ),
                                 ]
                               ),
                               style: ButtonStyle(
                                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                       RoundedRectangleBorder(
                                           borderRadius: BorderRadius.circular(18.0),
                                           side: BorderSide(color: Colors.grey)
                                       )
                                   )
                               ),
                               ),


                             Text("${S.of(context).to}",
                             style: TextStyle(
                               fontSize: 25,
                               fontWeight: FontWeight.bold
                             ),),

                             TextButton(
                               onPressed: () =>  _selectDate2(context) ,
                               child: Row(
                                   children:[
                                     Icon(Icons.calendar_today_rounded,
                                       color: Colors.grey,
                                     ),
                                     Text(isEnabled2 ? ' $currentDate2':' $todayDate',
                                       style:
                                       TextStyle(
                                            fontWeight: FontWeight.bold,
                                       color: Colors.grey),
                                     ),
                                   ]
                               ),
                               style: ButtonStyle(
                                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                       RoundedRectangleBorder(
                                           borderRadius: BorderRadius.circular(18.0),
                                           side: BorderSide(color: Colors.grey)
                                       )
                                   )
                               ),
                             ),

                           ],
                         ),
                       ),

                       Padding(
                         padding: const EdgeInsets.all(15.0),
                         child: TextButton(
                           onPressed: () {

                           },
                           child: Row(
                               children:[
                                 Icon(Icons.menu_open_outlined,
                                   color: Colors.grey,
                                 ),
                                 Expanded(
                                   child: Text('${S.of(context).expenseType}',
                                     style:
                                     TextStyle(
                                         // color: Colors.black45,
                                         fontWeight: FontWeight.bold,
                                       fontSize: 10,
                                       color: Colors.grey
                                     ),
                                   ),
                                 ),

                                 currentLang == 'ar' ? DropdownButton(
                                   value: dropdownValue,
                                   icon: const Icon(Icons.arrow_downward),
                                   iconSize: 20,
                                   elevation: 10,
                                   style: const TextStyle(),
                                   underline: SizedBox(),
                                   onChanged: (newValue) {
                                     setState(() {
                                       dropdownValue = newValue;
                                       dropDownChanged = true;
                                       if(newValue == "الكل"){
                                         picker = 6;
                                       }
                                     });
                                   },
                                   items: <String>[
                                     'الكل',
                                     'مطاعم',
                                     "تسوق",
                                     "بنزين",
                                     "قهوة",
                                     "مالية",
                                     "بقالة",
                                     "أثاث",
                                     "صحة",
                                     "تسوق إلكتروني",
                                     "ترفيه",
                                     "تعليم",
                                     "أخرى"
                                   ]
                                       .map<DropdownMenuItem<String>>((String value) {
                                     return DropdownMenuItem<String>(
                                       value: value,
                                       child: Text(value,
                                         style: TextStyle(
                                             fontSize: 20,
                                             color: Color(0xff50c878)
                                         ),),
                                     );
                                   }).toList(),
                                 ) : DropdownButton(
                                   value: dropdownValue,
                                   icon: const Icon(Icons.arrow_downward),
                                   iconSize: 20,
                                   elevation: 10,
                                   style: const TextStyle(),
                                   underline: SizedBox(),
                                   onChanged: (newValue) {
                                     setState(() {
                                       dropdownValue = newValue;
                                       dropDownChanged = true;
                                       if(newValue == "All"){
                                         picker = 6;
                                       }
                                     });
                                   },
                                   items: <String>[
                                     'All',
                                     'Restaurants',
                                     'Shopping',
                                     'Gas',
                                     'Coffee',
                                     'Finance',
                                     'Grocery',
                                     'Furniture',
                                     'Health',
                                     'Online-Shopping',
                                     'Entertainment',
                                     'Education',
                                     'Other'
                                   ]
                                       .map<DropdownMenuItem<String>>((String value) {
                                     return DropdownMenuItem<String>(
                                       value: value,
                                       child: Text(value,
                                       style: TextStyle(
                                         fontSize: 20,
                                         color: Color(0xff50c878)
                                       ),),
                                     );
                                   }).toList(),
                                 ),




                               ]
                           ),
                           style: ButtonStyle(
                               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                   RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(18.0),
                                       side: BorderSide(color: Colors.grey)
                                   )
                               )
                           ),
                         ),
                       ),

                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: TextField(
                           controller: textEditingController,
                           onChanged: (value){
                             setState(() {
                               if(picker == 2){
                                 name = value;
                               }
                               else
                               picker = 3;
                               name = value;
                             });

                           },
                           decoration: kTextFieldDecoration.copyWith(hintText: "${S.of(context).searchByName}"),
                         ),
                       ),

                       Padding(
                         padding: const EdgeInsets.all(15.0),
                         child: TextButton(onPressed: (){
                           setState(() {
                             if(counter < 1){
                               counter++;
                             selectedDate = widget.date;
                             }
                             if(name == null || name.isEmpty)
                             picker = 1;
                             if(dropdownValue != 'All' && arabicToEnglish[dropdownValue] != "All"){
                               if(name != null){
                                 setState(() {
                                   picker = 5;
                                 });
                               }
                               else
                               picker = 2;
                             }

                           });
                         },
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Container(
                                   child: Icon(Icons.search,
                                     color: Colors.white,
                                     size: 30,
                                   ),
                                   decoration: BoxDecoration(

                                     borderRadius: BorderRadius.all(Radius.circular(100))
                                   ),

                                 ),
                                 Text('${S.of(context).search}',
                                   style: TextStyle(
                                     color: Colors.white,
                                     fontWeight: FontWeight.bold,
                                     fontSize: 30
                                   ),
                                 ),
                                 SizedBox(
                                   width: 40,
                                 ),
                               ],
                             ),
                             style: ButtonStyle(
                               backgroundColor:MaterialStateProperty.all<Color>(
                                   Color(0xff01937C)
                               ) ,
                             shape: MaterialStateProperty.all<RoundedRectangleBorder>(

                             RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.grey)
              )
      )
    )

                         ),
                       )


                     ],
                   ),
                 ),
               ),
            ),





        Expanded(
          child: Container(

          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('expense').where('email', isEqualTo: widget.loggedUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text(
                'No Expenses',
              );
            }
            var expenses = snapshot.data.docs;


            //We add expense from here



            List<ExpensesBubble> sortPicker(int pick){
                    if(pick == 1){
                     return sortByDate(expenses,selectedDate,selectedDate2,widget.userInfo);
                    }
                    if(pick == 2){
                      return sortByDateAndType(expenses, selectedDate, selectedDate2, currentLang== 'ar'? arabicToEnglish[dropdownValue]:dropdownValue,widget.userInfo);
                    }
                    if(pick == 3){
                      return searchByName(expenses, widget.userInfo, name);
                    }
                    if(pick == 5){
                      return sortByDateAndTypeAndName(expenses, selectedDate, selectedDate2, currentLang== 'ar'? arabicToEnglish[dropdownValue]:dropdownValue,widget.userInfo ,name);
                    }
                    else
                    return normalViewExpensesPage(expenses,widget.userInfo);
            }



            return Column(
              children:[

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: sortPicker(picker).length == 0 ? Center(child: Text("${S.of(context).noResults}")): Text("${sortPicker(picker).length} ${S.of(context).resultFound}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                ],),

                Container(
                  child: ListView(
                  children: sortPicker(picker),
              ),
                  height: height / 3.2,
                ),
              ]
            );

          },
    ),
    ),
        ),
    ]
        ),
      ),

      appBar: AppBar(
        title: Text('${S.of(context).expensePage}'),
        backgroundColor: Color(0xff01937C),
      ),
      
      );


  }
}
