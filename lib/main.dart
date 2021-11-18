import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/Provider/dark_them.dart';
import 'package:flash_chat/screens/home_screen.dart';
import 'package:flash_chat/screens/settings_screen.dart';
import 'package:flash_chat/them/darkThem.dart';
import 'package:flash_chat/them_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/register_user_info.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flash_chat/notification/notificationAPI.dart';
import 'Provider/language_change_provider.dart';
import 'generated/l10n.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;


void main() async{
  tz.initializeTimeZones();
  runApp(Masarifii());
}

class Masarifii extends StatefulWidget {


  @override
  _MasarifiiState createState() => _MasarifiiState();
}

class _MasarifiiState extends State<Masarifii> {
 DarkThemProvider themChangeProvider = DarkThemProvider();
 LanguageChangeProvider languageChangeProvider = LanguageChangeProvider();
 SharedPreferences preferences;
  void getCurrentAppThem() async {
    themChangeProvider.setDarkThem(await themChangeProvider.darkThemePreferences.getTheme());
  }
  void getCurrentLanguage() async {
    preferences = await SharedPreferences.getInstance();
    languageChangeProvider.changeLocale(preferences.getString('language'));
  }



  User loggedUser;

  @override
  void initState() {
    getCurrentAppThem();
    getCurrentLanguage();

    NotificationApi.init(initScheduled: true);
    listenNotifications();
    super.initState();
  }

  StreamSubscription<String> listenNotifications(){
    return NotificationApi.onNotifications.stream.listen((onClickedNotification));
  }

void onClickedNotification(String t){
  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(
      loggedUser
  )));
}


  @override
  Widget build(BuildContext context) {
    User loggedUser;
    QueryDocumentSnapshot userInfo;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_){
          return themChangeProvider;
        }
        ),
        ChangeNotifierProvider(create: (context){
          return languageChangeProvider;
        })
      ],

    child: Consumer<DarkThemProvider>(

      builder: (context, themData,child) {
        return MaterialApp(
          locale: Provider.of<LanguageChangeProvider>(context, listen: true).currentLocale,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
           Locale('en'), Locale('ar')
          ],

          theme: Styles.themeData(themChangeProvider.getDarkTheme(), context),
          initialRoute: WelcomeScreen.id,
          routes: {
            WelcomeScreen.id: (context) => WelcomeScreen(),
            LoginScreen.id: (context) => LoginScreen(),
            RegistrationScreen.id: (context) => RegistrationScreen(),
            ChatScreen.id: (context) => ChatScreen(),
            RegisterUserInfo.id: (context) => RegisterUserInfo(),
            HomeScreen.id: (context) => HomeScreen(loggedUser),
            SettingScreen.id: (context) => SettingScreen(userInfo)

          },
        );
      }
    ));
  }
}
