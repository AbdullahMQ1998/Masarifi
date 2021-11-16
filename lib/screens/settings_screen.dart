import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/Provider/dark_them.dart';
import 'package:flash_chat/screens/edit_profile_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:provider/provider.dart';
import 'package:flash_chat/generated/l10n.dart';



class SettingScreen extends StatefulWidget {

  static const String id = 'settings_screen';
  final QueryDocumentSnapshot userInfo;
  SettingScreen(this.userInfo);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  bool status = false;
  final _auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
final themChange = Provider.of<DarkThemProvider>(context);



    return Scaffold(


      appBar: AppBar(

        backgroundColor: Color(0xff01937C),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              height: 250,
              child: Column(
                children: [

                  Expanded(child: SizedBox()),

                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('images/${widget.userInfo.get('gender')}.png'),
                      ),
                    ),
                  ),

                  Center(
                    child: Text(widget.userInfo.get('userName'),
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  Center(
                    child: Text(widget.userInfo.get('email'),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20
                    ),),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(top:20,bottom: 10),
                    child: Container(
                        width: 150,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen(widget.userInfo)));
                        },
                        child: Text('${S.of(context).editProfile}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15
                          ),),

                        style: ButtonStyle(

                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xff01937C)
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                )
                            )
                        ),
                      ),
                    ),
                  ),


                ],
              ),

              decoration: BoxDecoration(

              ),
            ),


            Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  '${S.of(context).preferences}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    letterSpacing: 2
                  ),
                ),
              ),

            ),


            Expanded(
              child: Container(
                child: Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Icon(Icons.language,
                          size: 30,),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text('${S.of(context).language}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                          Text(
                            'English',
                            style: TextStyle(
                              fontSize: 15
                            ),
                          ),
                          Icon(Icons.chevron_right,
                          )
                        ],
                      ),
                    ),

                    Divider(),

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Icon(Icons.dark_mode,
                            size: 30,),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text('${S.of(context).darkMode}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),),
                          ),

                          CustomSwitch(
                            activeColor: Colors.green,
                            value: themChange.getDarkTheme(),
                            onChanged: (value) {
                              setState(() {
                               themChange.setDarkThem(value);
                              });
                            },
                          ),

                        ],
                      ),
                    ),
                    Divider(),

                    FlatButton(
                      onPressed: (){
                        _auth.signOut();
                        Navigator.pushNamed(context, WelcomeScreen.id);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.logout,
                          size: 30,
                          ),
                          Text("  ${S.of(context).signOut}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,

                          ),),
                        ],
                      ),
                    ),
                    Divider()
                  ],
                ),


              ),
            ),



          ],
        ),
      ),

    );
  }
}
