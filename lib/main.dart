import 'package:flutter/material.dart';
import 'package:flutter_app7/modules/login_module/login_screen.dart';
import 'package:flutter_app7/shared/styles/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      home: LoginScreen(),
    );
  }
}