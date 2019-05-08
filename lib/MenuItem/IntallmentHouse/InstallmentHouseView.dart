import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/InstallmentHousePresenter.dart';
import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:bunyang/MenuItem/MenuItemPageView.dart';
import 'package:flutter/material.dart';

class InstallmentHousePage extends MenuItemPage
{
  InstallmentHousePage(MenuData data) : super(data);

  @override
  InstallmentHouseView createState() => InstallmentHouseView(data);
}

class InstallmentHouseView extends MenuItemPageView<InstallmentHousePage> 
{
  InstallmentHouseView(MenuData data) : super(data)
  {
    _uppAisTpCd = this.data.getUppAisTPCD();
  }

  String _uppAisTpCd;

  List<Widget> _contents = new List<Widget>();

  @override
  void initState() 
  {
    super.initState();
    presenter = new InstallmentHousePresenter(this);
    presenter.onRequestPanInfo(type, RequestPanInfo(pan_id, ccr_cnnt_sys_ds_cd, _uppAisTpCd));
  }

  @override
  void onResponseSuccessPanInfo(PanInfo panInfo) {
  }
}
