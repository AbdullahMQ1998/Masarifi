import 'package:flash_chat/models/dark_them_prefrence.dart';
import 'package:flutter/material.dart';


class DarkThemProvider with ChangeNotifier{
DarkThemePreferences darkThemePreferences = DarkThemePreferences();

  bool _darkTheme = false;

  bool getDarkTheme() {

    return _darkTheme;

}

  void setDarkThem(bool value){

  _darkTheme = value;
  darkThemePreferences.setDarkThem(value);
  notifyListeners();
  }


}