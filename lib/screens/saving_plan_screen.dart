import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:finance/finance.dart';
import 'package:mccounting_text/mccounting_text.dart';


class SavingPlanScreen extends StatefulWidget {
  final User loggedUser;
  final QueryDocumentSnapshot userInfo;
  final double needs;
  final double wants;
  final double saving;

  SavingPlanScreen(this.loggedUser,this.userInfo,this.needs,this.wants,this.saving);

  @override
  _SavingPlanScreenState createState() => _SavingPlanScreenState();
}



class _SavingPlanScreenState extends State<SavingPlanScreen> with SingleTickerProviderStateMixin {


Timestamp retirementDate;

 double futureValue;
 double payments;
 double rate;


AnimationController _controller;
Animation<double> _animation;
double _miles = 0.0;



Animation animation;
AnimationController animationController;


@override
  void initState() {

  super.initState();

  animationController = AnimationController(
    duration: Duration(seconds: 2),
    vsync: this,
  );

  animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: animationController, curve: Curves.fastOutSlowIn));
  animationController.forward();


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();


  }

  @override
  Widget build(BuildContext context) {
    retirementDate = widget.userInfo.get('expectedRetireDate');
    DateTime formattedRetireDate = DateTime.parse(
        retirementDate.toDate().toString());
    DateTime currentDate = DateTime.now();

    payments = widget.saving;

    rate = 0.05;


    int differenceBetweenCurrentAndRetireDate = formattedRetireDate
        .difference(currentDate)
        .inDays;
    double yearsToRetire = differenceBetweenCurrentAndRetireDate.toInt() / 365;
    String roundedYearToRetire = yearsToRetire.toStringAsFixed(2);
    yearsToRetire = double.parse(roundedYearToRetire);


    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Scaffold(

            body: SafeArea(
                child: Column(

                    children: [


                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(

                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [

                                  Center(
                                    child: new FadeTransition(
                                      opacity: animationController.drive(CurveTween(curve: Curves.easeIn)),
                                      child:  Column(
                                          children: [

                                            SizedBox(
                                              height: 30,
                                            ),

                                            Text('Needs',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold
                                              ),),

                                            Divider(
                                              color: Colors.white,
                                              thickness: 2,
                                              indent: 120,
                                              endIndent: 120,
                                            ),

                                          ]
                                      ),
                                    ),
                                  ),



                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      McCountingText(
                                        begin: 0,
                                        end: widget.needs,
                                        style: TextStyle(
                                          color: CupertinoColors.white,
                                          fontSize: 20,
                                        ),
                                        duration: Duration(seconds: 1),
                                        curve: Curves.decelerate,
                                      ),
                                      Text(' SAR',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20
                                        ),),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: new FadeTransition(
                                      opacity: animationController.drive(CurveTween(curve: Curves.easeIn)),
                                      child:  Column(
                                          children: [

                                            Text('Wants',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold
                                              ),),

                                            Divider(
                                              color: Colors.white,
                                              thickness: 2,
                                              indent: 120,
                                              endIndent: 120,
                                            ),

                                          ]
                                      ),
                                    ),
                                  ),



                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      McCountingText(
                                        begin: 0,
                                        end: widget.wants,
                                        style: TextStyle(
                                          color: CupertinoColors.white,
                                          fontSize: 20,
                                        ),
                                        duration: Duration(seconds: 1),
                                        curve: Curves.decelerate,
                                      ),
                                      Text(' SAR',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20
                                        ),),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),

                                  Center(
                                    child: new FadeTransition(
                                      opacity: animationController.drive(CurveTween(curve: Curves.easeIn)),
                                      child:  Column(
                                          children: [

                                            Text('Saving',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold
                                              ),),

                                            Divider(
                                              color: Colors.white,
                                              thickness: 2,
                                              indent: 120,
                                              endIndent: 120,
                                            ),

                                          ]
                                      ),
                                    ),
                                  ),


                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      McCountingText(
                                        begin: 0,
                                        end: widget.saving,
                                        style: TextStyle(
                                          color: CupertinoColors.white,
                                          fontSize: 20,
                                        ),
                                        duration: Duration(seconds: 1),
                                        curve: Curves.decelerate,
                                      ),
                                      Text(' SAR',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20
                                        ),),
                                    ],
                                  ),


                                ],
                              ),
                            ),

                            decoration: BoxDecoration(
                                color: Color(0xff413C69),
                                borderRadius: BorderRadius.all(Radius.circular(
                                    40))
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 5,
                      ),

                      Expanded(
                        child: Container(

                          child: ListView(

                            children: [

                              Container(
                                child: PlanBubble(
                                  'Needs',
                                  'Needs are expenses that you can’t avoid, payments for all the essentials that would be difficult to live without.',
                                    '50% of your monthly income should cover your most necessary costs.',
                                    'Based on your monthly income ${widget.userInfo.get('monthlyIncome')} SAR, your budget on needs is ${widget.needs} SAR',
                                    Color(0xffB983FF)
                                ),
                                width: 300,
                              ),

                              Container(
                                child: PlanBubble('Wants',
                                    'Wants are defined as non-essential expenses—things that you choose to spend your money on, although you could live without them if you had to.',
                                    '30% of your monthly income can be used to cover your wants',
                                    'Based on your monthly income ${widget.userInfo.get('monthlyIncome')} SAR, your budget on needs is ${widget.wants} SAR',
                                    Color(0xff94B3FD)),
                                width: 350,
                              ),

                              Container(
                                child: PlanBubble(
                                    'Saving',
                                    'Consistently putting aside 20% of your pay each month can help you build a better, more durable savings plan.',
                                    'the remaining 20% can be put towards achieving your savings goals',
                                    'If you manged to save ${widget.saving.toStringAsFixed(2)} every month and invest with 5% interest rate, you will ended up having ${Finance.fv(rate: rate, nper: yearsToRetire, pmt: - payments * 12 , pv:0 ).toStringAsFixed(2)} SAR in $yearsToRetire years based on your retirement date',
                                    Color(0xffC37B89),
                                ),
                                width: 350,
                              )

                            ],

                          ),
                        ),
                      ),

                    ])),

          );
        }
    );
  }
  }

class PlanBubble extends StatelessWidget {
  final String title;
  final String firstText;
  final String secondText;
  final String thirdText;

  final Color bubbleColor;


  PlanBubble(this.title,this.firstText,this.secondText,this.thirdText,this.bubbleColor);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(firstText,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(secondText,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15
                ),),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(thirdText,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),),
              ),
            ],
          ),
        ),
        color: bubbleColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}









