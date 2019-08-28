import 'package:bunyang/Abstract/TabStateView.dart';
import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/SummaryInfoView.dart';
import 'package:bunyang/MenuItem/Store/Draw/StoreDrawPresenter.dart';
import 'package:bunyang/Util/Util.dart';
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
  List<Map<String, String>> _supplyDatas;
  Map<String, List<Map<String, String>>> _supplyDetailDatas = new Map<String, List<Map<String, String>>>();

  @override
  void makePresenter() 
  {
    _presenter = StoreDrawPresenter(this);
    _presenter.onRequestData({'PAN_ID' : _panId, 'CCR_CNNT_SYS_DS_CD' : _ccrCnntSysDsCd, 'PAN_GBN' : 'LS_SST'});
    _presenter.onRequestAttachment({'PAN_ID' : _panId, 'CCR_CNNT_SYS_DS_CD' : _ccrCnntSysDsCd, 'PAN_GBN' : 'LS_SST'});
  }

  void onResponseData(Map<String, List<Map<String, String>>> res)
  {
    _defaultDatas = res['dsSstInf'].first;
    _supplyDatas = res['dsSdbList'];
    if(_supplyDatas.length > 0)
    {
      _supplyDatas.forEach((map)
      {
        _presenter.onRequestSupplyData({'PAN_ID' : _panId, 'CCR_CNNT_SYS_DS_CD' : _ccrCnntSysDsCd, 'SBD_NM' : map['SBD_NM']});
      });
    }
    else
    {
      checkComplete();
    }
  }

  void onResponseAttachmentData(Map<String, List<Map<String, String>>> res)
  {
    _attachmentDatas = res['dsLsSstAhflList'];
    checkComplete();
  }

  void onResponseSupplyData(Map<String, List<Map<String, String>>> res, String key)
  {
    if(!_supplyDetailDatas.containsKey(key))
      _supplyDetailDatas[key] = List<Map<String, String>>();
    
    _supplyDetailDatas[key] = res['dsSstDhgList'];

    if(_supplyDatas.length == _supplyDetailDatas.length)
      checkComplete();
  }

  void checkComplete()
  {
    if(_supplyDatas != null && _supplyDatas.length > 0)
    {
      if(_defaultDatas != null && _attachmentDatas != null)
      {
        contents[StoreDrawTabState.Infos.index].add(SummaryInfoView(_defaultDatas, _attachmentDatas));

        setState(() {
          loadingState = LoadingState.DONE;
        });
      }
    }
    else
    {
      if(_defaultDatas != null && _attachmentDatas != null)
      {
        contents[StoreDrawTabState.Infos.index].add(SummaryInfoView(_defaultDatas, _attachmentDatas));

        setState(() {
          loadingState = LoadingState.DONE;
        });
      }
    }
  }
}