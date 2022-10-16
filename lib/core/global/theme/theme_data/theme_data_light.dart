import 'package:flutter/material.dart';

ThemeData getThemeDataLight(BuildContext context) => ThemeData(
  primaryColor:const Color.fromRGBO(0, 167, 131, 1) ,
  appBarTheme: const AppBarTheme(
    titleSpacing: -10,
    centerTitle: false,
    backgroundColor:  Color.fromRGBO(5, 96, 98, 1),
    elevation: 0,
    brightness: Brightness.light,

    iconTheme:  IconThemeData(
      color: Colors.white,
    ),
  ),
    textTheme: const TextTheme(
      displaySmall: TextStyle(color: Color.fromRGBO(0, 167, 131, 1),fontSize: 15,fontWeight: FontWeight.bold),
      //
      displayMedium: TextStyle(color: Colors.black87, fontSize: 15,),
      //
      displayLarge: TextStyle(fontWeight: FontWeight.w600, fontSize: 33, color: Color.fromRGBO(0, 167, 131, 1)),
      //
      bodySmall: TextStyle(color: Colors.black, fontSize: 15,),
      //
      bodyMedium:  TextStyle(color: Colors.black, fontSize: 15, fontWeight:FontWeight.bold),

    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary:const Color.fromRGBO(0, 167, 131, 1),
        minimumSize: const Size(0.5, 50),
      ),
    ),
inputDecorationTheme: InputDecorationTheme(
hintStyle: Theme.of(context).textTheme.bodyMedium,
),
  floatingActionButtonTheme:const FloatingActionButtonThemeData(
    backgroundColor: Color.fromRGBO(0, 167, 131, 1),

  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(

    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  listTileTheme: ListTileThemeData(

  ),
);
