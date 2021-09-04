import 'dart:convert';

import 'package:fit_shortcuts/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FIT Subject Shortcuts', 
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: Banner(
        location: BannerLocation.topEnd,
        message: 'FIT 18',
        textStyle: TextStyle(color: Colors.black),
        color: Colors.amber,
        child: MainScreen(), 
      ),
    );
  }
}
