import 'package:flutter/material.dart';

ThemeData lightTheme() => ThemeData(
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.white10,
    titleTextStyle: TextStyle(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.black45,
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  )
);