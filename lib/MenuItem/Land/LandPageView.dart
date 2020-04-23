import 'package:bunyang/Map/MyGoogleMapView.dart';
import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/Land/LandPagePresenter.dart';
import 'package:bunyang/MenuItem/Land/LandSummaryInfoView.dart';
import 'package:bunyang/MenuItem/Land/SupplyDateView.dart';
import 'package:bunyang/MenuItem/Land/SupplyLotOfLandInfoView.dart';
import 'package:bunyang/MenuItem/MenuItemPageView.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';

enum LandPageState { Contents, Infos, Schedule }

class LandPage extends MenuItemPage
{
  LandPage(MenuData data) : super(data);

  @override
  LandPageView createState() => LandPageView(data);
}

class LandPageView extends MenuItemPageView<LandPage>
{
  LandPageView(MenuData data) : super(data)
  {
    tabNames = ['공고내용', '공급정보', '공고일정'];

    for(int i = 0; i < LandPageState.values.length; i++)
    {
      contents[i] = new List<Widget>();
    }
  }
  
  @override
  void makePresenter() 
  {
    presenter = new LandPagePresenter(this);
    presenter.onRequestPanInfo(type, 
      {"PAN_ID" : panId, "CCR_CNNT_SYS_DS_CD" : ccrCnntSysDsCd, "PREVIEW" : "N", 'TMP_PAN_SS' : data.getPanState(),
        "PAN_LOLD_TYPE" : ccrCnntSysDsCd, "TRET_PAN_ID": panId});
  }

  @override
  void onResponseSuccessPanInfo(Map<String, String> panInfo)
  {
    (presenter as LandPagePresenter).onRequestNotice(type, panId, ccrCnntSysDsCd, panInfo["PAN_KD_CD"], panInfo["OTXT_PAN_ID"]);
  }

  void onLoadComplete(Map<String, List<Map<String, String>>> landDatas)
  {
    contents[LandPageState.Contents.index].add(LandSummaryInfoView(landDatas["dsLndInf"].first, landDatas['dsAhtlList']));

    if(landDatas["dsSplInfBidList"].length > 0)
    {
      contents[LandPageState.Schedule.index].add(SupplyDateView(true, landDatas["dsLndInf"].first, landDatas["dsSplScdList"].where((data) => data["RNK_TYPE"] == "01").toList()));
      contents[LandPageState.Infos.index].add(SupplyLotOfLandInfoView(true, landDatas["dsSplInfBidList"]));
    }

    if(landDatas["dsSplInfLtrList"].length > 0)
    {
      contents[LandPageState.Schedule.index].add(SupplyDateView(false, landDatas["dsLndInf"].first, landDatas["dsSplScdList"].where((data) => data["RNK_TYPE"] == "02").toList()));
      contents[LandPageState.Infos.index].add(SupplyLotOfLandInfoView(false, landDatas["dsSplInfLtrList"]));
    }
    
    if(landDatas["dsLndInf"].first["CTRT_PLC_ADR"].isNotEmpty && landDatas["dsLndInf"].first["CTRT_PLC_DTL_ADR"].isNotEmpty)
    {
      StringBuffer addressBuffer = StringBuffer();
      addressBuffer.write(landDatas["dsLndInf"].first["CTRT_PLC_ADR"]);
      addressBuffer.write(" ");
      addressBuffer.write(landDatas["dsLndInf"].first["CTRT_PLC_DTL_ADR"]);

      contents[LandPageState.Schedule.index].add(Container
      (
        padding: EdgeInsets.only(left: 10, right: 10),
        child: MyGoogleMap("계약장소 정보", addressBuffer.toString())
      ));
    }

    if(contents[LandPageState.Schedule.index].length == 0)
      contents[LandPageState.Schedule.index].add(SizedBox());
    if(contents[LandPageState.Infos.index].length == 0)
      contents[LandPageState.Infos.index].add(SizedBox());

    setState(() => loadingState = LoadingState.DONE);
  }

  @override
  void onPressedNotification()
  {
    
  }
}
