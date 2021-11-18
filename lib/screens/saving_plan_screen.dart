import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finance/finance.dart';
import 'package:mccounting_text/mccounting_text.dart';
import 'package:flash_chat/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
SharedPreferences preferences;

AnimationController _controller;
Animation<double> _animation;
double _miles = 0.0;



Animation animation;
AnimationController animationController;


@override
  void initState() {
getCurrenLanguage();
  super.initState();

  animationController = AnimationController(
    duration: Duration(seconds: 2),
    vsync: this,
  );

  animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: animationController, curve: Curves.fastOutSlowIn));
  animationController.forward();


  }

String currentLang = "ar";

void getCurrenLanguage() async {
  preferences = await SharedPreferences.getInstance();
  setState(() {
    currentLang = preferences.getString('language');
  });
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
            appBar: AppBar(
              backgroundColor: Color(0xff01937C),
              title:Text('${S.of(context).savingPlan}'),
            ),
            body: SafeArea(
                child: Column(
                    children: [

                      Row(
                          mainAxisAlignment: currentLang == "ar"? MainAxisAlignment.spaceBetween: MainAxisAlignment.start,
                        children: [


                          Padding(
                            padding: const EdgeInsets.only(top: 20 , left:5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff01937C),
                                borderRadius: BorderRadius.all(Radius.circular(30))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [

                                    new FadeTransition(
                                      opacity: animationController.drive(CurveTween(curve: Curves.easeIn)),
                                      child:  Column(
                                          children: [



                                            Text('${S.of(context).needs}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: currentLang == "ar" ? 15 : 20,
                                                  fontWeight: FontWeight.bold
                                              ),),

                                            Divider(

                                            )

                                          ]
                                      ),
                                    ),

                                    Row(
                                      children: [
                                        McCountingText(
                                          begin: 0,
                                          end: widget.needs,
                                          style: TextStyle(
                                            color: CupertinoColors.white,
                                            fontSize: currentLang == "ar" ? 15 :  17,
                                          ),
                                          duration: Duration(seconds: 1),
                                          curve: Curves.decelerate,
                                        ),
                                        Text(' ${S.of(context).saudiRyal}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: currentLang == "ar" ? 15 : 17
                                          ),),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 20 , left:  5),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff01937C),
                                  borderRadius: BorderRadius.all(Radius.circular(30))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    new FadeTransition(
                                      opacity: animationController.drive(CurveTween(curve: Curves.easeIn)),
                                      child:  Column(
                                          children: [

                                            Text('${S.of(context).wants}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: currentLang == "ar" ? 15 : 17,
                                                  fontWeight: FontWeight.bold
                                              ),),


                                            Divider()
                                          ]
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
                                            fontSize: currentLang == "ar" ? 15 : 17,
                                          ),
                                          duration: Duration(seconds: 1),
                                          curve: Curves.decelerate,
                                        ),
                                        Text(' ${S.of(context).saudiRyal}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: currentLang == "ar" ? 15 : 17
                                          ),),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 5.0 , top: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff01937C),
                                  borderRadius: BorderRadius.all(Radius.circular(30))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    new FadeTransition(
                                      opacity: animationController.drive(CurveTween(curve: Curves.easeIn)),
                                      child:  Column(
                                          children: [

                                            Text('${S.of(context).saving}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: currentLang == "ar" ? 15 : 17,
                                                  fontWeight: FontWeight.bold
                                              ),),

                                            Divider()


                                          ]
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
                                            fontSize: currentLang == "ar" ? 15 : 17,
                                          ),
                                          duration: Duration(seconds: 1),
                                          curve: Curves.decelerate,
                                        ),
                                        Text(' ${S.of(context).saudiRyal}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: currentLang == "ar" ? 15 : 17
                                          ),),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
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
                                  '${S.of(context).needs}',
                                  '${S.of(context).needsDefinition}',
                                    '${S.of(context).needsPercentage}',
                                    '${S.of(context).basedOn} ${widget.userInfo.get('monthlyIncome')} ${S.of(context).saudiRyal}, ${S.of(context).yourBudgetNeeds} ${widget.needs} ${S.of(context).saudiRyal}',
                                    Color(0xffB983FF)
                                ),
                                width: 300,
                              ),

                              Container(
                                child: PlanBubble('${S.of(context).wants}',
                                    '${S.of(context).wantsDefinition}',
                                    '${S.of(context).wantsPercentage}',
                                    '${S.of(context).basedOn} ${widget.userInfo.get('monthlyIncome')} ${S.of(context).saudiRyal}, ${S.of(context).yourBudgetWants} ${widget.wants} ${S.of(context).saudiRyal}',
                                    Color(0xff94B3FD)),
                                width: 350,
                              ),

                              Container(
                                child: PlanBubble(
                                    '${S.of(context).saving}',
                                    '${S.of(context).savingDefinition}',
                                    '${S.of(context).savingPercentage}',
                                    '${S.of(context).managedToSave} ${widget.saving.toStringAsFixed(2)} ${S.of(context).investWith} ${Finance.fv(rate: rate, nper: yearsToRetire, pmt: - payments * 12 , pv:0 ).toStringAsFixed(2)} ${S.of(context).saudiRyal} in $yearsToRetire ${S.of(context).yearsBasedOnRetireDay}',
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









