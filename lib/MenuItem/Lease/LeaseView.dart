import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/IntallmentChangeSale/ChargeSaleSummaryInfoView.dart';
import 'package:bunyang/MenuItem/Lease/LeaseMoreInfoView.dart';
import 'package:bunyang/MenuItem/Lease/LeasePresenter.dart';
import 'package:bunyang/MenuItem/Lease/LeaseRentalSupplyView.dart';
import 'package:bunyang/MenuItem/Lease/LeaseScheduleView.dart';
import 'package:bunyang/MenuItem/Lease/LeaseSupplyView.dart';
import 'package:bunyang/MenuItem/MenuItemPageView.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';

enum LeaseState { Contents, Infos, Schedule, LeaseInfo }

class LeaseView extends MenuItemPage
{
  LeaseView(MenuData data) : super(data);
  
  @override
  LeaseViewWidget createState() => LeaseViewWidget(data);
}

class LeaseViewWidget extends MenuItemPageView<LeaseView>
{
  LeaseViewWidget(MenuData data) : super(data)
  {
    tabNames = ['공고개요', '공급정보', '공급일정', '임대정보'];

    for(int i = 0; i < LeaseState.values.length; i++)
    {
      contents[i] = List<Widget>();
    }
  }

  LeasePresenter _presenter;
  Map<String, List<Map<String, String>>> _defaultDatas;
  List<Map<String, String>> _dsList;

  @override
  void makePresenter()
  {
    _presenter = LeasePresenter(this);
    _presenter.onRequestData(panId, ccrCnntSysDsCd);
  }

  void onResponseData(Map<String, List<Map<String, String>>> res)
  {
    _defaultDatas = res;

    contents[LeaseState.Contents.index].add(ChargeSaleSummaryInfoView(res));
    contents[LeaseState.Schedule.index].add(LeaseScheduleView(res));
    contents[LeaseState.LeaseInfo.index].add(LeaseMoreInfoView(res));

    if(res.containsKey('dsLohTpCdInf') && res['dsLohTpCdInf'].first['LOH_TP_CD'].isNotEmpty)
    {
      _presenter.onRequestRentalLeaseMoreData(panId, ccrCnntSysDsCd, res['dsLohTpCdInf'].first['LOH_TP_CD']);
    }
    else
    {
      _presenter.onRequestMoreData(panId, ccrCnntSysDsCd, res['dsSplScdInf'].first['LTR_UNT_NO'], res['dsSplScdInf'].first['LTR_NOT'], 
        res['dsPanInf'].first['LTRM_NLE_YN']);
    }
  }

  void onResponseMoreData(Map<String, List<Map<String, String>>> res)
  {
    contents[LeaseState.Infos.index].add(LeaseSupplyView(_defaultDatas, res));
    setState(() {
      loadingState = LoadingState.DONE;
    });
  }

  void onResponseRentalLeaseMoreData(Map<String, List<Map<String, String>>> res)
  {
    _dsList = res['dsList'];
    _presenter.onRequestRentalLeaseStTypeData(panId, ccrCnntSysDsCd, _defaultDatas['dsLohTpCdInf'].first['LOH_TP_CD']);
  }

  void onResponseRentalLeaseStTypeData(Map<String, List<Map<String, String>>> res)
  {
    contents[LeaseState.Infos.index].add(LeaseRentalSupplyView(_defaultDatas, _dsList, res['dsList']));
    setState(() {
      loadingState = LoadingState.DONE;
    });
  }

  @override
  void onPressedNotification()
  {
    
  }

  @override
  void onResponseSuccessPanInfo(Map<String, String> panInfo) {}  
}