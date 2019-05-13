import 'package:bunyang/Data/OrganizationCode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bunyang/Menu/SnapMenu.dart';

void main()
{
  OrganizationCode().parseXmlFromAssets();
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
      home: Scaffold(body : SnapMenu())
    );
  }
}
