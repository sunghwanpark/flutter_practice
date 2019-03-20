import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bunyang/Menu/SnapMenu.dart';

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
      title: '안녕? 분양',
      theme: ThemeData
      (
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        fontFamily: "TmonTium"
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
    return Scaffold(body : SnapMenu());
  }
}