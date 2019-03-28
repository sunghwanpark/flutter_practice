import "package:flutter/material.dart";

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