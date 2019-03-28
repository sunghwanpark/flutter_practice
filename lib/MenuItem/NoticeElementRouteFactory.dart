import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/Land/LandPageView.dart';
import 'package:flutter/material.dart';
import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Util/Util.dart';

class NoticeElementRouteFactory
{
  static Widget buildElement(MenuData item)
  {
    switch (item.type)
    {
      case Notice_Code.land:
        return LandPage(item.type, item.getParameter("PAN_ID"), item.getParameter("CCR_CNNT_SYS_DS_CD"), item.panName);
      default:
        return myText('아직 개발중이야~');
    }
  }
}