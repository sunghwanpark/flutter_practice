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

  @protected
  final Map<String, List<Map<String, String>>> defaultData = new Map<String, List<Map<String, String>>>();
  final List<List<Map<String, String>>> _typeofHouseData = new List<List<Map<String, String>>>();
  final List<List<Map<String, String>>> _typeofHouseDataAttachment = new List<List<Map<String, String>>>();

  @protected
  int tabLen = 0;

  @override
  void makePresenter() 
  {
    presenter = new InstallmentChangeSalePresenter(this);
    (presenter as InstallmentChangeSalePresenter).onRequestDetail(type, panId, ccrCnntSysDsCd);
  }

  @override
  void dispose()
  {
    super.dispose();
    defaultData.clear();
    _typeofHouseData.clear();
    _typeofHouseDataAttachment.clear();
  }

  void onResponseDetail(Map<String, List<Map<String, String>>> res)
  {
    defaultData.clear();
    defaultData.addAll(res);
    contents[InstallmentTabState.Contents.index].add(ChargeSaleSummaryInfoView(defaultData));
    contents[InstallmentTabState.Schedule.index].add(ChargeScheduleView(defaultData));

    res["dsSbdInf"].forEach((map)
    {
      (presenter as InstallmentChangeSalePresenter).onRequestHouseType(
        panId, ccrCnntSysDsCd, map["SBD_LGO_NO"], map["LTR_NOT"], map["LTR_UNT_NO"], map["SN"]);
    });

    tabLen = res["dsSbdInf"].length;
  }

  void onResponseHouseType(Map<String, List<Map<String, String>>> res)
  {
    _typeofHouseData.add(res["dsHtyInf"].length > 0 ? res["dsHtyInf"] : null);
  }

  void onResponseHouseAttatchment(Map<String, List<Map<String, String>>> res)
  {
    _typeofHouseDataAttachment.add(res["dsSdbAhflInf"].length > 0 ? res["dsSdbAhflInf"] : null);

    if(_typeofHouseData.length == tabLen && _typeofHouseDataAttachment.length == tabLen)
    {
      if(tabLen == 1)
      {
        contents[InstallmentTabState.Infos.index].add(ChargeSupplyInfoView
        (
          defaultData["dsSbdInf"].first,
          _typeofHouseData.first,
          _typeofHouseDataAttachment.first
        ));
      }
      else
      {
        contents[InstallmentTabState.Infos.index].add(WidgetInsideTabBar
        (
          tabNames: defaultData["dsSbdInf"].map((map) => map['LCC_NT_NM']).toList(),
          contents: List<Widget>.generate(tabLen, (index)
          {
            return ChargeSupplyInfoView
            (
              defaultData['dsSbdInf'].elementAt(index),
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
  void onPressedNotification()
  {
    
  }

  @override
  void onResponseSuccessPanInfo(Map<String, String> panInfo) {}
}
