import 'dart:io' show Platform;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ReceivedNotification 
{
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification
  (
    {
      @required this.id,
      @required this.title,
      @required this.body,
      @required this.payload,
    }
  );
}

class NotificationManager
{
  static final NotificationManager _instance = NotificationManager._internal();
  factory NotificationManager() => _instance;

  NotificationManager._internal();
  
  final StreamController<ReceivedNotification> _didReceiveLocalNotificationSubject
    = StreamController<ReceivedNotification>();

  final StreamController<String> _selectNotificationSubject
    = StreamController<String>();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

  NotificationAppLaunchDetails _notificationAppLaunchDetails;

  Future<void> initialize() async
  {
    WidgetsFlutterBinding.ensureInitialized();

    if(Platform.isIOS)
    {
      _requestIOSPermissions();
    }
    await _initializeStream();
    _configureDidReceiveLocalNotification();
    _configureSelectNotificationSubject();
  }

  void _requestIOSPermissions() 
  {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> _initializeStream() async
  {
    _notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification:
        (int id, String title, String body, String payload) async 
        {
          _didReceiveLocalNotificationSubject.add
          (
            ReceivedNotification
            (
              id: id,
              title: title,
              body: body,
              payload: payload
            )
          );
        });
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
      
    await flutterLocalNotificationsPlugin.initialize
    (
      initializationSettings,
      onSelectNotification: (String payload) async 
      {
        if (payload != null) 
        {
          debugPrint('notification payload: ' + payload);
        }
        _selectNotificationSubject.add(payload);
      }
    );
  }

  void _configureDidReceiveLocalNotification()
  {
    _didReceiveLocalNotificationSubject.stream.listen((onData)
    {
      
    });
  }

  void _configureSelectNotificationSubject()
  {
    _selectNotificationSubject.stream.listen((onData)
    {

    });
  }

  void dispose()
  {
    _didReceiveLocalNotificationSubject.close();
    _selectNotificationSubject.close();
  }

  Future<void> subScribeNotification(int id, String title, String body, DateTime scheduleDate) async
  {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(id, title, body, scheduleDate, platformChannelSpecifics);
  }

  Future<void> cancelSubscribeNotification(int id) async
  {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<bool> isSubscribeNotification(int id) async
  {
    return flutterLocalNotificationsPlugin.pendingNotificationRequests()
      .then((lst)
      {
        bool bFind = false;
        lst.forEach((elem)
        {
          if(elem.id == id)
          {
            bFind = true;
          }
        });

        return bFind;
      })
      .catchError((onError)
      {
        print(onError);
        return false;
      });
  }
}