import 'package:flutter/material.dart';



  class Styles{

    static ThemeData themeData(bool isDarkThem , BuildContext context){

      if(isDarkThem)
      return ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey.shade900,



      );


      else
        return ThemeData.light().copyWith(
          scaffoldBackgroundColor: Color(0xfff2f3f4),
          backgroundColor: Colors.white
        );





    }



  }