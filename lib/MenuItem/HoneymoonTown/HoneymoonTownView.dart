import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/HoneymoonTown/HoneymoonTownPresenter.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/Abstract/AbstractInstallmentHouseView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/SummaryInfoView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/SupplyInfoView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/SupplyScheduleView.dart';
import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:bunyang/Util/WidgetInsideTabBarView.dart';
import 'package:flutter/material.dart';

class HoneymoonTownView extends AbstractInstallmentHouse
{
  HoneymoonTownView(MenuData data) : super(data);
  
  @override
  HoneymoonTownWidget createState() => HoneymoonTownWidget(data);
}

class HoneymoonTownWidget extends AbstractInstallmentHouseView<HoneymoonTownView>
{
  HoneymoonTownWidget(MenuData data) : super(data);

  String _otxtPanId;

  final Map<String, Map<String, String>> _defaultData = new Map<String, Map<String, String>>();
  final Map<String, List<Map<String, String>>> _detailData = new Map<String, List<Map<String, String>>>();
  final Map<String, List<Map<String, String>>> _imageDatas = new Map<String, List<Map<String, String>>>();

  @override
  void onResponseSuccessPanInfo(Map<String, String> panInfo) 
  {
    _otxtPanId = panInfo["OTXT_PAN_ID"];
    (presenter as HoneymoonTownPresenter).onRequestDefault(panId, ccrCnntSysDsCd, _otxtPanId, uppAisTpCd);
  }

  @override
  void makePresenter()
  {
    presenter = HoneymoonTownPresenter(this);
    presenter.onRequestPanInfo(data.type, RequestPanInfo(panId, ccrCnntSysDsCd, uppAisTpCd));
  }

  void onResponseDetail(Map<String, List<Map<String, String>>> res)
  {
    _defaultData.clear();

    contents[InstallmentTabState.Contents.index].add(SummaryInfoView(res["dsHsSlpa"].first, res["dsAhflList"]));
    contents[InstallmentTabState.Schedule.index].add(SupplyScheduleView(res));

    if(res["dsHsAisList"].length > 0)
    {
      res["dsHsAisList"].forEach((map)
      {
        _defaultData[map['AIS_INF_SN']] = map;

        (presenter as HoneymoonTownPresenter).onRequestDetail(
          panId, ccrCnntSysDsCd, _otxtPanId, uppAisTpCd, map['AIS_INF_SN']);

        (presenter as HoneymoonTownPresenter).onRequestAttachment(
          panId, ccrCnntSysDsCd, _otxtPanId, uppAisTpCd, map['AIS_INF_SN'], _defaultData[map['AIS_INF_SN']]['BZDT_CD'], _defaultData[map['AIS_INF_SN']]['HC_BLK_CD']);
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

  void onResponseDetailData(String aisInfSn, Map<String, List<Map<String, String>>> res)
  {
    _detailData[aisInfSn] = res["dsHtyList"];

    if(_defaultData.length == _imageDatas.length && _defaultData.length == _detailData.length)
    {
      onLoadComplete();
    }
  }

  void onResponseAttachment(String aisInfSn, Map<String, List<Map<String, String>>> res)
  {
    _imageDatas[aisInfSn] = res["dsHsAhtlList"];

    if(_defaultData.length == _imageDatas.length && _defaultData.length == _detailData.length)
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
        null,
        null,
        null,
        _detailData.values.first,
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
            null,
            null,
            null,
            _detailData.values.elementAt(index),
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