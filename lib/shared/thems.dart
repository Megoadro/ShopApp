import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.pink,
  scaffoldBackgroundColor: Colors.white,
  // ال theme  اللي هيمشي علي AppBar بس
  appBarTheme:const AppBarTheme(
    // color for statusBar
     systemOverlayStyle: SystemUiOverlayStyle(
       statusBarColor: Colors.white,
       statusBarIconBrightness: Brightness.dark,
     ),
    // ال theme  اللي هيمشي علي Icon بس
      iconTheme:  IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      elevation: 0.0,
      // ال theme  اللي هيمشي علي text بس
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      )),
  // ال theme  اللي هيمشي علي BNB بس
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.pink,
    elevation: 90.0,
  ),
  textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontFamily: 'Jannah'
      )),

);
 ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
   primarySwatch: Colors.deepOrange,
   // ال theme  اللي هيمشي علي AppBar بس
   appBarTheme: const AppBarTheme(
     // ال theme  اللي هيمشي علي Icon بس
       iconTheme: IconThemeData(color: Colors.white),
       backgroundColor: Colors.black45,
       elevation: 0.0,
       // ال theme  اللي هيمشي علي text بس
       titleTextStyle: TextStyle(
         color: Colors.white,
         fontSize: 20,
         fontWeight: FontWeight.bold,
       )),
   // ال theme  اللي هيمشي علي BNB بس
   bottomNavigationBarTheme: const BottomNavigationBarThemeData(
     type: BottomNavigationBarType.fixed,
     selectedItemColor: Colors.deepOrange,
     elevation: 90.0,

     backgroundColor: Colors.black45,
     unselectedItemColor: Colors.grey,
   ),
   textTheme:const TextTheme(
       bodyText1: TextStyle(
         fontSize: 18,
         fontWeight: FontWeight.w600,
         color: Colors.white,
       )),
 );