import 'package:flash_chat/Components/Rounded_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:intl/intl.dart';
import 'home_screen.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterUserInfo extends StatefulWidget {
  static const String id = 'register_user_info';

  @override
  _RegisterUserInfoState createState() => _RegisterUserInfoState();
}

class _RegisterUserInfoState extends State<RegisterUserInfo> {
  String userName;
  String age;
  String gender;
  String matiralStats;
  String occupation;
  String monthlyIncome;
  String nmbOfChild;
  double userBudget;

  bool isEmployee = true;

  bool isZero = false;

  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  User loggedUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    final user = await _auth.currentUser;
    try {
      if (user != null) {
        loggedUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  DateTime selectedDate = DateTime.now();
  String format;

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2090),
      selectableDayPredicate: _decideWhichDayToEnable
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }


  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))))) {
      return true;
    }
    return false;
  }


  Widget dialog(){

    return Container(
      child:Text("HAHA") ,
    );

  }

  @override

  @override
  Widget build(BuildContext context) {

    bool checkNullorSpace(){
      if(userName != null && userName != '' &&  monthlyIncome != null && monthlyIncome != ''){
              return true;
      }
            else{
              return false;
            }

    }

    return Scaffold(

      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            color: Color(0xffF4F9F9),
            child: Column(

              children: [

                SizedBox(
                  height: 40,
                ),

                Text('Let\'s Get Started!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),),

                Text('Create an account to Masaryfy to get all the features',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),),

                SizedBox(
                  height: 40,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                     userName = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'User name',
                    fillColor: Colors.white ,
                     filled: true,
                      enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),


                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      monthlyIncome = value;
                    });

                  },
                  onSubmitted: (value){

                    setState(() {
                      if(double.parse(monthlyIncome)  <= 999){
                        Alert(context: context, title: "ERROR", desc: "Please enter amount over 999 for the monthly income").show();
                        monthlyIncome = null;
                      }
                    });

                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Monthly income',fillColor: Colors.white ,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),),
                ),
                SizedBox(
                  height: 20,
                ),



                DropDown<String>(
                  items: ["Male", "Female"],
                  hint: Text("Male"),
                  initialValue: gender = "Male",
                  icon: Icon(
                    Icons.expand_more,
                    color: Colors.blue,
                  ),
                  onChanged: (value) {
                      gender = value;
                  },
                ),
                DropDown<String>(
                  items: ["Employed", "Unemployed", "Retired"],
                  hint: Text("Employed"),
                  initialValue: occupation = "Employed",
                  icon: Icon(
                    Icons.expand_more,
                    color: Colors.blue,
                  ),
                  onChanged: (value) {
                      occupation = value;
                      setState(() {
                        if(occupation == 'Retired'){
                          isEmployee = false;
                        }
                        else{
                          isEmployee = true;
                        }
                      });
                  },
                ),

                SizedBox(
                  height: 20,
                ),


                Visibility(
                  visible: isEmployee,
                  child: Text('Expected Retirement Date',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                ),




                Visibility(
                  visible: isEmployee,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        child: TextButton(
                          onPressed: () => _selectDate(context),
                          child: Row(
                              children:[
                                Icon(Icons.calendar_today_rounded,
                                  color: Colors.blueAccent,
                                ),
                                Text("${DateFormat('yyyy-MM-dd').format(selectedDate)}",
                                  style:
                                  TextStyle(color: Colors.black
                                      , fontWeight: FontWeight.bold),
                                ),
                              ]
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white
                              ),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.grey),
                                  )
                              )
                          ),
                        ),
                      ),

                      IconButton(onPressed: () {
                        Alert(context: context, title: "Retirement Date", desc: "We need the retirement date to calculate the amount of years left to retire and use it to give the best advices to you",

                          buttons: [
                            DialogButton(child: Text('Understood',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),), onPressed:(){
                              Navigator.pop(context);
                            })
                          ]

                        ).show();
                      }, icon: Icon(Icons.info_outline))


                    ],
                  ),
                ),

                
                Expanded(child: SizedBox()),


                paddingButton(Color(0xff01937C), "Create an account", (){
                // we move the loggedUser to the homeScreen so we can retrieve data from it.
                if(checkNullorSpace()) {
                  userBudget = double.parse(monthlyIncome) * 0.80;
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      HomeScreen(
                          loggedUser,
                      ))
                  );

                  // add the user information to the database from here
                  _fireStore.collection('User_Info').add({
                    'userName':userName,
                    'email': loggedUser.email,
                    'gender':gender,
                    'monthlyIncome':monthlyIncome,
                    'expectedRetireDate':selectedDate,
                    'occupation':occupation,
                    'totalExpense':"0",
                    'totalMonthlyBillCost':"0",
                    'userBudget': userBudget.toString(),

                    'expenseNumber': 0,
                  });
                }
                else{
                  Alert(context: context, title: "ERROR", desc: "Make sure you have filled the required information").show();
                }

                }),

              ],



            ),
          ),
        ),
      ),
      backgroundColor: Color(0xffF4F9F9),
      resizeToAvoidBottomInset: false,
    );

  }
}


