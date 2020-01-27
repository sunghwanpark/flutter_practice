import 'dart:async';

import 'package:bunyang/Data/OrganizationCode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Splash extends StatefulWidget
{
  @override
  SplashWidget createState() => SplashWidget();
}

class SplashWidget extends State<Splash>
{
  @override
  void initState()
  {
    super.initState();
    startTimer();
  }

  @override
  void dispose()
  {
    OrganizationCode().parseXmlFromAssets();
    super.dispose();
  }

  Future<Timer> startTimer() async
  {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() 
  {
    Navigator.of(context).pushReplacementNamed('/SnapMenu');
  }

  @override
  Widget build(BuildContext context) 
  {
    return new Scaffold
    (
      backgroundColor: Colors.green,
      body: Center
      (
        child: Text('LH 분양공고', style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'TmonTium', fontWeight: FontWeight.w700))
      )
    );
  }
}