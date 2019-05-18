import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/MenuItemPageView.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum InstallmentTabState
{
  Contents,
  Infos,
  Schedule
}

abstract class AbstractInstallmentHouse extends MenuItemPage
{
  AbstractInstallmentHouse(MenuData data) : super(data);

  @override
  State<StatefulWidget> createState() {
    return super.createState();
  }
}

abstract class AbstractInstallmentHouseView<T extends AbstractInstallmentHouse> extends MenuItemPageView<T>
{
  AbstractInstallmentHouseView(MenuData data) : super(data)
  {
    uppAisTpCd = this.data.getUppAisTPCD();
    
    tabNames = ['공고내용', '공급정보', '공고일정'];

    for(int i = 0; i < InstallmentTabState.values.length; i++)
    {
      contents[i] = new List<Widget>();
    }
  }

  @protected
  String uppAisTpCd;
}
