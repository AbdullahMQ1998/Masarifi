import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/Components/Rounded_button.dart';
import 'package:flash_chat/Provider/dark_them.dart';
import 'package:flash_chat/functions/AlertButtonFunction.dart';
import 'package:flash_chat/modalScreens/reset_password.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_auth/local_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'package:flash_chat/generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  User loggedUser;
  QueryDocumentSnapshot userInfo;
  String email;
  String password;
  bool showSpinner = false;

  SharedPreferences preferences;
  bool _isChecked = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;

  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;


  @override
  void initState() {
getLocalStorage();
_loadUserEmailPassword();
    super.initState();
  }

  void getLocalStorage() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
          localizedReason:
          'Scan your fingerprint (or face or whatever) to authenticate',
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = "Error - ${e.message}";
      });
      return;
    }
    if (!mounted) return;

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() async {
      _authorized = message;
      if(preferences.getString('Email') == null || preferences.getString('Pass') == null){
          showIOSGeneralAlert(context, "Please make sure you have an account in Masarifi");
      }
      else
      if(_authorized == "Authorized"){

        final user = await _auth.signInWithEmailAndPassword(email: preferences.getString('Email'), password: preferences.getString('Pass')).catchError((err) {

          Platform.isIOS ? showIOSGeneralAlert(context,err.message): showGeneralErrorAlertDialog(context, 'Error', err.message);

        });

        try{
          if(user != null) {
            getCurrentUser();
            getData();

            Navigator.of(context).pop();
            Navigator
                .of(context)
                .pushReplacement(
                MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen(
                      loggedUser,
                    )
                )
            );

          }
          setState(() {
            showSpinner = false;
          });}
        catch(e){
          print(e);
        }
      }
      }
    );

  }

  void _handleRemeberme(bool value) {
    _isChecked = value;
    SharedPreferences.getInstance().then(
          (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', _emailController.text);
        prefs.setString('password', _passwordController.text);
      },
    );
    setState(() {
      _isChecked = value;
    });
  }


  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
          localizedReason: 'Let OS determine authentication method',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = "Error - ${e.message}";
      });
      return;
    }
    if (!mounted) return;

    setState(
            () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }


  void _loadUserEmailPassword() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("email") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;
      if (_remeberMe) {
        setState(() {
          _isChecked = true;
        });
        _emailController.text = _email ?? "";
        _passwordController.text = _password ?? "";
      }
    } catch (e)
    {
      print(e);
    }
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

  void getData() async {
    StreamBuilder<QuerySnapshot>(
      // Here in the stream we get the user info from the database based on his email, we will get all of his information
        stream: FirebaseFirestore.instance
            .collection('User_Info')
            .where('email', isEqualTo: loggedUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator(
              backgroundColor: Colors.blueAccent,
            );
          }

          final user = snapshot.data.docs;
          userInfo = user[0];
          print(userInfo.get('darkMode'));


          return Text('');
        });
  }





  @override
  Widget build(BuildContext context) {


    final themChange = Provider.of<DarkThemProvider>(context);


    return Scaffold(
      // backgroundColor: Color(0xffF4F9F9),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                controller: _emailController,
                textAlign: TextAlign.center,
                onChanged: (value) {

                  setState(() {
                    email = value;
                  });

                  },

                decoration: kTextFieldDecoration.copyWith(hintText: '${S.of(context).enterYourMail}' ,

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide( width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                fillColor: themChange.getDarkTheme()? Colors.grey.shade800 : Colors.grey.shade300,
                filled: true),

              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: _passwordController,
                textAlign: TextAlign.center,
                obscureText: true,

                onSubmitted: (value) async {

                },
                onChanged: (value){
                  setState(() {
                    password = value;
                  });
                },

                decoration: kTextFieldDecoration.copyWith(hintText: '${S.of(context).enterYourPass}',

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide( width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                    fillColor: themChange.getDarkTheme()? Colors.grey.shade800 : Colors.grey.shade300,
                    filled: true),


              ),
              
              Row(children: [
                  Checkbox(
                  activeColor: Color(0xff00C8E8),
            value: _isChecked,
                    onChanged: _handleRemeberme,
                  ),
                Expanded(
                  child: Text("${S.of(context).rembmerMe}",
                    style: TextStyle(
                   fontSize: 15
                    ),
                  ),
                ),

                TextButton(onPressed: (){


                  showModalBottomSheet(
                    barrierColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) => ResetPassword()
                         );

                }, child: Text('${S.of(context).forgotPassword}')),
              ],),
              
             
              SizedBox(
                height: 24.0,
              ),





              paddingButton(Color(0xff01937C), '${S.of(context).logIn}', () async{


                setState(() {
                  showSpinner = true;
                  email = _emailController.text;
                  password = _passwordController.text;
                });


                if(email == null || password == null){
                  email = '';
                  password = '';
                }

                final user = await _auth.signInWithEmailAndPassword(email: email, password: password).catchError((err) {

                  Platform.isIOS ? showIOSGeneralAlert(context,err.message): showGeneralErrorAlertDialog(context, 'Error', err.message);

                });

                try{
                if(user != null) {
                  getCurrentUser();
                  getData();


                  if(email != null && password != null){
                  preferences.setString('Email', email);
                  preferences.setString('Pass', password);
                  }

                  Navigator.of(context).pop();
                  Navigator
                      .of(context)
                      .pushReplacement(
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomeScreen(
                            loggedUser,
                          )
                      )
                  );

                }
                setState(() {
                  showSpinner = false;
                });}
                catch(e){
                  print(e);
                }
              },),


              Platform.isIOS ?
              Container(
                width: 100,

                child: paddingButton(Color(0xff01937C), 'Face ID', () async{
                  _authenticateWithBiometrics();
        }

    ),
              ) :
                  SizedBox(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${S.of(context).dontHaveAccount}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),),
                  TextButton(onPressed: (){

                    Navigator.push( (context),
                        MaterialPageRoute(
                            builder: (BuildContext context) => RegistrationScreen()));


                  }, child: Text('${S.of(context).signUp}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff01937C),
                        fontSize: 15
                    ),))
                ],
              ),


            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
