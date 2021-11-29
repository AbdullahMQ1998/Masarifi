import 'package:flash_chat/Provider/language_change_provider.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/Components/Rounded_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome_screen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation animation;
  String dropdownValue = 'English';
  @override
  void initState() {
    // TODO: implement initState
    getPreference();
    super.initState();
    Firebase.initializeApp();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = ColorTween(begin: Colors.grey , end: Colors.white).animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {
        
      });
    });
  }

  Map<String , String> languagePick = {
    "English": "en",
    "العربية" : "ar"
  };

  Map<String , String> dropDownPick = {
    "en" :  "English",
    "ar" : "العربية"
  };

  void getPreference() async {
    per = await SharedPreferences.getInstance();
    setState(() {
      dropdownValue =  dropDownPick[per.getString('language')] ?? "English";
    });

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  SharedPreferences per;


  @override
  Widget build(BuildContext context) {
    final langChange = Provider.of<LanguageChangeProvider>(context);



    return Scaffold(

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60,
                  ),
                ),
                TypewriterAnimatedTextKit(text: ['${S.of(context).masarifi}'], textStyle: TextStyle(
                  fontSize: 45.0,
                  fontWeight: FontWeight.w900,
                ),
                speed: Duration(milliseconds: 250),),

              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            paddingButton(Color(0xff16C79A),'${S.of(context).logIn}' , () {
              Navigator.pushNamed(context, LoginScreen.id);
            }),
            paddingButton(Color(0xff01937C), '${S.of(context).register}', (){
              Navigator.pushNamed(context, RegistrationScreen.id);
            }),


            DropdownButton(
              value: dropdownValue,
              iconSize: 20,
              elevation: 10,
              style: const TextStyle(),
              underline: SizedBox(),
              onChanged: (newValue) async {
                per = await SharedPreferences.getInstance();
                setState(() {
                  dropdownValue = newValue;
                  per.setString('language',languagePick[dropdownValue]);
                  langChange.changeLocale(languagePick[dropdownValue]);
                  per.setString('langChanged','true');
                });
              },
              items: <String>[
                'English',
                'العربية',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                        fontSize: 20,color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                );
              }).toList(),
            )

          ],
        ),
      ),
    );
  }
}


