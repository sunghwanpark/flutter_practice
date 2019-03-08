import 'package:flutter/material.dart';
import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/MenuItem/Land/LandPage.dart';
import 'package:bunyang/Data/ListItem.dart';
import 'package:bunyang/Util/Util.dart';

class ItemWidgetFactory
{
  static Widget buildItemWidget(ListItem item)
  {
    switch (item.type)
    {
      case Notice_Code.land:
        return LandPage(item, item.panName);
      default:
        return MyText('아직 개발중이야~');
    }
  }
}