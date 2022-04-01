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
);