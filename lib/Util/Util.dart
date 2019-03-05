import "package:flutter/material.dart";

Text MyText(String str, [Color textColor = Colors.white, double _fontSize = 20.0])
{
  return new Text
  (
    str,
    style: TextStyle
    (
      color: textColor,
      fontSize: _fontSize,
      fontFamily: "TmonTium"
    )
  );
}