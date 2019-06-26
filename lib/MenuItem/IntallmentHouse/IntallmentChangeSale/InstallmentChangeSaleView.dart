import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/Abstract/AbstractInstallmentHouseView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/IntallmentChangeSale/ChargeSaleSummaryInfoView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/IntallmentChangeSale/ChargeScheduleView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/IntallmentChangeSale/ChargeSupplyInfoView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/IntallmentChangeSale/InstallmentChangeSalePresenter.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:bunyang/Util/WidgetInsideTabBarView.dart';
import 'package:flutter/material.dart';

class InstallmentChangeSale extends AbstractInstallmentHouse
{
  InstallmentChangeSale(MenuData data) : super(data);

  @override
  InstallmentChangeSaleView createState() => InstallmentChangeSaleView(data);
}

class InstallmentChangeSaleView extends AbstractInstallmentHouseView<InstallmentChangeSale>
{
  InstallmentChangeSaleView(MenuData data) : super(data);

  final Map<String, List<Map<String, String>>> _defaultData = new Map<String, List<Map<String, String>>>();
  final List<List<Map<String, String>>> _typeofHouseData = new List<List<Map<String, String>>>();
  final List<List<Map<String, String>>> _typeofHouseDataAttachment = new List<List<Map<String, String>>>();

  int _tabLen = 0;

  @override
  void initState() 
  {
    super.initState();
    request();
  }

  @protected
  void request()
  {
    presenter = new InstallmentChangeSalePresenter(this);
    (presenter as InstallmentChangeSalePresenter).onRequestDetail(type, panId, ccrCnntSysDsCd);
  }

  @override
  void dispose()
  {
    super.dispose();
    _defaultData.clear();
    _typeofHouseData.clear();
    _typeofHouseDataAttachment.clear();
  }

  void onResponseDetail(Map<String, List<Map<String, String>>> res)
  {
    _defaultData.clear();
    _defaultData.addAll(res);
    contents[InstallmentTabState.Contents.index].add(ChargeSaleSummaryInfoView(_defaultData));
    contents[InstallmentTabState.Schedule.index].add(ChargeScheduleView(_defaultData));

    res["dsSbdInf"].forEach((map)
    {
      (presenter as InstallmentChangeSalePresenter).onRequestHouseType(
        panId, ccrCnntSysDsCd, map["SBD_LGO_NO"], map["LTR_NOT"], map["LTR_UNT_NO"], map["SN"]);
    });

    _tabLen = res["dsSbdInf"].length;
  }

  void onResponseHouseType(Map<String, List<Map<String, String>>> res)
  {
    _typeofHouseData.add(res["dsHtyInf"].length > 0 ? res["dsHtyInf"] : null);
  }

  void onResponseHouseAttatchment(Map<String, List<Map<String, String>>> res)
  {
    _typeofHouseDataAttachment.add(res["dsSdbAhflInf"].length > 0 ? res["dsSdbAhflInf"] : null);

    if(_typeofHouseData.length == _tabLen && _typeofHouseDataAttachment.length == _tabLen)
    {
      if(_tabLen == 1)
      {
        contents[InstallmentTabState.Infos.index].add(ChargeSupplyInfoView
        (
          _defaultData["dsSbdInf"].first,
          _typeofHouseData.first,
          _typeofHouseDataAttachment.first
        ));
      }
      else
      {
        contents[InstallmentTabState.Infos.index].add(WidgetInsideTabBar
        (
          tabNames: _defaultData["dsSbdInf"].map((map) => map['LCC_NT_NM']).toList(),
          contents: List<Widget>.generate(_tabLen, (index)
          {
            return ChargeSupplyInfoView
            (
              _defaultData['dsSbdInf'].elementAt(index),
              _typeofHouseData.elementAt(index),
              _typeofHouseDataAttachment.elementAt(index)
            ); 
          }),
        ));
      }

      setState(() {
       loadingState = LoadingState.DONE; 
      });
    }
  }

  @override
  void onResponseSuccessPanInfo(Map<String, String> panInfo) {}
}
