import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/Abstract/AbstractInstallmentHouseView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/InstallmentHousePresenter.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/SummaryInfoView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/SupplyInfoView.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:bunyang/Util/WidgetInsideTabBarView.dart';
import 'package:flutter/material.dart';

import 'SupplyScheduleView.dart';

class InstallmentHousePage extends AbstractInstallmentHouse
{
  InstallmentHousePage(MenuData data) : super(data);

  @override
  InstallmentHouseView createState() => InstallmentHouseView(data);
}

class InstallmentHouseView extends AbstractInstallmentHouseView<InstallmentHousePage>
{
  InstallmentHouseView(MenuData data) : super(data);

  String _otxtPanId;

  final Map<String, Map<String, String>> _defaultData = new Map<String, Map<String, String>>();
  final Map<String, List<Map<String, String>>> _publicInstallment = new Map<String, List<Map<String, String>>>();
  final Map<String, List<Map<String, String>>> _publicLease = new Map<String, List<Map<String, String>>>();
  final Map<String, List<Map<String, String>>> _publicInstallmentLease = new Map<String, List<Map<String, String>>>();
  final Map<String, List<Map<String, String>>> _imageDatas = new Map<String, List<Map<String, String>>>();

  @override
  void makePresenter()
  {
    presenter = new InstallmentHousePresenter(this);
    presenter.onRequestPanInfo(type, {"PAN_ID" : panId, "CCR_CNNT_SYS_DS_CD" : ccrCnntSysDsCd, "UPP_AIS_TP_CD": uppAisTpCd, "PREVIEW" : "N"});
  }

  @override
  void dispose()
  {
    super.dispose();

    _defaultData.clear();
    _publicInstallment.clear();
    _publicLease.clear();
    _publicInstallmentLease.clear();
  }

  @override
  void onResponseSuccessPanInfo(Map<String, String> panInfo) 
  {
    _otxtPanId = panInfo["OTXT_PAN_ID"];
    (presenter as InstallmentHousePresenter).onRequestDetail(type, panId, ccrCnntSysDsCd, _otxtPanId, uppAisTpCd);
  }

  void onResponseDetail(Map<String, List<Map<String, String>>> res)
  {
    contents[InstallmentTabState.Contents.index].add(SummaryInfoView(res["dsHsSlpa"].first, res["dsAhflList"]));
    contents[InstallmentTabState.Schedule.index].add(SupplyScheduleView(res));

    if(res["dsHsAisList"].length > 0)
    {
      res["dsHsAisList"].forEach((map)
      {
        _defaultData[map['AIS_INF_SN']] = map;

        (presenter as InstallmentHousePresenter).onRequestSupplyInfoPublicInstallment(
          panId, ccrCnntSysDsCd, map['AIS_INF_SN'], _otxtPanId, uppAisTpCd, onResponsePublicInstallment);
        
        (presenter as InstallmentHousePresenter).onRequestSupplyInfoPublicInstallment(
          panId, ccrCnntSysDsCd, map['AIS_INF_SN'], _otxtPanId, "06", onResponsePublicRentalType06, true, false);

        (presenter as InstallmentHousePresenter).onRequestSupplyInfoPublicInstallment(
          panId, ccrCnntSysDsCd, map['AIS_INF_SN'], _otxtPanId, "06", onResponsePublicRentalType07, false, true);

        (presenter as InstallmentHousePresenter).onRequestSupplyInfoImage(
          panId, ccrCnntSysDsCd, map['AIS_INF_SN'], _otxtPanId, uppAisTpCd, onResponseFinally, _defaultData[map['AIS_INF_SN']]['BZDT_CD'], _defaultData[map['AIS_INF_SN']]['HC_BLK_CD']);
      });
    }
    else
    {
      contents[InstallmentTabState.Infos.index].add(SizedBox());
      setState(() {
        loadingState = LoadingState.DONE;
      });
    }
  }

  void onResponsePublicInstallment(String aisInfSn, Map<String, List<Map<String, String>>> res)
  {
    _publicInstallment[aisInfSn] = res["dsHtyList"];

    if(_defaultData.length == _imageDatas.length && _defaultData.length == _publicInstallment.length &&
    _defaultData.length == _publicLease.length && _defaultData.length == _publicInstallmentLease.length)
    {
      onLoadComplete();
    }
  }

  void onResponsePublicRentalType06(String aisInfSn, Map<String, List<Map<String, String>>> res)
  {
    _publicLease[aisInfSn] = res["dsHtyList"];

    if(_defaultData.length == _imageDatas.length && _defaultData.length == _publicInstallment.length &&
    _defaultData.length == _publicLease.length && _defaultData.length == _publicInstallmentLease.length)
    {
      onLoadComplete();
    }
  }

  void onResponsePublicRentalType07(String aisInfSn, Map<String, List<Map<String, String>>> res)
  {
    _publicInstallmentLease[aisInfSn] = res["dsHtyList"];

    if(_defaultData.length == _imageDatas.length && _defaultData.length == _publicInstallment.length &&
    _defaultData.length == _publicLease.length && _defaultData.length == _publicInstallmentLease.length)
    {
      onLoadComplete();
    }
  }

  void onResponseFinally(String aisInfSn, Map<String, List<Map<String, String>>> res)
  {
    _imageDatas[aisInfSn] = res["dsHsAhtlList"];

    if(_defaultData.length == _imageDatas.length && _defaultData.length == _publicInstallment.length &&
    _defaultData.length == _publicLease.length && _defaultData.length == _publicInstallmentLease.length)
    {
      onLoadComplete();
    }
  }

  void onLoadComplete()
  {
    if(_defaultData.length == 1)
    {
      contents[InstallmentTabState.Infos.index].add(SupplyInfoView
      (
        uppAisTpCd,
        _defaultData.values.first,
        _publicInstallment.values.first,
        _publicLease.values.first,
        _publicInstallmentLease.values.first,
        null,
        _imageDatas.values.first)
      );
    }
    else
    {
      contents[InstallmentTabState.Infos.index].add(WidgetInsideTabBar
      (
        tabNames: _defaultData.values.map((k) => k['BZDT_NM']).toList(),
        contents: List<Widget>.generate(_defaultData.length, (index)
        {
          return SupplyInfoView
          (
            uppAisTpCd,
            _defaultData.values.elementAt(index),
            _publicInstallment.values.elementAt(index),
            _publicLease.values.elementAt(index),
            _publicInstallmentLease.values.elementAt(index),
            null,
            _imageDatas.values.elementAt(index)
          );
        })
      ));
    }

    setState(() {
      loadingState = LoadingState.DONE;
    });
  }
}
