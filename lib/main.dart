import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app7/layout/home_layout.dart';
import 'package:flutter_app7/modules/login_module/login_screen.dart';
import 'package:flutter_app7/shared/components/constants.dart';
import 'package:flutter_app7/shared/network/local/cache_helper.dart';
import 'package:flutter_app7/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();

  Widget widget = LoginScreen();
  if(await CacheHelper.getshared(key: 'uid') != null){
    uid = await CacheHelper.getshared(key: 'uid');
    widget = HomeLayout();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget widget;

  MyApp(this.widget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      home: widget,
    );
  }
}