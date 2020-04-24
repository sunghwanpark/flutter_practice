
import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/SummaryInfoView.dart';
import 'package:bunyang/MenuItem/MenuItemPageView.dart';
import 'package:bunyang/MenuItem/Store/Evaluation/StoreEvaluationPresenter.dart';
import 'package:bunyang/MenuItem/Store/StoreCommonNotifyView.dart';
import 'package:bunyang/MenuItem/Store/StoreCommonScheduleView.dart';
import 'package:bunyang/MenuItem/Store/StoreCommonSupplyData.dart';
import 'package:bunyang/MenuItem/Store/StoreCommonSupplyView.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:bunyang/Util/WidgetInsideTabBarView.dart';
import 'package:flutter/material.dart';

enum StoreEvaluationTab { Contents, Infos, Schedule }

class StoreEvaluationView extends MenuItemPage
{
  StoreEvaluationView(MenuData data) : super(data);
  
  @override
  StoreEvaluationViewWidget createState() => StoreEvaluationViewWidget(data);
}

class StoreEvaluationViewWidget extends MenuItemPageView<StoreEvaluationView>
{
  StoreEvaluationViewWidget(MenuData data) : super(data)
  {
    tabNames = ['공고내용', '공급정보', '공고일정'];

    for(int i = 0; i < StoreEvaluationTab.values.length; i++)
    {
      contents[i] = new List<Widget>();
    }
  }

  StoreEvaluationPresenter _presenter;

  Map<String, String> _defaultDatas;
  List<Map<String, String>> _attachmentDatas;
  Map<String, StoreCommonSupplyData> _supplyDatas = new Map<String, StoreCommonSupplyData>();

  @override
  void makePresenter() 
  {
    _presenter = StoreEvaluationPresenter(this);
    _presenter.onRequestData({"PAN_ID" : this.panId, "CCR_CNNT_SYS_DS_CD" : this.ccrCnntSysDsCd, "PAN_GBN" : "LS_SST"});
  }

  void onResponseData(Map<String, List<Map<String, String>>> res)
  {
    _defaultDatas = res['dsSstInf'].first;
    _attachmentDatas = res['dsLsSstAhflList'];

    if(res["dsSdgList"].length > 0)
    {
      res["dsSdgList"].forEach((map)
      {
        String key = map['SBD_NM'];
        _supplyDatas[key] = StoreCommonSupplyData();
        _supplyDatas[key].defaultData = map;

        _presenter.onRequestSupplyData({'PAN_ID' : panId, 'CCR_CNNT_SYS_DS_CD' : ccrCnntSysDsCd, 'SBD_NM' : key});
      });
    }
    else
    {
      checkComplete();
    }
  }

  void onResponseSupplyData(Map<String, List<Map<String, String>>> res, String key)
  {
    _supplyDatas[key].supplyDatas = res['dsSstDhgList'];
    var completeChecker = _supplyDatas.values.takeWhile((v) => v.supplyDatas != null);

    if(_supplyDatas.length == completeChecker.length)
      checkComplete();
  }

  void checkComplete()
  {
    if(_supplyDatas != null && _supplyDatas.length > 0)
    {
      contents[StoreEvaluationTab.Contents.index].add(SummaryInfoView(_defaultDatas, _attachmentDatas, serialKey: 'AHFL_RGS_SN'));
      contents[StoreEvaluationTab.Infos.index].add(WidgetInsideTabBar
      (
        tabNames: List<String>.from(_supplyDatas.keys),
        contents: List<Widget>.generate(_supplyDatas.length, (index)
        {
          return StoreCommonSupplyView(_supplyDatas.entries.elementAt(index).value);
        })
      ));
      contents[StoreEvaluationTab.Schedule.index].add(StoreCommonScheduleView(_defaultDatas));
      contents[StoreEvaluationTab.Schedule.index].add(StoreCommonNotifyView(_defaultDatas));

      setState(() {
        loadingState = LoadingState.DONE;
      });
    }
    else
    {
      contents[StoreEvaluationTab.Contents.index].add(SummaryInfoView(_defaultDatas, _attachmentDatas, serialKey: 'AHFL_RGS_SN'));
      contents[StoreEvaluationTab.Schedule.index].add(StoreCommonScheduleView(_defaultDatas));
      contents[StoreEvaluationTab.Schedule.index].add(StoreCommonNotifyView(_defaultDatas));

      setState(() {
        loadingState = LoadingState.DONE;
      });
    }
  }

  @override
  void onResponseSuccessPanInfo(Map<String, String> panInfo) {}
}