import "package:flutter/material.dart";
import 'package:url_launcher/url_launcher.dart';

enum LoadingState { DONE, LOADING, WAITING, ERROR }

Text myText(String str, [Color textColor = Colors.black, double _fontSize = 20.0])
{
  return new Text
  (
    str,
    style: TextStyle
    (
      color: textColor,
      fontSize: _fontSize,
      fontFamily: "TmonTium",
      fontWeight: FontWeight.w500
    ),
  );
}

String getDateFormat(String dateString)
{
  if(dateString.isEmpty)
    return '';
    
  StringBuffer sb = new StringBuffer();
  sb.write(dateString.substring(0, 4));
  sb.write('.');
  sb.write(dateString.substring(4, 6));
  sb.write('.');
  sb.write(dateString.substring(6, 8));

  return sb.toString();
}

String getYearMonthFormat(String dateString)
{
  if(dateString.isEmpty)
    return '';
    
  StringBuffer sb = new StringBuffer();
  sb.write(dateString.substring(0, 4));
  sb.write('.');
  sb.write(dateString.substring(4, 6));

  return sb.toString();
}

String getDateFormatkr(String dateString)
{
  StringBuffer sb = new StringBuffer();
  sb.write(dateString.substring(0, 4));
  sb.write('월');
  sb.write(dateString.substring(4, 6));
  sb.write('일');

  return sb.toString();
}

launchURL(String url) async 
{
  if (await canLaunch(url)) 
  {
    await launch(url);
  } 
  else 
  {
    throw 'Could not launch $url';
  }
}