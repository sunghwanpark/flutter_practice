import 'package:bunyang/Abstract/TabStateView.dart';
import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/SummaryInfoView.dart';
import 'package:bunyang/MenuItem/Store/Draw/StoreDrawPresenter.dart';
import 'package:bunyang/MenuItem/Store/StoreCommonNotifyView.dart';
import 'package:bunyang/MenuItem/Store/StoreCommonScheduleView.dart';
import 'package:bunyang/MenuItem/Store/StoreCommonSupplyData.dart';
import 'package:bunyang/MenuItem/Store/StoreCommonSupplyView.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:bunyang/Util/WidgetInsideTabBarView.dart';
import 'package:flutter/material.dart';

enum StoreDrawTabState { Contents, Infos, Schedule }

class StoreDrawView extends TabStatefull
{
  StoreDrawView(this._data) : super(noticeCode : _data.type, appBarTitle : _data.panName);

  final MenuData _data;

  @override
  StoreDrawWidgetView createState() => StoreDrawWidgetView(_data);
}

class StoreDrawWidgetView extends TabStateView<StoreDrawView>
{
  StoreDrawWidgetView(MenuData data) : this._panId = data.getParameter('PAN_ID'), this._ccrCnntSysDsCd = data.getParameter('CCR_CNNT_SYS_DS_CD')
  {
    tabNames = ['공고내용', '공급정보', '공고일정'];

    for(int i = 0; i < StoreDrawTabState.values.length; i++)
    {
      contents[i] = new List<Widget>();
    }
  }

  final String _panId;
  final String _ccrCnntSysDsCd;

  StoreDrawPresenter _presenter;

  Map<String, String> _defaultDatas;
  List<Map<String, String>> _attachmentDatas;

  Map<String, StoreCommonSupplyData> _supplyDatas = new Map<String, StoreCommonSupplyData>();

  @override
  void makePresenter() 
  {
    _presenter = StoreDrawPresenter(this);
    _presenter.onRequestData({'PAN_ID' : _panId, 'CCR_CNNT_SYS_DS_CD' : _ccrCnntSysDsCd, 'PAN_GBN' : 'LS_SST'});
  }

  void onResponseData(Map<String, List<Map<String, String>>> res)
  {
    _defaultDatas = res['dsSstInf'].first;
    if(res['dsSdgList'].length > 0)
    {
      res['dsSdgList'].forEach((map)
      {
        String key = map['SBD_NM'];
        _supplyDatas[key] = StoreCommonSupplyData();
        _supplyDatas[key].defaultData = map;
        _presenter.onRequestSupplyData({'PAN_ID' : _panId, 'CCR_CNNT_SYS_DS_CD' : _ccrCnntSysDsCd, 'SBD_NM' : key});
      });
    }
    else
    {
      _presenter.onRequestAttachment({'PAN_ID' : _panId, 'CCR_CNNT_SYS_DS_CD' : _ccrCnntSysDsCd, 'PAN_GBN' : 'LS_SST'});
    }
  }

  void onResponseAttachmentData(Map<String, List<Map<String, String>>> res)
  {
    _attachmentDatas = res['dsLsSstAhflList'];
    checkComplete();
  }

  void onResponseSupplyData(Map<String, List<Map<String, String>>> res, String key)
  {
    _supplyDatas[key].supplyDatas = res['dsSstDhgList'];
    var completeChecker = _supplyDatas.values.takeWhile((v) => v.supplyDatas != null);

    if(_supplyDatas.length == completeChecker.length)
      _presenter.onRequestAttachment({'PAN_ID' : _panId, 'CCR_CNNT_SYS_DS_CD' : _ccrCnntSysDsCd, 'PAN_GBN' : 'LS_SST'});
  }

  void checkComplete()
  {
    if(_supplyDatas != null && _supplyDatas.length > 0)
    {
      if(_defaultDatas != null && _attachmentDatas != null)
      {
        contents[StoreDrawTabState.Contents.index].add(SummaryInfoView(_defaultDatas, _attachmentDatas, serialKey: 'AHFL_RGS_SN'));
        contents[StoreDrawTabState.Infos.index].add(WidgetInsideTabBar
        (
          tabNames: List<String>.from(_supplyDatas.keys),
          contents: List<Widget>.generate(_supplyDatas.length, (index)
          {
            return StoreCommonSupplyView(_supplyDatas.entries.elementAt(index).value);
          })
        ));
        contents[StoreDrawTabState.Schedule.index].add(StoreCommonScheduleView(_defaultDatas));
        contents[StoreDrawTabState.Schedule.index].add(StoreCommonNotifyView(_defaultDatas));

        setState(() {
          loadingState = LoadingState.DONE;
        });
      }
    }
    else
    {
      if(_defaultDatas != null && _attachmentDatas != null)
      {
        contents[StoreDrawTabState.Contents.index].add(SummaryInfoView(_defaultDatas, _attachmentDatas, serialKey: 'AHFL_RGS_SN'));
        contents[StoreDrawTabState.Schedule.index].add(StoreCommonScheduleView(_defaultDatas));
        contents[StoreDrawTabState.Schedule.index].add(StoreCommonNotifyView(_defaultDatas));

        setState(() {
          loadingState = LoadingState.DONE;
        });
      }
    }
  }
}