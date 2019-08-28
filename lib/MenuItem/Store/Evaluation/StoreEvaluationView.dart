
import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/MenuItemPageView.dart';
import 'package:bunyang/MenuItem/Store/Evaluation/StoreEvaluationPresenter.dart';
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

  @override
  void makePresenter() 
  {
    _presenter = StoreEvaluationPresenter(this);
    _presenter.onRequestData({"PAN_ID" : this.panId, "CCR_CNNT_SYS_DS_CD" : this.ccrCnntSysDsCd, "PAN_GBN" : "LS_SST"});
  }

  void onResponseData(Map<String, List<Map<String, String>>> res)
  {
    res["dsSdgList"].forEach((map)
    {

    });
    _presenter.onRequestSupplyData({"PAN_ID" : this.panId, "CCR_CNNT_SYS_DS_CD" : this.ccrCnntSysDsCd, "SBD_NM": });
  }

  void onResponseSupplyData(Map<String, List<Map<String, String>>> res)
  {

  }

  @override
  void onResponseSuccessPanInfo(Map<String, String> panInfo) {}
}