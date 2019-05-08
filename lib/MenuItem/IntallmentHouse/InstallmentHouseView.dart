import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/InstallmentHousePresenter.dart';
import 'package:bunyang/MenuItem/Land/LandPagePresenter.dart';
import 'package:bunyang/MenuItem/MenuItemPageView.dart';
import 'package:flutter/material.dart';
import 'package:bunyang/Util/Util.dart';

class InstallmentHousePage extends MenuItemPage
{
  InstallmentHousePage(MenuData data) : super(data);

  @override
  InstallmentHouseView createState() => InstallmentHouseView(data);
}

class InstallmentHouseView extends MenuItemPageView<InstallmentHousePage> 
{
  InstallmentHouseView(MenuData data) : super(data);

  InstallmentHousePresenter _presenter;
  
  LoadingState loadingState = LoadingState.LOADING;
  
  List<Widget> _contents = new List<Widget>();

  @override
  void initState() 
  {
    super.initState();
    _presenter = new InstallmentHousePresenter(this);
  }
}
