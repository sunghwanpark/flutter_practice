import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_practice/MainMenu/MainMenu.dart';
import 'package:flutter_practice/Data/CachingData.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp
    (
      title: 'Flutter Demo',
      theme: ThemeData
      (
        backgroundColor: Color.fromARGB(255, 0, 255, 0),
        scaffoldBackgroundColor: Color.fromARGB(255, 0, 255, 0)
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(appBar: new AppBar(title: new Text("test")), body : MainMenu());
  }
}