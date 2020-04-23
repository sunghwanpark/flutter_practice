import 'package:bunyang/Splash/Splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bunyang/Menu/SnapMenu.dart';
import 'package:bunyang/Notification/NotificationManager.dart';

void main()
{
  NotificationManager().initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp
    (
      home: Splash(),
      routes: <String, WidgetBuilder>
      {
        '/SnapMenu': (BuildContext context) => SnapMenu()
      }
    );
  }
}
