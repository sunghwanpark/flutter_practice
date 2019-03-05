import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bunyang/MainMenu/SnapMenu.dart';
import 'package:bunyang/Util/Util.dart';

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

class MainPage extends StatefulWidget
{
  @override
  MainPageState createState() => new MainPageState();
}

class MainPageState extends State<MainPage>
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(body : SnapMenu());
  }
}