import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/SummaryInfoView.dart';
import 'package:bunyang/MenuItem/MenuItemPageView.dart';
import 'package:bunyang/MenuItem/Store/Bid/StoreBidPresenter.dart';
import 'package:bunyang/MenuItem/Store/Bid/StoreBidScheduleView.dart';
import 'package:bunyang/MenuItem/Store/Bid/StoreBidSupplyView.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:bunyang/Util/WidgetInsideTabBarView.dart';
import 'package:flutter/material.dart';

enum StoreBidTab { Contents, Infos, Schedule }

class StoreBidView extends MenuItemPage
{
  StoreBidView(MenuData data) : super(data);
  
  @override
  StoreBidViewWidget createState() => StoreBidViewWidget(data);
}

class StoreBidViewWidget extends MenuItemPageView<StoreBidView>
{
  StoreBidViewWidget(MenuData data) : super(data)
  {
    tabNames = ['공고내용', '공급정보', '공고일정'];

    for(int i = 0; i < StoreBidTab.values.length; i++)
    {
      contents[i] = new List<Widget>();
    }
  }

  Map<String, String> _defaultData;
  List<Map<String, String>> _sdgList;
  List<Map<String, String>> _attachmentDatas;
  Map<String, Map<String, String>> _defaultStoreBidDatas = Map<String, Map<String, String>>();

  Map<String, List<Map<String, String>>> _detailStoreDatas = Map<String, List<Map<String, String>>>();
  Map<String, List<Map<String, String>>> _detailStoreElemDatas = Map<String, List<Map<String, String>>>();
  Map<String, Map<String, List<Map<String, String>>>> _detailStoreImageDatas = Map<String, Map<String, List<Map<String, String>>>>();

  @override
  void makePresenter()
  {
    presenter = StoreBidPresenter(this);
    (presenter as StoreBidPresenter).onRequestPanInfo(data.type, 
      {"PAN_ID" : panId, "CCR_CNNT_SYS_DS_CD" : ccrCnntSysDsCd, "TRET_PAN_ID" : panId, "TMP_PAN_SS" : data.panState, "PREVIEW" : "N"});
  }

  @override
  void onResponseSuccessPanInfo(Map<String, String> panInfo) 
  {
    (presenter as StoreBidPresenter).onRequestDefaultData(
      {"PAN_ID": panInfo["PAN_ID"], "CCR_CNNT_SYS_DS_CD" : panInfo["CCR_CNNT_SYS_DS_CD"], "PAN_KD_CD" : panInfo["PAN_KD_CD"],
        "OTXT_PAN_ID" : panInfo["OTXT_PAN_ID"], "TRET_PAN_ID" : panInfo['PAN_ID'], "PREVIEW" : 'N', "TMP_PAN_SS" : data.panState}
    );

    (presenter as StoreBidPresenter).onRequestAttachmentData(
      {"PAN_ID": panInfo["PAN_ID"], "CCR_CNNT_SYS_DS_CD" : panInfo["CCR_CNNT_SYS_DS_CD"], "PAN_KD_CD" : panInfo["PAN_KD_CD"],
        "OTXT_PAN_ID" : panInfo["OTXT_PAN_ID"], "TRET_PAN_ID" : panInfo['PAN_ID'], "PREVIEW" : 'N', "TMP_PAN_SS" : data.panState}
    );
  }
  
  void onResponseDefaultData(Map<String, List<Map<String, String>>> res)
  {
    _defaultData = res['dsSstInf'].first;
    _sdgList = res['dsSdgList'];

    contents[StoreBidTab.Schedule.index].add(StoreBidScheduleView(_defaultData, res['dsSstScdList']));
    if(_sdgList.length > 0)
    {
      _sdgList.forEach((map)
      {
        _defaultStoreBidDatas[map['BZDT_CD']] = map;

        (presenter as StoreBidPresenter).onRequestStoreData(
          {"PAN_ID": map["PAN_ID"], "CCR_CNNT_SYS_DS_CD" : map["CCR_CNNT_SYS_DS_CD"], "PAN_KD_CD" : map["PAN_KD_CD"],
            "OTXT_PAN_ID" : map["OTXT_PAN_ID"], "TRET_PAN_ID" : map['TRET_PAN_ID'], "AIS_INF_SN" : map['AIS_INF_SN'],
            'BZDT_CD' : map['BZDT_CD'], 'HC_BLK_CD' : map['HC_BLK_CD']}
        );

        (presenter as StoreBidPresenter).onRequestStoreElemData(
          {"PAN_ID": map["PAN_ID"], "CCR_CNNT_SYS_DS_CD" : map["CCR_CNNT_SYS_DS_CD"], "PAN_KD_CD" : map["PAN_KD_CD"],
            "OTXT_PAN_ID" : map["OTXT_PAN_ID"], "TRET_PAN_ID" : map['TRET_PAN_ID'], "AIS_INF_SN" : map['AIS_INF_SN'],
            'BZDT_CD' : map['BZDT_CD'], 'HC_BLK_CD' : map['HC_BLK_CD']}
        );
      });
    }
    else
    {
      checkState();
    }
  }

  void onResponseStoreData(String bzdtCd, Map<String, List<Map<String, String>>> res)
  {
    _detailStoreDatas[bzdtCd] = res['dsSstDhgList'];
  }

  void onResponseStoreElemData(String bzdtCd, Map<String, List<Map<String, String>>> res)
  {
    _detailStoreElemDatas[bzdtCd] = res['dsSstDngList'];

    _detailStoreElemDatas[bzdtCd].forEach((map)
    {
      (presenter as StoreBidPresenter).onRequestStoreImageData(
          {"PAN_ID": panId, "CCR_CNNT_SYS_DS_CD" : ccrCnntSysDsCd, "PAN_KD_CD" : _defaultStoreBidDatas[bzdtCd]["PAN_KD_CD"],
            "OTXT_PAN_ID" : _defaultStoreBidDatas[bzdtCd]["OTXT_PAN_ID"], "TRET_PAN_ID" : _defaultStoreBidDatas[bzdtCd]['TRET_PAN_ID'],
            "AIS_INF_SN" : _defaultStoreBidDatas[bzdtCd]['AIS_INF_SN'], 'BZDT_CD' : bzdtCd,
            'HC_BLK_CD' : _defaultStoreBidDatas[bzdtCd]['HC_BLK_CD'], 'DNG_SN' : map['DNG_SN'], 'SBD_NO' : map['SBD_NO']}
        );
    });
  }

  void onResponseStoreImageData(String bzdtCd, String dngSn, String sbdNo, Map<String, List<Map<String, String>>> res)
  {
    _detailStoreImageDatas[bzdtCd] = {'$dngSn$sbdNo': res['dsDngAhflList']};
    checkState();
  }

  void onResponseAttachmentData(Map<String, List<Map<String, String>>> res)
  {
    _attachmentDatas = res['dsAhflList'];
    checkState();
  }

  void checkState()
  {
    if(_defaultStoreBidDatas.length == 0)
    {
      if(_defaultData != null && _attachmentDatas != null)
      {
        contents[StoreBidTab.Contents.index].add(SummaryInfoView(_defaultData, _attachmentDatas));
        setState(() {
          loadingState = LoadingState.DONE;
        });
      }
    }
    else
    {
      if(_defaultStoreBidDatas.length == _detailStoreDatas.length && _defaultStoreBidDatas.length == _detailStoreElemDatas.length 
      && _defaultStoreBidDatas.length == _detailStoreImageDatas.length)
      {
        contents[StoreBidTab.Contents.index].add(SummaryInfoView(_defaultData, _attachmentDatas));
        contents[StoreBidTab.Infos.index].add(WidgetInsideTabBar
        (
          tabNames: _defaultStoreBidDatas.values.map((map) => map['BZDT_NM']).toList(),
          contents: List<Widget>.generate(_sdgList.length, (index)
          {
            return StoreBidSupplyView
            (
              _defaultStoreBidDatas.values.elementAt(index),
              _detailStoreDatas.values.elementAt(index),
              _detailStoreImageDatas.values.elementAt(index),
              _detailStoreElemDatas.values.elementAt(index),
              this.widget.data.getUppAisTPCD()
            ); 
          }),
        ));

        setState(() {
          loadingState = LoadingState.DONE;
        });
      }
    }
  }
}