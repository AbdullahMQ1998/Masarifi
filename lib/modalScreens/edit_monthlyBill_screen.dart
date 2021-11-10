
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/functions/AlertButtonFunction.dart';

class EditMonthlyBillScreen extends StatefulWidget {

  final Function addBill;
  final QueryDocumentSnapshot userMonthlyBillList;
  final QueryDocumentSnapshot userInfo;

  EditMonthlyBillScreen(this.addBill,this.userMonthlyBillList,this.userInfo);

  @override
  _EditMonthlyBillScreenState createState() => _EditMonthlyBillScreenState();
}

class _EditMonthlyBillScreenState extends State<EditMonthlyBillScreen> {
  String billName;
  String billCost;
  double currentTotalMonthlyBills;
  double currentTotalIncome;
  final _fireStore = FirebaseFirestore.instance;
  String dropdownValue;

  bool billNameEnabled = false;
  bool billNameEnabled2 = true;

  bool billCostEnabled = false;
  bool billCostEnabled2 = true;

  bool billIconEnabled = false;

  bool dateChanged = false;

  DateTime selectedDate = DateTime.now();
  DateTime dateToday = DateTime.now();
  String formattedDate;



  String updatedTotalMonthlyBillCost;
  String updateMonthlyIncome;
  String updatedBillIcon;





  bool checkNullorSpace() {
    if (billName != null &&
        billName != '' &&
        billCost != null &&
        billCost != '')
    {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {


    bool shouldDelete = false;
    bool isEnabled = false;



    Timestamp currentBillDate = widget.userMonthlyBillList.get('billDate');
    DateTime billDate = DateTime.parse(currentBillDate.toDate().toString());
    String billDateForrmated = DateFormat('yyyy-MM-dd').format(billDate);





    _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2021),
        lastDate: DateTime(2030),
      );
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
          formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
          dateChanged = true;

        });
    }



    if(billIconEnabled == false){
    dropdownValue = widget.userMonthlyBillList.get('billIcon');
    }
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            )),
        child: Column(

          children: [
            Text(
              'Edit Monthly Bill',
              style: TextStyle(
                  color: Color(0xff50c878),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 50, right: 50, top: 20, bottom: 20),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: billNameEnabled? TextField(
                    onSubmitted: (value){
                      setState(() {

                        billNameEnabled = false;
                        billNameEnabled2 = false;
                        if(billName == null){
                          billName = widget.userMonthlyBillList.get('billName');
                        }

                      });

                    },
                    maxLength: 10,
                    textAlign: TextAlign.center,
                    autofocus: true,
                    onChanged: (text) {
                      setState(() {
                        billName = text;
                      });
                    },
                    decoration:
                    kTextFieldDecoration.copyWith(hintText: widget.userMonthlyBillList.get('billName'),counter: Offstage()),
                  ) : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Text(billNameEnabled2? widget.userMonthlyBillList.get('billName'): billName,
                          style: TextStyle(
                              fontSize: 30
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          onPressed: (){
                            setState(() {
                              billNameEnabled = true;
                            });
                          },
                          icon: Icon(Icons.edit),
                        )
                      ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: billCostEnabled? TextField(
                    onSubmitted: (value){
                      setState(() {
                        double oldCost = double.parse(widget.userMonthlyBillList.get('billCost'));
                        double updatedCost = double.parse(billCost);
                        double differenceBetweenCosts = updatedCost - oldCost;

                        double currentMonthlyIncome = double.parse(widget.userInfo.get('monthlyIncome'));
                        double updatedMonthlyIncome = currentMonthlyIncome - differenceBetweenCosts;
                        updateMonthlyIncome = updatedMonthlyIncome.toString();




                        double currentTotalMonthlyBill = double.parse(widget.userInfo.get('totalMonthlyBillCost'));
                        double updatedTotalMonthlyBill = currentTotalMonthlyBill + differenceBetweenCosts;
                        updatedTotalMonthlyBillCost = updatedTotalMonthlyBill.toString();




                        billCostEnabled = false;
                        billCostEnabled2 = false;
                        if(billCost == null){
                          billCost = widget.userMonthlyBillList.get('billCost');
                        }

                      });

                    },
                    maxLength: 6,
                    textAlign: TextAlign.center,
                    autofocus: true,
                    keyboardType: TextInputType.numberWithOptions(),
                    onChanged: (text) {
                      setState(() {
                        billCost = text;
                      });
                    },
                    decoration:
                    kTextFieldDecoration.copyWith(hintText: widget.userMonthlyBillList.get('billCost') , counter: Offstage()),
                  ) : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Text(billCostEnabled2? widget.userMonthlyBillList.get('billCost'): billCost,
                          style: TextStyle(
                              fontSize: 30
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          onPressed: (){
                            setState(() {
                              billCostEnabled = true;
                            });
                          },
                          icon: Icon(Icons.edit),
                        )
                      ]
                  ),
                ),
                Row(
                  children:[DropdownButton(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 10,
                    style: const TextStyle(color: Colors.black),
                    underline: Container(
                      height: 1,
                      color: Color(0xff50c878),
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                        billIconEnabled = true;
                      });
                    },
                    items: <String>[
                      'Rent',
                      'Water',
                      'Internet',
                      'Phone',
                      'Electric',
                      'installment',
                    ]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                    SizedBox(
                      width: 10,
                    ),

                    TextButton(
                      onPressed: () => _selectDate(context),
                      child: Row(
                          children:[
                            Icon(Icons.calendar_today_rounded,
                              color: Colors.blueAccent,
                            ),
                            Text(formattedDate == null?  billDateForrmated : formattedDate,
                              style:
                              TextStyle(color: Colors.black
                                  , fontWeight: FontWeight.bold),
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

                  ]
                ),

              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[

                TextButton(
                  onPressed: () {

                    showAlertDialogForMonthlyBill(context, shouldDelete, widget.userInfo, widget.userMonthlyBillList);
                  },
                  child: Text('Delete',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                    ),),

                  style: ButtonStyle(

                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.red
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )
                      )
                  ),
                ),

                SizedBox(
                  width: 10,
                ),

                TextButton(
                  onPressed: () {
                    if(billName == null ){
                      billName = widget.userMonthlyBillList.get('billName');
                    }
                    if(billCost == null){
                    billCost = widget.userMonthlyBillList.get('billCost');
                    }
                    if(updateMonthlyIncome == null){
                    updateMonthlyIncome = widget.userInfo.get('monthlyIncome');
                    }
                    if(updatedTotalMonthlyBillCost == null){
                    updatedTotalMonthlyBillCost = widget.userInfo.get('totalMonthlyBillCost');
                    }

                    if(dropdownValue == null){
                      dropdownValue = widget.userMonthlyBillList.get('billIcon');
                    }

                    if(dateChanged){
                      widget.userMonthlyBillList.reference.update({'billDate': selectedDate});
                    }

                    widget.userMonthlyBillList.reference.update({'billName': billName});
                    widget.userMonthlyBillList.reference.update({'billCost': billCost});
                    widget.userInfo.reference.update({'monthlyIncome' : updateMonthlyIncome});
                    widget.userInfo.reference.update({'totalMonthlyBillCost' : updatedTotalMonthlyBillCost});

                    widget.userMonthlyBillList.reference.update({'billIcon': dropdownValue});

                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Update',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),),
                  ),
                  style: ButtonStyle(

                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.green
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )
                      )
                  ),
                ),


              ]
            ),


          ],
        ),
      ),
    );
  }
}
